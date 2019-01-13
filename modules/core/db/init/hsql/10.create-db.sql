-- begin CEPL_CUSTOMER
create table CEPL_CUSTOMER (
    ID varchar(36) not null,
    VERSION integer not null,
    CREATE_TS timestamp,
    CREATED_BY varchar(50),
    UPDATE_TS timestamp,
    UPDATED_BY varchar(50),
    DELETE_TS timestamp,
    DELETED_BY varchar(50),
    --
    CUSTOMER_ID varchar(255) not null,
    NAME varchar(255) not null,
    FIRST_NAME varchar(255),
    EMAIL varchar(255),
    --
    primary key (ID)
)^
-- end CEPL_CUSTOMER
-- begin CEPL_ORDER
create table CEPL_ORDER (
    ID varchar(36) not null,
    VERSION integer not null,
    CREATE_TS timestamp,
    CREATED_BY varchar(50),
    UPDATE_TS timestamp,
    UPDATED_BY varchar(50),
    DELETE_TS timestamp,
    DELETED_BY varchar(50),
    --
    ORDER_DATE date not null,
    CUSTOMER_ID varchar(36) not null,
    --
    primary key (ID)
)^
-- end CEPL_ORDER
-- begin CEPL_LINE_ITEM
create table CEPL_LINE_ITEM (
    ID varchar(36) not null,
    VERSION integer not null,
    CREATE_TS timestamp,
    CREATED_BY varchar(50),
    UPDATE_TS timestamp,
    UPDATED_BY varchar(50),
    DELETE_TS timestamp,
    DELETED_BY varchar(50),
    --
    NUMBER_ integer not null,
    ORDER_ID varchar(36) not null,
    PRODUCT_ID varchar(36) not null,
    PRICE decimal(19, 2) not null,
    --
    primary key (ID)
)^
-- end CEPL_LINE_ITEM
-- begin CEPL_PRODUCT
create table CEPL_PRODUCT (
    ID varchar(36) not null,
    VERSION integer not null,
    CREATE_TS timestamp,
    CREATED_BY varchar(50),
    UPDATE_TS timestamp,
    UPDATED_BY varchar(50),
    DELETE_TS timestamp,
    DELETED_BY varchar(50),
    --
    NAME varchar(255),
    --
    primary key (ID)
)^
-- end CEPL_PRODUCT
