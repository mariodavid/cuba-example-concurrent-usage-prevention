package com.rtcab.cecup.web.customer;

import com.haulmont.bali.util.ParamsMap;
import com.haulmont.cuba.gui.WindowManager.OpenType;
import com.haulmont.cuba.gui.components.AbstractLookup;
import com.haulmont.cuba.gui.components.GroupTable;
import com.rtcab.cecup.entity.Customer;
import javax.inject.Inject;

public class CustomerBrowse extends AbstractLookup {


  @Inject
  protected GroupTable<Customer> customersTable;

  public void createCustomerSupportTicketCaption() {

    Customer customer = customersTable.getSingleSelected();

    openWindow("customer-support-ticket", OpenType.DIALOG, ParamsMap.of("customer", customer));
  }
}