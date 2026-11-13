-- Sales Analytics Dashboard: Datenbankstruktur
-- Fiktives Beispielunternehmen (Bürobedarf und IT), alle Daten sind erfunden.

-- Alte Tabellen löschen, damit das Skript mehrfach ausgeführt werden kann
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    region      VARCHAR(50)  NOT NULL,
    segment     VARCHAR(30)  NOT NULL   -- Kundengruppe: Großkunde, Mittelstand, Kleinkunde
);

CREATE TABLE products (
    product_id   INTEGER PRIMARY KEY,
    product_name VARCHAR(100)  NOT NULL,
    category     VARCHAR(50)   NOT NULL,
    unit_price   NUMERIC(10,2) NOT NULL,  -- Verkaufspreis pro Stück
    unit_cost    NUMERIC(10,2) NOT NULL   -- Einkaufspreis pro Stück
);

CREATE TABLE orders (
    order_id    INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
    product_id  INTEGER NOT NULL REFERENCES products(product_id),
    order_date  DATE    NOT NULL,
    quantity    INTEGER NOT NULL CHECK (quantity > 0)
);
