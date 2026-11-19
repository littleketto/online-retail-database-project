-- =========================================================
-- Online Retail II - Master DDL (PostgreSQL 16)
-- =========================================================

-- Member 1: customers & orders

CREATE TABLE IF NOT EXISTS customers (
    customer_id        SERIAL PRIMARY KEY,
    first_name         VARCHAR(50)  NOT NULL,
    last_name          VARCHAR(50)  NOT NULL,
    email              VARCHAR(120) NOT NULL UNIQUE,
    phone              VARCHAR(30),
    city               VARCHAR(60),
    country            VARCHAR(60)  NOT NULL,
    registration_date  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS orders (
    order_id          SERIAL PRIMARY KEY,
    customer_id       INTEGER        NOT NULL REFERENCES customers(customer_id) ON DELETE RESTRICT,
    invoice_no        VARCHAR(20)    NOT NULL UNIQUE,
    order_date        TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    order_status      VARCHAR(20)    NOT NULL DEFAULT 'Pending'
                      CHECK (order_status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled')),
    payment_method    VARCHAR(30)    NOT NULL
                      CHECK (payment_method IN ('Credit Card', 'Bank Transfer', 'PayPal')),
    shipping_address  TEXT           NOT NULL,
    total_amount      NUMERIC(10, 2) NOT NULL DEFAULT 0.00
);
