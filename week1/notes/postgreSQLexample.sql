-- foreign keys and relationship types

-- one to many
---
--- CREATE tables
---


CREATE TABLE events (
    event_id SERIAL,
    show_time TIMESTAMP,
    PRIMARY KEY(event_id),
    auditorium_id INT,
    film_id INT NOT NULL
);

CREATE TABLE auditoria (
    auditorium_id SERIAL,
    capacity INTEGER NOT NULL,
    PRIMARY KEY(auditorium_id)
);

CREATE TABLE films (
    film_id SERIAL,
    title TEXT NOT NULL,
    runtime INTEGER,
    PRIMARY KEY(film_id)
);

---
--- Add foreign key constraints
---

ALTER TABLE events
ADD CONSTRAINT fk_events_auditoria
FOREIGN KEY (auditorium_id)
REFERENCES auditoria;

ALTER TABLE events
ADD CONSTRAINT fk_events_films
FOREIGN KEY (film_id)
REFERENCES films;


-- one to one
---
--- CREATE tables
---

CREATE TABLE accounts (
   account_id SERIAL,
   username TEXT NOT NULL UNIQUE,
   password TEXT NOT NULL,
   PRIMARY KEY(account_id)
   customer_id INT NOT NULL UNIQUE
);

CREATE TABLE customers (
    customer_id SERIAL,
    name TEXT NOT NULL,
    PRIMARY KEY(customer_id)
);

---
--- Add foreign key constraints
---

ALTER TABLE accounts
ADD CONSTRAINT fk_accounts_customers
FOREIGN KEY (customer_id)
REFERENCES customers;


-- many to many
---
--- CREATE tables
---

CREATE TABLE event_purchases (
    customer_id INTEGER NOT NULL,
    event_id INTEGER NOT NULL,
    PRIMARY KEY(customer_id, event_id),
    price NUMERIC NOT NULL
);

---
--- Add foreign key constraints
---

ALTER TABLE event_purchases
ADD CONSTRAINT fk_event_purchases_events
FOREIGN KEY (event_id)
REFERENCES events;

ALTER TABLE event_purchases
ADD CONSTRAINT fk_event_purchases_customers
FOREIGN KEY (customer_id)
REFERENCES customers;