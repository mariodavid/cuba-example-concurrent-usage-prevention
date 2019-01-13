package com.rtcab.cepl.web.customer;

import com.haulmont.cuba.core.app.LockService;
import com.haulmont.cuba.core.global.LockInfo;
import com.haulmont.cuba.gui.WindowParam;
import com.haulmont.cuba.gui.components.AbstractWindow;
import com.rtcab.cepl.entity.Customer;
import javax.inject.Inject;

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

  private String customerId(Customer customer) {
    return customer.getId().toString();
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

  public void closeInteraction() {
    close(CLOSE_ACTION_ID);
  }

}