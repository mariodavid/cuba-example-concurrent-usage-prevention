alter table CECUP_CUSTOMER alter column CUSTOMER_ID rename to CUSTOMER_ID__U38861 ^
alter table CECUP_CUSTOMER alter column CUSTOMER_ID__U38861 set null ;
alter table CECUP_CUSTOMER add column CUSTOMER_ID varchar(255) ^
update CECUP_CUSTOMER set CUSTOMER_ID = '' where CUSTOMER_ID is null ;
alter table CECUP_CUSTOMER alter column CUSTOMER_ID set not null ;
