package com.rtcab.cecup.web.order;

import com.haulmont.cuba.core.app.LockService;
import com.haulmont.cuba.core.global.LockInfo;
import com.haulmont.cuba.gui.components.AbstractLookup;
import com.haulmont.cuba.gui.components.GroupTable;
import com.rtcab.cecup.entity.Customer;
import com.rtcab.cecup.entity.Order;
import javax.inject.Inject;

public class OrderBrowse extends AbstractLookup {


  @Inject
  protected LockService lockService;

  @Inject
  protected GroupTable<Order> ordersTable;


  public void createInvoice() {

    Customer customer = getSelectedOrder().getCustomer();
    LockInfo customerLock = tryToAcquireCustomerLock(customer);


    if (customerIsAlreadyLocked(customerLock)) {
      showCustomerLockedWarning(customerLock);
    }
    else {
      startOrderInvoiceProcess();
      unlockCustomer(customer);
    }
  }

  private void showCustomerLockedWarning(LockInfo customerLock) {
    String currentlyUserHavingLock = customerLock.getUser()
        .getInstanceName();
    String message = "Customer of this Order is already in use by " + currentlyUserHavingLock;
    showNotification(message, NotificationType.WARNING);
  }

  private Order getSelectedOrder() {
    return ordersTable.getSingleSelected();
  }

  private boolean customerIsAlreadyLocked(LockInfo customerLock) {
    return customerLock != null;
  }

  private LockInfo tryToAcquireCustomerLock(Customer customer) {
    return lockService.lock(customer);
  }

  private void unlockCustomer(Customer customer) {
    lockService.unlock(customer);
  }

  private void startOrderInvoiceProcess() {
    Double earnedAmount = getSelectedOrder().getTotalAmount();

    String message =
        "Invoice send out per Email. Customers credit card charged. You earned " + earnedAmount + " EUR...!";

    showNotification(message);
  }

}