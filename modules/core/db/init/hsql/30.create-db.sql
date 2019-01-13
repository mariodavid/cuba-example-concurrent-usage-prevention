-- entity pessimistic locking configuration

insert into SYS_LOCK_CONFIG
(ID, CREATE_TS, CREATED_BY, NAME, TIMEOUT_SEC)
values ('30531104-8d8f-167d-8db2-f1a783f0ad97', '2019-01-12 18:23:58', 'admin', 'cecup$Customer', 300);


-- custom pessimistic locking configuration
insert into SYS_LOCK_CONFIG
(ID, CREATE_TS, CREATED_BY, NAME, TIMEOUT_SEC)
values ('bd98a711-f2c2-4a26-0546-6999d37eb198', '2019-01-13 10:18:03', 'admin', 'customer-support-ticket', 300);


-- Users

-- Leia (password: leia)
insert into SEC_USER
(ID, VERSION, CREATE_TS, CREATED_BY, UPDATE_TS, UPDATED_BY, DELETE_TS, DELETED_BY, LOGIN, LOGIN_LC, PASSWORD, NAME, FIRST_NAME, LAST_NAME, MIDDLE_NAME, POSITION_, EMAIL, LANGUAGE_, TIME_ZONE, TIME_ZONE_AUTO, ACTIVE, CHANGE_PASSWORD_AT_LOGON, GROUP_ID, IP_MASK)
values ('470ee0c7-958f-a8df-4aeb-722755f9336b', 2, '2019-01-13 10:25:54', 'luke', '2019-01-13 10:28:43', 'leia', null, null, 'leia', 'leia', '9ee9006f563a8249cdb87512695fcb744dc90b44', 'Leia Organa of Alderaan', 'Leia', 'Organa of Alderaan', null, null, null, 'en', null, false, true, false, '0fa2b1a5-1d68-4d69-9fbd-dff348347f93', null);

insert into SEC_USER_ROLE
(ID, VERSION, CREATE_TS, CREATED_BY, UPDATE_TS, UPDATED_BY, DELETE_TS, DELETED_BY, USER_ID, ROLE_ID)
values ('b2fe0ee6-5e2f-d990-2b2f-a74a4cc6ef8c', 1, '2019-01-13 10:25:54', 'luke', '2019-01-13 10:25:54', null, null, null, '470ee0c7-958f-a8df-4aeb-722755f9336b', '0c018061-b26f-4de2-a5be-dff348347f93');


-- Luke (password: luke)
insert into SEC_USER
(ID, VERSION, CREATE_TS, CREATED_BY, UPDATE_TS, UPDATED_BY, DELETE_TS, DELETED_BY, LOGIN, LOGIN_LC, PASSWORD, NAME, FIRST_NAME, LAST_NAME, MIDDLE_NAME, POSITION_, EMAIL, LANGUAGE_, TIME_ZONE, TIME_ZONE_AUTO, ACTIVE, CHANGE_PASSWORD_AT_LOGON, GROUP_ID, IP_MASK)
values ('5ae31ad5-9c3d-ceeb-d29c-b079ec64d279', 2, '2019-01-13 10:23:22', 'admin', '2019-01-13 10:23:43', 'luke', null, null, 'luke', 'luke', 'e12058d191d24ea4c1b380d582e6af72bc4fe9ef', 'Luke Skywalker', 'Luke', 'Skywalker', null, null, null, 'en', null, false, true, false, '0fa2b1a5-1d68-4d69-9fbd-dff348347f93', null);

insert into SEC_USER_ROLE
(ID, VERSION, CREATE_TS, CREATED_BY, UPDATE_TS, UPDATED_BY, DELETE_TS, DELETED_BY, USER_ID, ROLE_ID)
values ('9ca7d548-ce23-f012-24c3-707b5f4dc1ca', 1, '2019-01-13 10:23:22', 'admin', '2019-01-13 10:23:22', null, null, null, '5ae31ad5-9c3d-ceeb-d29c-b079ec64d279', '0c018061-b26f-4de2-a5be-dff348347f93');