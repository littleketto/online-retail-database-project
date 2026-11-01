# Online Retail Database Management System

A comprehensive, relational database web application built for the **Database Systems Term Project (2026-2027 Fall Term)**. The project models an end-to-end retail and e-commerce platform using the **UCI Online Retail II** dataset, normalized and extended into an 8-table relational architecture with pure **Raw SQL** (no ORM) data access.

---

## 🚀 Key Features & Highlights

- **Pure Raw SQL Execution:** Fully compliant with the strict non-ORM requirement. All queries (CRUD, aggregations, transactions) are written as native, parameterized SQL statements via PostgreSQL drivers.
- **Normalized 8-Table Architecture:** Exceeds the minimum requirement (6 tables) with 8 core entities, each containing between 5 and 7 non-key attributes.
- **Relational Integrity:** Implements 8 Foreign Key constraints linking customers, orders, order items, products, categories, suppliers, shipments, and reviews.
- **Audit Logging:** An additional audit log table tracks data modifications (INSERT, UPDATE, DELETE) for enterprise observability.
- **Modern Responsive UI:** Clean Bootstrap 5 dashboard with dynamic forms (textboxes, textareas, checkboxes, radio buttons, dropdowns).
- **Advanced Capabilities:** File upload for product imagery, session authentication, CSV export, live stock alerts, and Chart.js analytics.

---

## 🗄️ Relational Database Schema

| Table Name | Description | Key Column | Foreign Keys |
| :--- | :--- | :--- | :--- |
| `customers` | Registered retail clients and contact information | `customer_id` (PK) | - |
| `orders` | Transaction headers and billing details | `order_id` (PK) | `customer_id` ➔ `customers` |
| `categories` | Product classification and tax rules | `category_id` (PK) | - |
| `suppliers` | Vendors and logistics lead times | `supplier_id` (PK) | - |
| `products` | Inventory catalog and unit prices | `product_id` (PK) | `category_id`, `supplier_id` |
| `order_items` | Individual line items per transaction | `item_id` (PK) | `order_id`, `product_id` |
| `shipments` | Delivery tracking and courier status | `shipment_id` (PK) | `order_id` ➔ `orders` |
| `reviews` | Customer ratings (1-5 stars) and feedback | `review_id` (PK) | `product_id`, `customer_id` |
| `audit_logs` | System change tracking (Extra Table) | `log_id` (PK) | - |

---

## 🛠️ Tech Stack

- **Backend:** Python 3.14 + Flask (Modular Blueprint Architecture)
- **Database:** PostgreSQL 16 (Containerized via Docker Compose)
- **Database Driver:** `psycopg2-binary` (Raw SQL, connection pooling)
- **Frontend:** Jinja2, HTML5, Bootstrap 5, JavaScript, Chart.js

---

## ⚙️ Quick Start Guide

### Prerequisites
- Python 3.10+
- Docker & Docker Compose
- Git

### 1. Clone the Repository
```bash
git clone https://github.com/littleketto/online-retail-database-project.git
cd online-retail-database-project
```

### 2. Start PostgreSQL Container
```bash
docker compose up -d
```

### 3. Install Python Dependencies
```bash
python -m pip install -r requirements.txt
```

### 4. Run the Application
```bash
python app.py
```
Open your browser and navigate to `http://localhost:5000`.

---

## 👥 Team & Responsibilities

| Member | Assigned Tables | Foreign Key Included |
| :--- | :--- | :---: |
| **Member 1** | `customers`, `orders` | ✅ (`customer_id`) |
| **Member 2** | `categories`, `products` | ✅ (`category_id`, `supplier_id`) |
| **Member 3** | `suppliers`, `shipments` | ✅ (`order_id`) |
| **Member 4** | `order_items`, `reviews` | ✅ (`order_id`, `product_id`, `customer_id`) |
