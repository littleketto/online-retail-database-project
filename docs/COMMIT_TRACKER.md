# Commit Tracker (75-Step Roadmap)

> **STRICT SEQUENTIAL RULE FOR ALL MEMBERS & AI AGENTS:**
> Always work in **exact sequential order (01 -> 02 -> 03 -> ... -> 75)**!
> Do **NOT** skip ahead or pick random future steps.
> Before starting: `git pull --rebase origin main`. Pick the **very first unchecked `[ ]` item**, implement ONLY that single step, mark it `[x]` here, commit, and push!

---

## Phase 1: Foundation, Config & Database Infrastructure
- [x] **01.** `chore: initialize repository with .gitignore and README` (`b6219c8` - `littleketto`)
- [x] **02.** `build: configure requirements.txt with Flask, psycopg2-binary and openpyxl` (`6628168` - `littleketto`)
- [x] **03.** `docs: add shared implementation plan, commit tracker and agent guide` *(Completed)*
- [x] **04.** `build(docker): add docker-compose.yml for PostgreSQL 16 and pgAdmin`
- [x] **05.** `config: implement database configuration and environment variables loader`
- [x] **06.** `feat(db): implement connection pool and raw SQL query execution helper`
- [ ] **07.** `feat(db): add transaction context manager for atomic multi-query execution`
- [ ] **08.** `feat(schema): create DDL script for customers and orders tables`
- [ ] **09.** `feat(schema): create DDL script for categories, products and order_items tables`
- [ ] **10.** `feat(schema): create DDL script for shipments, reviews, audit_logs and indexes`

---

## Phase 2: Data Extraction, Cleaning & Seeding
- [ ] **11.** `feat(data): create dataset reader module to parse online_retail_II.xlsx`
- [ ] **12.** `feat(data): implement data cleaning to filter cancellations and null customer ids`
- [ ] **13.** `feat(data): implement SQL seed generator for categories and suppliers`
- [ ] **14.** `feat(data): implement SQL seed generator for customers with realistic contact info`
- [ ] **15.** `feat(data): implement SQL seed generator for products linked to categories and suppliers`
- [ ] **16.** `feat(data): implement SQL seed generator for orders and order_items`
- [ ] **17.** `feat(data): implement SQL seed generator for shipments and reviews`

---

## Phase 3: Web Framework & Shared UI Layout
- [ ] **18.** `feat(web): initialize Flask application factory with blueprint registration`
- [ ] **19.** `feat(ui): setup base Jinja2 template with Bootstrap 5 CDN and meta tags`
- [ ] **20.** `feat(ui): add responsive navigation bar with links to all 8 entities`
- [ ] **21.** `feat(ui): create reusable toast and flash notification component`
- [ ] **22.** `feat(ui): add reusable modal dialog for delete confirmation`
- [ ] **23.** `feat(ui): implement custom CSS styling and badge styles for statuses`
- [ ] **24.** `feat(ui): implement generic client-side form validation script`

---

## Phase 4: Customers Module (Owner: Member 1)
- [ ] **25.** `feat(customers): write raw SQL queries for customer listing and search`
- [ ] **26.** `feat(customers): implement customer list view with pagination and search bar`
- [ ] **27.** `feat(customers): implement customer creation form with server-side validation`
- [ ] **28.** `feat(customers): implement customer update route and pre-filled edit form`
- [ ] **29.** `feat(customers): implement customer delete endpoint with constraint safety`
- [ ] **30.** `feat(customers): add customer detail view showing order history and total spent`

---

## Phase 5: Orders Module (Owner: Member 1)
- [ ] **31.** `feat(orders): write raw SQL queries for order aggregation and join with customers`
- [ ] **32.** `feat(orders): implement orders table view with status filtering`
- [ ] **33.** `feat(orders): create new order placement form with customer dropdown selection`
- [ ] **34.** `feat(orders): implement order status update route with radio button selector`
- [ ] **35.** `feat(orders): implement order cancellation/deletion logic with safety checks`
- [ ] **36.** `feat(orders): build invoice printable view showing order summary and customer info`

---

## Phase 6: Categories Module (Owner: Member 2)
- [ ] **37.** `feat(categories): write raw SQL queries for category catalog and product count`
- [ ] **38.** `feat(categories): implement category list table with department grouping`
- [ ] **39.** `feat(categories): create category creation form with tax rate and display order`
- [ ] **40.** `feat(categories): implement category edit form with active/passive checkbox`
- [ ] **41.** `feat(categories): implement category delete with cascade prevention check`

---

## Phase 7: Products Module (Owner: Member 2)
- [ ] **42.** `feat(products): write raw SQL queries for product catalog with category and supplier joins`
- [ ] **43.** `feat(products): implement product list view with category dropdown filter`
- [ ] **44.** `feat(products): build product creation form with file upload for product image`
- [ ] **45.** `feat(products): implement secure file storage and image path persistence`
- [ ] **46.** `feat(products): implement product edit route with stock quantity adjustment`
- [ ] **47.** `feat(products): implement product delete functionality with constraint safety`

---

## Phase 8: Suppliers Module (Owner: Member 3)
- [ ] **48.** `feat(suppliers): write raw SQL queries for suppliers and supplied products count`
- [ ] **49.** `feat(suppliers): implement supplier list view with country filter`
- [ ] **50.** `feat(suppliers): create new supplier form with email, phone and lead time inputs`
- [ ] **51.** `feat(suppliers): implement supplier update form and contact detail editor`
- [ ] **52.** `feat(suppliers): implement supplier delete route with related product check`

---

## Phase 9: Shipments Module (Owner: Member 3)
- [ ] **53.** `feat(shipments): write raw SQL queries for shipment tracking linked with orders`
- [ ] **54.** `feat(shipments): implement shipments list view with delivery status badges`
- [ ] **55.** `feat(shipments): build shipment dispatch form with carrier selection and tracking no`
- [ ] **56.** `feat(shipments): implement shipment status updater with estimated delivery date`
- [ ] **57.** `feat(shipments): implement shipment record deletion route`

---

## Phase 10: Order Items Module (Owner: Member 4)
- [ ] **58.** `feat(order-items): write raw SQL queries for order line items with subtotal math`
- [ ] **59.** `feat(order-items): implement order items table within order detail page`
- [ ] **60.** `feat(order-items): create add item modal with product selector and price auto-fill`
- [ ] **61.** `feat(order-items): implement item quantity update route recalculating order total`
- [ ] **62.** `feat(order-items): implement item removal route with order total update`

---

## Phase 11: Reviews Module (Owner: Member 4)
- [ ] **63.** `feat(reviews): write raw SQL queries for product reviews with customer joins`
- [ ] **64.** `feat(reviews): implement review list view with star rating visual badges`
- [ ] **65.** `feat(reviews): build review submission form with 1-5 star radio selection and textarea`
- [ ] **66.** `feat(reviews): implement review approval toggle route with checkbox control`
- [ ] **67.** `feat(reviews): implement review deletion endpoint`

---

## Phase 12: Security, Sessions, Analytics & Reporting
- [ ] **68.** `feat(auth): implement session-based login and logout for admin access`
- [ ] **69.** `feat(audit): implement automatic action logging to audit_logs table on changes`
- [ ] **70.** `feat(export): implement CSV data export for all 8 main tables using raw SQL`
- [ ] **71.** `feat(dashboard): build executive dashboard with total revenue, order count and KPI cards`
- [ ] **72.** `feat(analytics): add Chart.js charts for monthly sales trends and top selling products`
- [ ] **73.** `feat(alerts): add low-stock warning alert banner in dashboard`
- [ ] **74.** `test: add verification script to validate all 8 CRUD endpoints and SQL safety`
- [ ] **75.** `docs: finalize project report and evaluation worksheet`
