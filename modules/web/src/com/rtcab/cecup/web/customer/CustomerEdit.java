package com.rtcab.cecup.web.customer;

import com.haulmont.cuba.core.app.UniqueNumbersService;
import com.haulmont.cuba.gui.components.AbstractEditor;
import com.rtcab.cecup.entity.Customer;
import javax.inject.Inject;

public class CustomerEdit extends AbstractEditor<Customer> {


  @Inject
  protected UniqueNumbersService uniqueNumbersService;

  @Override
  protected void initNewItem(Customer item) {
    super.initNewItem(item);

    initCustomerId(item);

  }

  private void initCustomerId(Customer item) {
    long nextCustomerId = uniqueNumbersService.getNextNumber("customers");
    item.setCustomerId(String.format("%08d", nextCustomerId));
  }

}