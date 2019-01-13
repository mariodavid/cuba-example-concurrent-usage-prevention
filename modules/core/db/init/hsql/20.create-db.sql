-- begin CEPL_ORDER
alter table CEPL_ORDER add constraint FK_CEPL_ORDER_ON_CUSTOMER foreign key (CUSTOMER_ID) references CEPL_CUSTOMER(ID)^
create index IDX_CEPL_ORDER_ON_CUSTOMER on CEPL_ORDER (CUSTOMER_ID)^
-- end CEPL_ORDER
-- begin CEPL_LINE_ITEM
alter table CEPL_LINE_ITEM add constraint FK_CEPL_LINE_ITEM_ON_ORDER foreign key (ORDER_ID) references CEPL_ORDER(ID)^
alter table CEPL_LINE_ITEM add constraint FK_CEPL_LINE_ITEM_ON_PRODUCT foreign key (PRODUCT_ID) references CEPL_PRODUCT(ID)^
create index IDX_CEPL_LINE_ITEM_ON_ORDER on CEPL_LINE_ITEM (ORDER_ID)^
create index IDX_CEPL_LINE_ITEM_ON_PRODUCT on CEPL_LINE_ITEM (PRODUCT_ID)^
-- end CEPL_LINE_ITEM
