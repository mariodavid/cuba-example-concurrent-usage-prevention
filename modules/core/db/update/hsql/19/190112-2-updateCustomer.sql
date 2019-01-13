alter table CECUP_CUSTOMER add column CUSTOMER_ID integer ^
update CECUP_CUSTOMER set CUSTOMER_ID = 0 where CUSTOMER_ID is null ;
alter table CECUP_CUSTOMER alter column CUSTOMER_ID set not null ;
