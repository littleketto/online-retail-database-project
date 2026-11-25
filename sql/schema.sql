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

-- Member 3: suppliers (required before products, which references it)

CREATE TABLE IF NOT EXISTS suppliers (
    supplier_id     SERIAL PRIMARY KEY,
    company_name    VARCHAR(120) NOT NULL UNIQUE,
    contact_name    VARCHAR(80)  NOT NULL,
    contact_email   VARCHAR(120) NOT NULL UNIQUE,
    contact_phone   VARCHAR(30),
    country         VARCHAR(60)  NOT NULL,
    lead_time_days  INTEGER      NOT NULL DEFAULT 7 CHECK (lead_time_days >= 0)
);

-- Member 2: categories & products

CREATE TABLE IF NOT EXISTS categories (
    category_id    SERIAL PRIMARY KEY,
    category_name  VARCHAR(60)  NOT NULL UNIQUE,
    description    TEXT,
    department     VARCHAR(50)  NOT NULL,
    tax_rate       NUMERIC(4, 2) NOT NULL DEFAULT 0.18,
    display_order  INTEGER      NOT NULL DEFAULT 0,
    is_active      BOOLEAN      NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS products (
    product_id      SERIAL PRIMARY KEY,
    category_id     INTEGER        NOT NULL REFERENCES categories(category_id) ON DELETE RESTRICT,
    supplier_id     INTEGER        NOT NULL REFERENCES suppliers(supplier_id) ON DELETE RESTRICT,
    stock_code      VARCHAR(30)    NOT NULL UNIQUE,
    product_name    VARCHAR(150)   NOT NULL,
    description     TEXT,
    unit_price      NUMERIC(10, 2) NOT NULL CHECK (unit_price >= 0),
    stock_quantity  INTEGER        NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    image_filename  VARCHAR(255)
);

-- Member 4: order_items

CREATE TABLE IF NOT EXISTS order_items (
    item_id        SERIAL PRIMARY KEY,
    order_id       INTEGER        NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id     INTEGER        NOT NULL REFERENCES products(product_id) ON DELETE RESTRICT,
    quantity       INTEGER        NOT NULL CHECK (quantity > 0),
    unit_price     NUMERIC(10, 2) NOT NULL CHECK (unit_price >= 0),
    discount_rate  NUMERIC(4, 2)  NOT NULL DEFAULT 0.00,
    line_total     NUMERIC(10, 2) NOT NULL,
    item_notes     TEXT
);
