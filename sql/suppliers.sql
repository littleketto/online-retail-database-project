-- suppliers: vendors that supply products (owner: Ozan)
-- Not part of the Online Retail II dataset; seeded with synthetic data.

CREATE TABLE IF NOT EXISTS suppliers (
  supplier_id     SERIAL        PRIMARY KEY,
  company_name    VARCHAR(120)  NOT NULL UNIQUE,
  contact_name    VARCHAR(80)   NOT NULL,
  email           VARCHAR(120)  NOT NULL UNIQUE,
  phone           VARCHAR(30),
  country         VARCHAR(60)   NOT NULL,
  lead_time_days  INTEGER       NOT NULL DEFAULT 7 CHECK (lead_time_days >= 0),
  rating          NUMERIC(2,1)  CHECK (rating BETWEEN 0 AND 5),
  is_active       BOOLEAN       NOT NULL DEFAULT TRUE,
  created_at      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO suppliers (company_name, contact_name, email, phone, country, lead_time_days, rating) VALUES
('Albion Giftware Ltd',     'James Carter',   'orders@albiongift.co.uk',   '+44 20 7946 0011', 'United Kingdom', 5,  4.6),
('Rhine Home Decor GmbH',   'Lena Vogel',     'sales@rhinedecor.de',       '+49 30 1234 5678', 'Germany',        9,  4.2),
('Lumiere Paper Co.',       'Claire Dubois',  'contact@lumierepaper.fr',   '+33 1 23 45 67 89','France',         8,  4.0),
('Nordic Candle Works',     'Erik Lund',      'b2b@nordiccandle.se',       '+46 8 123 456 78', 'Sweden',         12, 4.4),
('Celtic Ceramics',         'Siobhan Byrne',  'trade@celticceramics.ie',   '+353 1 234 5678',  'Ireland',        6,  3.9),
('Iberia Party Supplies',   'Marta Ruiz',     'pedidos@iberiaparty.es',    '+34 91 123 45 67', 'Spain',          10, 4.1);
