-- Sales Analytics Dashboard: Analyse-Abfragen
-- Umsatz = Menge × Verkaufspreis, Gewinn = Menge × (Verkaufspreis − Einkaufspreis)

-- 1. Kennzahlen gesamt: Umsatz, Gewinn, Bestellungen, Marge
SELECT SUM(o.quantity * p.unit_price)                        AS umsatz,
       SUM(o.quantity * (p.unit_price - p.unit_cost))        AS gewinn,
       COUNT(*)                                              AS bestellungen,
       ROUND(SUM(o.quantity * (p.unit_price - p.unit_cost))
             / SUM(o.quantity * p.unit_price) * 100, 2)      AS marge_prozent
FROM orders o
JOIN products p ON o.product_id = p.product_id;

-- 2. Umsatz und Bestellungen pro Region
SELECT c.region,
       COUNT(*)                       AS bestellungen,
       SUM(o.quantity * p.unit_price) AS umsatz
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p  ON o.product_id  = p.product_id
GROUP BY c.region
ORDER BY umsatz DESC;

-- 3. Umsatz und Gewinn pro Produktkategorie
SELECT p.category,
       COUNT(*)                                       AS bestellungen,
       SUM(o.quantity * p.unit_price)                 AS umsatz,
       SUM(o.quantity * (p.unit_price - p.unit_cost)) AS gewinn
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY gewinn DESC;

-- 4. Top 5 Kunden nach Umsatz
SELECT c.name,
       c.segment,
       SUM(o.quantity * p.unit_price) AS umsatz
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p  ON o.product_id  = p.product_id
GROUP BY c.name, c.segment
ORDER BY umsatz DESC
LIMIT 5;

-- 5. Umsatz pro Monat
SELECT DATE_TRUNC('month', o.order_date) AS monat,
       SUM(o.quantity * p.unit_price)    AS umsatz
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY monat
ORDER BY monat;
