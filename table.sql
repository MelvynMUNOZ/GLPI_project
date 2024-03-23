-------------- DROPS --------------

DROP TABLE GLPI_INVENTORY CASCADE CONSTRAINTS;
DROP TABLE GLPI_USER CASCADE CONSTRAINTS;
DROP TABLE GLPI_TICKET CASCADE CONSTRAINTS;
DROP TABLE GLPI_TICKET_TASK CASCADE CONSTRAINTS;
DROP TABLE GLPI_TICKET_SOLUTION CASCADE CONSTRAINTS;
DROP TABLE GLPI_NOTIFICATION CASCADE CONSTRAINTS;


-------------- TABLES --------------

CREATE TABLE GLPI_USER
(
    ID           VARCHAR2(16) not null,
    NAME         VARCHAR2(50) not null,
    EMAIL        VARCHAR2(50) not null,
    ROLE         VARCHAR2(16) not null,
    constraint GLPI_USER_PK
        primary key (ID),
    constraint UNIQUE_EMAIL unique (EMAIL),
    constraint ROLE_ENUM
        check (role in ('Operator', 'User'))
) TABLESPACE GLPI;

CREATE TABLE GLPI_INVENTORY
(
    ID        VARCHAR2(16)  not null,
    CATEGORY  VARCHAR2(16)  not null,
    REFERENCE VARCHAR2(100) not null,
    OWNER_ID     VARCHAR2(16) not null,
    constraint GLPI_INVENTORY_PK
        primary key (ID),
    constraint GLPI_INVENTORY_GLPI_OWNER_ID_FK
        foreign key (OWNER_ID) references GLPI_USER,
    constraint GLPI_INVENTORY_CATEGORY_ENUM
        check (category in ('Software', 'Hardware', 'Network', 'Others'))
) TABLESPACE GLPI;


CREATE TABLE GLPI_TICKET
(
    ID           VARCHAR2(16) not null,
    TYPE         VARCHAR2(16) not null,
    CATEGORY     VARCHAR2(16) not null,
    IMPACT       VARCHAR2(16) not null,
    URGENCY      VARCHAR2(16) not null,
    PRIORITY     VARCHAR2(16) not null,
    STATUS       VARCHAR2(16) not null,
    TITLE        VARCHAR2(100) not null,
    DESCRIPTION  VARCHAR2(4000),
    DATE_CREATED DATE,
    DATE_UPDATED DATE,
    DATE_CLOSED  DATE,
    OWNER_ID     VARCHAR2(16) not null,
    OPERATOR_ID  VARCHAR2(16),
    INVENTORY_ITEM_ID     VARCHAR2(16) not null,
    constraint TABLE_NAME_PK
        primary key (ID),
    constraint GLPI_TICKET_GLPI_USER_ID_FK
        foreign key (OPERATOR_ID) references GLPI_USER,
    constraint GLPI_TICKET_GLPI_USER_ID_FK_2
        foreign key (OWNER_ID) references GLPI_USER,
    constraint GLPI_TICKET_GLPI_USER_ID_FK_3
        foreign key (INVENTORY_ITEM_ID) references GLPI_INVENTORY,
    constraint CATEGORY_ENUM
        check (category in ('Software', 'Hardware', 'Network', 'Others')),
    constraint IMPACT_ENUM
        check (impact in ('Low', 'Medium', 'High')),
    constraint PRIORITY_ENUM
        check (priority in ('Low', 'Medium', 'High')),
    constraint STATUS_ENUM
        check (status in ('Waiting', 'Attributed', 'Resolved', 'Closed', 'Deleted')),
    constraint TYPE_ENUM
        check (type in ('Incident', 'Request')),
    constraint URGENCY_ENUM
        check (urgency in ('Low', 'Medium', 'High'))
) TABLESPACE GLPI;


CREATE TABLE GLPI_TICKET_TASK
(
    ID           VARCHAR2(16) not null,
    TICKET_ID    VARCHAR2(16) not null,
    DATE_CREATED DATE,
    DESCRIPTION  VARCHAR2(500),
    constraint GLPI_TICKET_TASK_PK
        primary key (ID),
    constraint GLPI_TICKET_TASK_TICKET_ID_FK
        foreign key (TICKET_ID) references GLPI_TICKET
) TABLESPACE GLPI;


CREATE TABLE GLPI_TICKET_SOLUTION
(
    ID           VARCHAR2(16) not null,
    TICKET_ID    VARCHAR2(16) not null,
    DATE_CREATED DATE,
    DESCRIPTION  VARCHAR2(500),
    APPROVAL     NUMBER(1) default 0,
    constraint GLPI_TICKET_SOLUTION_PK
        primary key (ID),
    constraint GLPI_TICKET_SOLUTION_TICKET_ID_FK
        foreign key (TICKET_ID) references GLPI_TICKET,
    constraint APPROVAL_BOOLEAN
        check (approval in (0, 1))
) TABLESPACE GLPI;


CREATE TABLE GLPI_NOTIFICATION
(
    ID VARCHAR2(16) not null, -- ID de la notification
    USER_ID VARCHAR2(16) NOT NULL, -- ID de l'utilisateur
    OPERATOR_ID  VARCHAR2(16), -- ID de l'opérateur
    TICKET_ID VARCHAR2(16) NOT NULL, -- ID du ticket
    MESSAGE VARCHAR2(255) not null, -- Message de la notification
    DATE_CREATED DATE DEFAULT SYSDATE, -- Date de création de la notification
    STATUS VARCHAR2(20) DEFAULT 'Attente', -- Valeurs : 'Attente', 'traitée', 'échouée'
    CONSTRAINT FK_GLPI_NOTIFICATION_USER_ID FOREIGN KEY (USER_ID) REFERENCES GLPI_USER(ID), -- Clé étrangère vers la table GLPI_USER
    CONSTRAINT FK_GLPI_NOTIFICATION_OPERATOR_ID FOREIGN KEY (OPERATOR_ID) REFERENCES GLPI_USER(ID), -- Clé étrangère vers la table GLPI_USER
    CONSTRAINT FK_GLPI_NOTIFICATION_TICKET_ID FOREIGN KEY (TICKET_ID) REFERENCES GLPI_TICKET(ID) -- Clé étrangère vers la table GLPI_TICKET
) TABLESPACE GLPI;



