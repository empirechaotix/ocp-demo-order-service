CREATE TABLE ITEMS (
                     id bigint auto_increment PRIMARY KEY,
                     item_id bigint,
                     quantity INTEGER
);

CREATE TABLE ORDERS (
                     id bigint auto_increment PRIMARY KEY,
                     date VARCHAR(255)
);

CREATE TABLE USERS (
                     id bigint auto_increment PRIMARY KEY
);