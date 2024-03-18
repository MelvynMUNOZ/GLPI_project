-------------- DROPS --------------

DROP TABLE GLPI_GROUP CASCADE CONSTRAINTS;
DROP TABLE GLPI_JOURNAL CASCADE CONSTRAINTS;
DROP TABLE GLPI_INVENTORY CASCADE CONSTRAINTS;
DROP TABLE GLPI_USER CASCADE CONSTRAINTS;
DROP TABLE GLPI_TICKET CASCADE CONSTRAINTS;
DROP TABLE GLPI_TICKET_TASK CASCADE CONSTRAINTS;
DROP TABLE GLPI_TICKET_SOLUTION CASCADE CONSTRAINTS;
DROP TABLE LIST_TICKET_TASK CASCADE CONSTRAINTS;
DROP TABLE LIST_TICKET_SOLUTION CASCADE CONSTRAINTS;
DROP TABLE GLPI_NOTIFICATION CASCADE CONSTRAINTS;


-------------- TABLES --------------

CREATE TABLE GLPI_GROUP
(
    ID VARCHAR2(16) not null,
    constraint GLPI_GROUP_PK
        primary key (ID)
) TABLESPACE GLPI;


CREATE TABLE GLPI_JOURNAL
(
    ID VARCHAR2(16) not null,
    constraint GLPI_JOURNAL_PK
        primary key (ID)
) TABLESPACE GLPI;


CREATE TABLE GLPI_INVENTORY
(
    ID        VARCHAR2(16)  not null,
    REFERENCE VARCHAR2(200) not null,
    QUANTITY  NUMBER default 0,
    constraint GLPI_INVENTORY_PK
        primary key (ID),
    constraint QUANTITY_POSITIVE
        check (quantity >= 0)
) TABLESPACE GLPI;


CREATE TABLE GLPI_USER
(
    ID           VARCHAR2(16) not null,
    NAME         VARCHAR2(50),
    EMAIL        VARCHAR2(50),
    LOCATION     VARCHAR2(16),
    GROUP_ID     VARCHAR2(16),
    JOURNAL_ID   VARCHAR2(16),
    INVENTORY_ID VARCHAR2(16),
    constraint GLPI_USER_PK
        primary key (ID),
    constraint GLPI_USER_GLPI_GROUP_ID_FK
        foreign key (GROUP_ID) references GLPI_GROUP,
    constraint GLPI_USER_GLPI_INVENTORY_ID_FK
        foreign key (INVENTORY_ID) references GLPI_INVENTORY,
    constraint GLPI_USER_GLPI_JOURNAL_ID_FK
        foreign key (JOURNAL_ID) references GLPI_JOURNAL,
    constraint LOCATION_ENUM
        check (location in ('Cergy', 'Pau'))
) TABLESPACE GLPI;


CREATE TABLE GLPI_TICKET
(
    ID           VARCHAR2(16) not null,
    TYPE         VARCHAR2(16) not null,
    CATEGORY     VARCHAR2(16) not null,
    IMPACT       VARCHAR2(16) not null,
    URGENCY      VARCHAR2(16) not null,
    PRIORITY     VARCHAR2(16),
    STATUS       VARCHAR2(16),
    LOCATION     VARCHAR2(16),
    TITLE        VARCHAR2(100),
    DESCRIPTION  VARCHAR2(4000),
    DATE_CREATED TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    DATE_UPDATED DATE,
    DATE_CLOSED  DATE,
    OWNER_ID     VARCHAR2(16) not null ,
    OPERATOR_ID  VARCHAR2(16),
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


CREATE TABLE GLPI_TICKET_TASK
(
    ID           VARCHAR2(16) not null,
    DATE_CREATED DATE,
    DESCRIPTION  VARCHAR2(500),
    constraint GLPI_TICKET_TASK_PK
        primary key (ID)
) TABLESPACE GLPI;


CREATE TABLE GLPI_TICKET_SOLUTION
(
    ID           VARCHAR2(16) not null,
    DATE_CREATED DATE,
    DESCRIPTION  VARCHAR2(500),
    APPROVAL     NUMBER(1) default 0,
    constraint GLPI_TICKET_SOLUTION_PK
        primary key (ID),
    constraint APPROVAL_BOOLEAN
        check (approval in (0, 1))
) TABLESPACE GLPI;


CREATE TABLE LIST_TICKET_SOLUTION
(
    ID_TICKET          VARCHAR2(16),
    ID_TICKET_SOLUTION VARCHAR2(16),
    constraint LIST_TICKET_SOLUTION_GLPI_TICKET_ID_FK
        foreign key (ID_TICKET) references GLPI_TICKET,
    constraint LIST_TICKET_SOLUTION_GLPI_TICKET_SOLUTION_ID_FK
        foreign key (ID_TICKET_SOLUTION) references GLPI_TICKET_SOLUTION
) TABLESPACE GLPI;


CREATE TABLE LIST_TICKET_TASK
(
    ID_TICKET      VARCHAR2(16),
    ID_TICKET_TASK VARCHAR2(16),
    constraint LIST_TICKET_TASK_GLPI_TICKET_ID_FK
        foreign key (ID_TICKET) references GLPI_TICKET,
    constraint LIST_TICKET_TASK_GLPI_TICKET_TASK_ID_FK
        foreign key (ID_TICKET_TASK) references GLPI_TICKET_TASK
) TABLESPACE GLPI;


CREATE TABLE GLPI_NOTIFICATION
(
    ID VARCHAR2(16), -- ID de la notification
    USER_ID VARCHAR2(16) NOT NULL, -- ID de l'utilisateur
    OPERATOR_ID  VARCHAR2(16), -- ID de l'opérateur
    TICKET_ID VARCHAR2(16) NOT NULL, -- ID du ticket
    MESSAGE VARCHAR2(255), -- Message de la notification
    DATE_CREATED TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Date de création de la notification
    STATUS VARCHAR2(20) DEFAULT 'Attente', -- Valeurs : 'Attente', 'traitée', 'échouée'
    CONSTRAINT FK_GLPI_NOTIFICATION_USER_ID FOREIGN KEY (USER_ID) REFERENCES GLPI_USER(ID), -- Clé étrangère vers la table GLPI_USER
    CONSTRAINT FK_GLPI_NOTIFICATION_OPERATOR_ID FOREIGN KEY (OPERATOR_ID) REFERENCES GLPI_USER(ID), -- Clé étrangère vers la table GLPI_USER
    CONSTRAINT FK_GLPI_NOTIFICATION_TICKET_ID FOREIGN KEY (TICKET_ID) REFERENCES GLPI_TICKET(ID) -- Clé étrangère vers la table GLPI_TICKET
) TABLESPACE GLPI;
