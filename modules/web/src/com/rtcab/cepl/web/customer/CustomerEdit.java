package com.rtcab.cepl.web.customer;

import com.haulmont.cuba.core.app.LockService;
import com.haulmont.cuba.core.app.UniqueNumbersService;
import com.haulmont.cuba.core.global.LockInfo;
import com.haulmont.cuba.gui.components.AbstractEditor;
import com.rtcab.cepl.entity.Customer;
import java.util.List;
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