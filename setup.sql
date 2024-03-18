alter session set "_ORACLE_SCRIPT"=true;

drop tablespace glpi;

create tablespace glpi 
datafile 'C:\Oracle\21c\oradata\XE\glpi.DBF' 
size 500M;

drop user glpiadmin;

create user glpiadmin 
identified by admin 
default tablespace users;

grant dba to glpiadmin;



-------------- TABLES --------------

create table GLPI_GROUP
(
    ID NUMBER not null,
    constraint GLPI_GROUP_PK
        primary key (ID)
) TABLESPACE GLPI;

create table JOURNAL
(
    ID NUMBER not null,
    constraint JOURNAL_PK
        primary key (ID)
) TABLESPACE GLPI;

create table GLPI_INVENTORY
(
    ID        NUMBER       not null,
    REFERENCE VARCHAR(200) not null,
    QUANTITY  NUMBER default 0,
    constraint GLPI_INVENTORY_PK
        primary key (ID),
    constraint QUANTITY_POSITIVE
        check (quantity >= 0)
) TABLESPACE GLPI;

create table GLPI_USER
(
    ID           NUMBER not null,
    NAME         VARCHAR(50),
    EMAIL        VARCHAR(50),
    LOCATION     VARCHAR(16),
    GROUP_ID     NUMBER,
    JOURNAL_ID   NUMBER,
    INVENTORY_ID NUMBER,
    constraint GLPI_USER_PK
        primary key (ID),
    constraint GLPI_USER_GLPI_GROUP_ID_FK
        foreign key (GROUP_ID) references GLPI_GROUP,
    constraint GLPI_USER_GLPI_INVENTORY_ID_FK
        foreign key (INVENTORY_ID) references GLPI_INVENTORY,
    constraint GLPI_USER_JOURNAL_ID_FK
        foreign key (JOURNAL_ID) references JOURNAL,
    constraint LOCATION_ENUM
        check (location in ('Cergy', 'Pau'))
) TABLESPACE GLPI;

create table GLPI_TICKET
(
    ID           NUMBER      not null,
    TYPE         VARCHAR(16) not null,
    CATEGORY     VARCHAR(16) not null,
    IMPACT       VARCHAR(16) not null,
    URGENCY      VARCHAR(16) not null,
    PRIORITY     VARCHAR(16),
    STATUS       VARCHAR(16),
    LOCATION     VARCHAR(16),
    TITLE        VARCHAR(100),
    DESCRIPTION  VARCHAR(4000),
    DATE_CREATED TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    DATE_UPDATED DATE,
    DATE_CLOSED  DATE,
    OWNER_ID     NUMBER not null ,
    OPERATOR_ID  NUMBER,
    constraint TABLE_NAME_PK
        primary key (ID),
    constraint GLPI_TICKET_GLPI_USER_ID_FK
        foreign key (OPERATOR_ID) references GLPI_USER,
    constraint GLPI_TICKET_GLPI_USER_ID_FK_2
        foreign key (OWNER_ID) references GLPI_USER,
    constraint CATEGORY_ENUM
        check (category in ('Software', 'Hardware', 'Network', 'Others')),
    constraint IMPACT_ENUM
        check (impact in ('Low', 'Medium', 'High')),
    constraint LOCATION_CHECK
        check (location in ('Cergy', 'Pau')),
    constraint PRIORITY_ENUM
        check (priority in ('Low', 'Medium', 'High')),
    constraint STATUS_ENUM
        check (status in ('Created', 'Waiting', 'Attributed', 'Resolved', 'Closed', 'Deleted')),
    constraint TYPE_ENUM
        check (type in ('Incident', 'Request')),
    constraint URGENCY_ENUM
        check (urgency in ('Low', 'Medium', 'High'))
) TABLESPACE GLPI;

create table GLPI_TICKET_TASK
(
    ID           NUMBER not null,
    DATE_CREATED DATE,
    DESCRIPTION  VARCHAR(500),
    constraint GLPI_TICKET_TASK_PK
        primary key (ID)
) TABLESPACE GLPI;

create table GLPI_TICKET_SOLUTION
(
    ID           NUMBER not null,
    DATE_CREATED DATE,
    DESCRIPTION  VARCHAR(500),
    APPROVAL     NUMBER(1) default 0,
    constraint GLPI_TICKET_SOLUTION_PK
        primary key (ID),
    constraint APPROVAL_BOOLEAN
        check (approval in (0, 1))
) TABLESPACE GLPI;

create table LIST_TICKET_SOLUTION
(
    ID_TICKET          NUMBER,
    ID_TICKET_SOLUTION NUMBER,
    constraint LIST_TICKET_SOLUTION_GLPI_TICKET_ID_FK
        foreign key (ID_TICKET) references GLPI_TICKET,
    constraint LIST_TICKET_SOLUTION_GLPI_TICKET_SOLUTION_ID_FK
        foreign key (ID_TICKET_SOLUTION) references GLPI_TICKET_SOLUTION
) TABLESPACE GLPI;

create table LIST_TICKET_TASK
(
    ID_TICKET      NUMBER,
    ID_TICKET_TASK NUMBER,
    constraint LIST_TICKET_TASK_GLPI_TICKET_ID_FK
        foreign key (ID_TICKET) references GLPI_TICKET,
    constraint LIST_TICKET_TASK_GLPI_TICKET_TASK_ID_FK
        foreign key (ID_TICKET_TASK) references GLPI_TICKET_TASK
) TABLESPACE GLPI;

CREATE TABLE GLPI_NOTIFICATION
(
    ID NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY START WITH 1 PRIMARY KEY, -- ID de la notification
    USER_ID NUMBER NOT NULL, -- ID de l'utilisateur
    OPERATOR_ID  NUMBER, -- ID de l'opérateur
    TICKET_ID NUMBER NOT NULL, -- ID du ticket
    MESSAGE VARCHAR2(255), -- Message de la notification
    DATE_CREATED TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Date de création de la notification
    STATUS VARCHAR2(20) DEFAULT 'Attente', -- Valeurs : 'Attente', 'traitée', 'échouée'
    CONSTRAINT FK_GLPI_NOTIFICATION_USER_ID FOREIGN KEY (USER_ID) REFERENCES GLPI_USER(ID), -- Clé étrangère vers la table GLPI_USER
    CONSTRAINT FK_GLPI_NOTIFICATION_OPERATOR_ID FOREIGN KEY (OPERATOR_ID) REFERENCES GLPI_USER(ID), -- Clé étrangère vers la table GLPI_USER
    CONSTRAINT FK_GLPI_NOTIFICATION_TICKET_ID FOREIGN KEY (TICKET_ID) REFERENCES GLPI_TICKET(ID) -- Clé étrangère vers la table GLPI_TICKET
) TABLESPACE GLPI;