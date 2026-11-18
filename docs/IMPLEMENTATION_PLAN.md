# Online Retail II - Implementation Plan & Architecture

This document is the **Single Source of Truth** for the **Database Systems Fall Term Project (2026-2027)**. All team members and AI assistants MUST follow the exact table names, column names, data types, and architectural rules defined here.

---

## 1. Strict Project Rules (Non-Negotiable)

1. **NO ORMs Allowed:** SQLAlchemy ORM, Django ORM, or any SQL abstraction layer is **strictly forbidden**. All database operations must use **Raw SQL** via `psycopg2-binary` with parameterized queries (`%(param)s` or `%s`).
2. **Minimum 5 Non-Key Columns per Main Table:** Every main table must have at least 5 non-key columns (excluding PK and FKs).
3. **Complete CRUD:** All 8 main tables must support full Create, Read, Update, Delete operations in the Flask web UI.
4. **Team Ownership & Foreign Keys:** Each of the 4 members exclusively owns 2 main tables, with at least 1 table containing a Foreign Key.

---

## 2. Tech Stack & Directory Structure

- **Backend:** Python 3.14 + Flask (Blueprint architecture)
- **Database:** PostgreSQL 16 (via Docker Compose)
- **Driver:** `psycopg2-binary` (Raw SQL, connection pooling)
- **Frontend:** Jinja2, Bootstrap 5, Vanilla JS, Chart.js

```text
online-retail-database-project/
├── app.py                     # Flask application factory & blueprint registration
├── config.py                  # PostgreSQL & app configuration loader
├── db.py                      # Raw SQL connection pool & query runner
├── docker-compose.yml         # PostgreSQL 16 (+ optional pgAdmin)
├── requirements.txt           # Python dependencies
├── seed_data.py               # Excel (online_retail_II.xlsx) -> PostgreSQL seeder
├── docs/
│   ├── IMPLEMENTATION_PLAN.md # This file (Schema & Architecture)
│   ├── COMMIT_TRACKER.md      # Live 75-step commit checklist
│   └── AGENT_GUIDE.md         # Rules for teammates & AI agents
├── sql/
│   └── schema.sql             # Master DDL for all 8 main tables + audit_logs + indexes
├── routes/                    # Flask Blueprints (one file per module)
│   ├── customers.py
│   ├── orders.py
│   ├── categories.py
│   ├── products.py
│   ├── suppliers.py
│   ├── shipments.py
│   ├── order_items.py
│   ├── reviews.py
│   └── dashboard.py
├── static/
│   ├── css/custom.css
│   ├── js/app.js
│   └── uploads/               # Product image uploads
└── templates/                 # Jinja2 templates (one folder per module)
    ├── base.html
    └── ...
```

---

## 3. Team Ownership & Exact Database Schema (8 Main Tables + 1 Extra)

### Member 1 (`littleketto`): `customers` & `orders`

1. **`customers`** (7 non-key columns)
   - `customer_id` `SERIAL PRIMARY KEY`
   - `first_name` `VARCHAR(50) NOT NULL`
   - `last_name` `VARCHAR(50) NOT NULL`
   - `email` `VARCHAR(120) NOT NULL UNIQUE`
   - `phone` `VARCHAR(30)`
   - `city` `VARCHAR(60)`
   - `country` `VARCHAR(60) NOT NULL`
   - `registration_date` `TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP`

2. **`orders`** (6 non-key columns, 1 FK)
   - `order_id` `SERIAL PRIMARY KEY`
   - `customer_id` `INTEGER NOT NULL REFERENCES customers(customer_id) ON DELETE RESTRICT`
   - `invoice_no` `VARCHAR(20) NOT NULL UNIQUE`
   - `order_date` `TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP`
   - `order_status` `VARCHAR(20) NOT NULL DEFAULT 'Pending'` *(Pending, Processing, Shipped, Delivered, Cancelled)*
   - `payment_method` `VARCHAR(30) NOT NULL` *(Credit Card, Bank Transfer, PayPal)*
   - `shipping_address` `TEXT NOT NULL`
   - `total_amount` `NUMERIC(10, 2) NOT NULL DEFAULT 0.00`

---

### Member 2: `categories` & `products`

3. **`categories`** (6 non-key columns)
   - `category_id` `SERIAL PRIMARY KEY`
   - `category_name` `VARCHAR(60) NOT NULL UNIQUE`
   - `description` `TEXT`
   - `department` `VARCHAR(50) NOT NULL`
   - `tax_rate` `NUMERIC(4, 2) NOT NULL DEFAULT 0.18`
   - `display_order` `INTEGER NOT NULL DEFAULT 0`
   - `is_active` `BOOLEAN NOT NULL DEFAULT TRUE`

4. **`products`** (6 non-key columns, 2 FKs)
   - `product_id` `SERIAL PRIMARY KEY`
   - `category_id` `INTEGER NOT NULL REFERENCES categories(category_id) ON DELETE RESTRICT`
   - `supplier_id` `INTEGER NOT NULL REFERENCES suppliers(supplier_id) ON DELETE RESTRICT`
   - `stock_code` `VARCHAR(30) NOT NULL UNIQUE`
   - `product_name` `VARCHAR(150) NOT NULL`
   - `description` `TEXT`
   - `unit_price` `NUMERIC(10, 2) NOT NULL CHECK (unit_price >= 0)`
   - `stock_quantity` `INTEGER NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0)`
   - `image_filename` `VARCHAR(255)`

---

### Member 3: `suppliers` & `shipments`

5. **`suppliers`** (6 non-key columns)
   - `supplier_id` `SERIAL PRIMARY KEY`
   - `company_name` `VARCHAR(120) NOT NULL UNIQUE`
   - `contact_name` `VARCHAR(80) NOT NULL`
   - `contact_email` `VARCHAR(120) NOT NULL UNIQUE`
   - `contact_phone` `VARCHAR(30)`
   - `country` `VARCHAR(60) NOT NULL`
   - `lead_time_days` `INTEGER NOT NULL DEFAULT 7 CHECK (lead_time_days >= 0)`

6. **`shipments`** (6 non-key columns, 1 FK)
   - `shipment_id` `SERIAL PRIMARY KEY`
   - `order_id` `INTEGER NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE`
   - `carrier_name` `VARCHAR(50) NOT NULL` *(DHL, FedEx, UPS, Royal Mail)*
   - `tracking_number` `VARCHAR(50) NOT NULL UNIQUE`
   - `shipping_date` `DATE NOT NULL`
   - `estimated_delivery` `DATE`
   - `shipping_cost` `NUMERIC(8, 2) NOT NULL DEFAULT 0.00`
   - `shipment_status` `VARCHAR(30) NOT NULL DEFAULT 'Preparing'` *(Preparing, In Transit, Delivered, Returned)*

---

### Member 4: `order_items` & `reviews`

7. **`order_items`** (5 non-key columns, 2 FKs)
   - `item_id` `SERIAL PRIMARY KEY`
   - `order_id` `INTEGER NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE`
   - `product_id` `INTEGER NOT NULL REFERENCES products(product_id) ON DELETE RESTRICT`
   - `quantity` `INTEGER NOT NULL CHECK (quantity > 0)`
   - `unit_price` `NUMERIC(10, 2) NOT NULL CHECK (unit_price >= 0)`
   - `discount_rate` `NUMERIC(4, 2) NOT NULL DEFAULT 0.00`
   - `line_total` `NUMERIC(10, 2) NOT NULL`
   - `item_notes` `TEXT`

8. **`reviews`** (5 non-key columns, 2 FKs)
   - `review_id` `SERIAL PRIMARY KEY`
   - `product_id` `INTEGER NOT NULL REFERENCES products(product_id) ON DELETE CASCADE`
   - `customer_id` `INTEGER NOT NULL REFERENCES customers(customer_id) ON DELETE CASCADE`
   - `rating` `INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5)`
   - `review_title` `VARCHAR(100) NOT NULL`
   - `review_text` `TEXT NOT NULL`
   - `review_date` `TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP`
   - `is_approved` `BOOLEAN NOT NULL DEFAULT TRUE`

---

### Extra Table (No 5-column restriction)

9. **`audit_logs`**
   - `log_id` `SERIAL PRIMARY KEY`
   - `table_name` `VARCHAR(50) NOT NULL`
   - `operation` `VARCHAR(10) NOT NULL` *(INSERT, UPDATE, DELETE)*
   - `record_id` `INTEGER`
   - `changed_by` `VARCHAR(50) DEFAULT 'admin'`
   - `changed_at` `TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP`
   - `details` `TEXT`
