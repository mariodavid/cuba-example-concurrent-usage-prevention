# CUBA example: Concurrent usage prevention with Locks

This example shows how to use CUBAs different possibilities to prohibit concurrent usage of resources (like entities).

Sometimes certain resources of an application like a particular entity or even more general a particular part of the application should only accessed by one particular user or the system itself at a time in order to prevent the following situation (called lost update problem in DB terms):

## Scenario: Lost update of Customer data for `Zapp Brannigan`

1. `10:30`: Customer `Zapp Brannigan` sends an email in order to inform about his marriage with `Kif Kroker`. Therefore he wants to update his last name to `Kroker-Brannigan`
2. `10:35`: User `leia` reads the email and opens the email and also the Customer screen from `Zapp Brannigan`. Directly after that her boss - `Jabba the Hutt` calls her in for a urgent task. She leaves the customer details screen open. 
3. `10:40`: `Zapp` calls the hotline, because the marriage did not last long and is already gone. But as he found this lovely girl `Amy Wong` - he now wants to update his name to `Wong` because they are in love. User `luke` accepts the request as he does not know anything about the previous email, opens the Customer screen and changes the name to `Zapp Wong`.
4. `10:50`: User `leia` is back on her desk and wants to finish her task of updating `Zapp Brannigan` to `Bareny Kroker-Brannigan`. As she has the customer screen already open, she just changes the name and saves it.

Let's look at the data that has been stored in the system:

1. `10:30` - Customer `Zapp Brannigan`
2. `10:40` - Customer `Zapp Wong`
3. `10:50` - Customer `Zapp Kroker-Brannigan`

As we have seen from the interactions with `Zapp` what is finally stored in the system is wrong and does not reflect the real world as the final name should be `Zapp Wong` instead of `Zapp Kroker-Brannigan`.

In order to solve this scenario, there are some established techniques. CUBA offers the following options:

* optimistic locking
* pessimistic locking
* entity log

In this example we will go through the different locking options.

## Overview

Here is an overview of the functionality of the different examples for the different locking solutions within a CUBA application:

![overview](https://github.com/mariodavid/cuba-example-concurrent-usage-prevention/blob/master/img/overview.gif)


## Optimistic locking

Optimistic locking is enabled by default for all entities in CUBA and is the standard solution to this problem. The way it works looks like this:

In this example it is implemented for the entity: `Product`. `Product` contains an attribute called `version` which is a counter. It is incremented each time a particular entity is created / updated.

When a user opens the product details screen in order to update a particular product, the current value of the `version` attribute is also received in the screen. In case of the above example with the Customer entity an optimistic locking would look like this:

1. before `10:30`: Customer `Zapp Brannigan` - version `1`
2. at `10:35`: `leia` reads the customer with version `1`
3. at `10:40`: `luke` reads the customer with version `1` and stores the customer. The version attribute is updated to value `2`.
4. at `10:50`: `leia` wants to write the customer with the one she read at `10:35` with version `1`. On storing the new data for the Customer CUBA will throw a particular exception: `OptimisticLockException`, because the version in the DB is already `2` (from `10:35`) and now `leia` wants to store information with a current version of `1`. This prevents `leia` from storing the values based on old data.

The resulting UI for an optimistic locking exception looks like this:

![automatic-optimistic-entity-lock](https://github.com/mariodavid/cuba-example-concurrent-usage-prevention/blob/master/img/automatic-optimistic-entity-lock.png)

The user has to manually reload the customer and based on the new data decide, which action to take and ultimately which data to persist.

The reason why it is called `optimistic` is because this strategy is optimistic in the sense that concurrent reads are treated as a normal interaction. Only at the last possible point it throws an exception to prevent potential wrong data storage.

The difference to the pessimistic locking is that optimistic locking allows to open different reads of the resource and also leads the user to believe
that concurrent updates would be possible by the fact that CUBA shows the normal screen editor for the entity without any restrictions. Only if the user(s) actually do the concurrent change, the system will prevent this.

More information on optimistic locking can be found here:

* [optimistic concurrency control (wikipedia)](https://en.wikipedia.org/wiki/Optimistic_concurrency_control)

## Pessimistic locking

Sometimes the optimistic locking approach is not appropriate because the system should not lead the user to believe that such operations are possible. In this case, the pessimistic locking approach is better suited. 

In this case, the user is informed upfront, that another user is doing the wished operation (like changing the customer). This enforces the user to deal with a potential problem upfront. In the above `Zapp Brannigan` scenario, `luke` would have been informed when opening the Customer editor screen with the information, that `leia` is already trying to change the customer and would prevent `luke` from changing the customer all together.

This approach is a little bit more "secure" but also leads to a lot of "false negatives".


### automatic pessimistic locking for entity editors

CUBA offers automatic pessimistic locking for entity editors. It sets the editor in a read-only mode so that no changes to the entity are possible once one user opened the editor.

In order to activate this behavior a runtime configuration needs to be in place on a per-entity basis. CUBA offers a management UI under `Administration > Locks > Setup`:


![current-lock-configurations](https://github.com/mariodavid/cuba-example-concurrent-usage-prevention/blob/master/img/current-lock-configurations.png)


The resulting UI of the automatic pessimistic locking approach for the customer editor looks like this:

![automatic-pessimistic-entity-lock](https://github.com/mariodavid/cuba-example-concurrent-usage-prevention/blob/master/img/automatic-pessimistic-entity-lock.png)



### Lock overview

Normally locks have to be released once the operation is done. This in the case of the automatic pessimistic locking of CUBA happens when the user closes the entity editor. Unfortunately this is not always possible, because the user does not close the editor and closes the laptop e.g. This leads to open locks, that are not released. 

Therefore the locks have to have a timeout configured after that the system will automatically resolve the locks in order to prevent locking of particular data forever.

CUBA additionally allows the administrator of the system to look at the current locks and also release them manually in case such a scenario occurs. This is useful when the timeout of the lock is not yet over, but the user wants to get access to the data.


![current-locks](https://github.com/mariodavid/cuba-example-concurrent-usage-prevention/blob/master/img/current-locks.png)


### Custom pessimistic locking

It is also possible to use custom pessimistic locks programmatically. This is sometimes necessary when your lock should not be based on an entity instance. It also requires to configure a lock via the CUBA management UI. In this example it is configured for the name `customer-support-ticket`.

![custom-lock](https://github.com/mariodavid/cuba-example-concurrent-usage-prevention/blob/master/img/custom-lock.png).

For programmatically accessing the pessimistic locking functionality of CUBA, there are the two interaction points `LockManagerAPI` for the backend as well as `LockService` for the web layer (e.g. UI controllers). In the `CustomerSupportTicket` screen, the `LockService` is used in order to prevent creating support tickets for the same customer. It is done via the custom pessimistic lock with the name `customer-support-ticket`: `lockService.lock(CUSTOMER_SUPPORT_LOCK_NAME, customerId(customer))`.

```
public class CustomerSupportTicket extends AbstractWindow {

  private final String CUSTOMER_SUPPORT_LOCK_NAME = "customer-support-ticket";

  @Inject
  protected LockService lockService;

  @WindowParam
  Customer customer;


  @Override
  public void ready() {

    LockInfo customerSupportTicketLock = tryToAcquireCustomerSupportTicketLock(customer);

    if (customerSupportTicketIsAlreadyLocked(customerSupportTicketLock)) {
      showCustomerSupportTicketLockedWarning(customerSupportTicketLock);
      close(CLOSE_ACTION_ID, true);
    }
  }

  private void showCustomerSupportTicketLockedWarning(LockInfo lockInfo) {
    String currentlyUserHavingLock = lockInfo.getUser()
        .getInstanceName();
    String message = "Customer Support Ticket is already in use by: " + currentlyUserHavingLock;
    showNotification(message, NotificationType.WARNING);
  }

  private boolean customerSupportTicketIsAlreadyLocked(LockInfo customerLock) {
    return customerLock != null;
  }

  private LockInfo tryToAcquireCustomerSupportTicketLock(Customer customer) {
    return lockService.lock(CUSTOMER_SUPPORT_LOCK_NAME, customerId(customer));
  }

  private void unlockCustomerSupportTicket(Customer customer) {
    lockService.unlock(CUSTOMER_SUPPORT_LOCK_NAME, customerId(customer));
  }

  @Override
  protected boolean preClose(String actionId) {
    unlockCustomerSupportTicket(customer);

    return true;
  }


  public void printInteraction() {
    showNotification("Ticket send to printer...");
  }

}
``` 

The resulting UI in case of a simultaneous access looks like this:

![custom-lock.png](https://github.com/mariodavid/cuba-example-concurrent-usage-prevention/blob/master/img/custom-lock.png)
 