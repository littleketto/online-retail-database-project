-- suppliers: parameterized CRUD queries (psycopg2 named placeholders, no ORM)
-- Used by the suppliers blueprint.

-- name: list_suppliers
SELECT supplier_id, company_name, contact_name, email, country, lead_time_days, rating, is_active
FROM suppliers
ORDER BY company_name;

-- name: get_supplier
SELECT * FROM suppliers WHERE supplier_id = %(supplier_id)s;

-- name: create_supplier
INSERT INTO suppliers (company_name, contact_name, email, phone, country, lead_time_days, rating, is_active)
VALUES (%(company_name)s, %(contact_name)s, %(email)s, %(phone)s, %(country)s, %(lead_time_days)s, %(rating)s, %(is_active)s)
RETURNING supplier_id;

-- name: update_supplier
UPDATE suppliers
SET company_name = %(company_name)s, contact_name = %(contact_name)s, email = %(email)s, phone = %(phone)s, country = %(country)s, lead_time_days = %(lead_time_days)s, rating = %(rating)s, is_active = %(is_active)s
WHERE supplier_id = %(supplier_id)s;

-- name: delete_supplier
DELETE FROM suppliers WHERE supplier_id = %(supplier_id)s;
