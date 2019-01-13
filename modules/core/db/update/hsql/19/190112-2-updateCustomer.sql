alter table CEPL_CUSTOMER add column CUSTOMER_ID integer ^
update CEPL_CUSTOMER set CUSTOMER_ID = 0 where CUSTOMER_ID is null ;
alter table CEPL_CUSTOMER alter column CUSTOMER_ID set not null ;
