DROP TABLE IF EXISTS shipments;

CREATE TABLE shipments (
    shipment_id INTEGER PRIMARY KEY,
    carrier TEXT,
    origin TEXT,
    destination TEXT,
    weight_kg REAL,
    freight_cost REAL,
    transit_days INTEGER,
    status TEXT
);

INSERT INTO shipments
(shipment_id, carrier, origin, destination, weight_kg, freight_cost, transit_days, status)
VALUES
(1,'DHL','Riga','Berlin',450.5,620,3,'Delivered'),
(2,'DHL','Riga','Warsaw',320,410,2,'Delivered'),
(3,'DB Schenker','Vilnius','Berlin',780,890,4,'Delayed'),
(4,'DSV','Tallinn','Stockholm',210.5,350,2,'Delivered'),
(5,'DHL','Riga','Amsterdam',560,760,4,'In Transit'),
(6,'DB Schenker','Riga','Prague',920,980,5,'Delivered'),
(7,'DSV','Vilnius','Warsaw',340,390,3,'Delayed'),
(8,'DHL','Tallinn','Helsinki',180,280,1,'Delivered'),
(9,'Kuehne+Nagel','Riga','Munich',670,820,4,'Delivered'),
(10,'DSV','Riga','Copenhagen',430,590,3,'Delivered'),
(11,'Kuehne+Nagel','Vilnius','Berlin',520,680,4,'Delivered'),
(12,'DSV','Riga','Hamburg',860,940,5,'Delayed'),
(13,'DHL','Vilnius','Warsaw',275,360,2,'Delivered'),
(14,'DB Schenker','Tallinn','Berlin',690,810,4,'In Transit'),
(15,'Kuehne+Nagel','Riga','Vienna',740,870,5,'Delivered'),
(16,'DSV','Vilnius','Prague',410,520,3,'Delivered'),
(17,'DHL','Riga','Copenhagen',390,540,3,'Delayed'),
(18,'DB Schenker','Riga','Amsterdam',950,1120,6,'Delivered'),
(19,'DSV','Tallinn','Warsaw',230,310,2,'Delivered'),
(20,'Kuehne+Nagel','Vilnius','Munich',610,790,4,'In Transit'),
(21,'DHL','Riga','Stockholm',285,390,2,'Delivered'),
(22,'DB Schenker','Vilnius','Hamburg',830,970,5,'Delayed'),
(23,'DSV','Riga','Berlin',470,600,3,'Delivered'),
(24,'Kuehne+Nagel','Tallinn','Helsinki',195,260,1,'Delivered'),
(25,'DHL','Vilnius','Amsterdam',580,720,4,'In Transit'),
(26,'DB Schenker','Riga','Munich',760,900,5,'Delivered'),
(27,'DSV','Vilnius','Copenhagen',350,470,3,'Delayed'),
(28,'Kuehne+Nagel','Riga','Prague',640,750,4,'Delivered'),
(29,'DHL','Tallinn','Stockholm',205,300,2,'Delivered'),
(30,'DB Schenker','Vilnius','Vienna',880,1010,6,'In Transit');


-- BASIC KPIs

SELECT COUNT(*) AS total_shipments
FROM shipments;

SELECT ROUND(SUM(freight_cost),2) AS total_freight_cost
FROM shipments;

SELECT ROUND(AVG(freight_cost),2) AS average_freight_cost
FROM shipments;

SELECT ROUND(AVG(weight_kg),2) AS average_weight_kg
FROM shipments;

SELECT ROUND(AVG(transit_days),2) AS average_transit_days
FROM shipments;


-- CARRIER ANALYSIS

SELECT
    carrier,
    COUNT(*) AS shipment_count
FROM shipments
GROUP BY carrier
ORDER BY shipment_count DESC;

SELECT
    carrier,
    ROUND(SUM(freight_cost),2) AS total_freight_cost
FROM shipments
GROUP BY carrier
ORDER BY total_freight_cost DESC;

SELECT
    carrier,
    ROUND(AVG(freight_cost),2) AS average_freight_cost
FROM shipments
GROUP BY carrier
ORDER BY average_freight_cost DESC;

SELECT
    carrier,
    ROUND(AVG(transit_days),2) AS average_transit_days
FROM shipments
GROUP BY carrier
ORDER BY average_transit_days;

SELECT
    carrier,
    ROUND(AVG(weight_kg),2) AS average_weight_kg
FROM shipments
GROUP BY carrier
ORDER BY average_weight_kg DESC;


-- STATUS ANALYSIS

SELECT
    status,
    COUNT(*) AS shipment_count
FROM shipments
GROUP BY status
ORDER BY shipment_count DESC;

SELECT
    COUNT(*) AS delayed_shipments
FROM shipments
WHERE status = 'Delayed';

SELECT
    carrier,
    COUNT(*) AS delayed_shipments
FROM shipments
WHERE status = 'Delayed'
GROUP BY carrier
ORDER BY delayed_shipments DESC;


-- DELAY RATE

SELECT
    carrier,
    COUNT(*) AS total_shipments,
    SUM(CASE WHEN status = 'Delayed' THEN 1 ELSE 0 END) AS delayed_shipments,
    ROUND(
        100.0 * SUM(CASE WHEN status = 'Delayed' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS delay_rate_percent
FROM shipments
GROUP BY carrier
ORDER BY delay_rate_percent DESC;


-- ROUTE ANALYSIS

SELECT
    origin,
    destination,
    COUNT(*) AS shipment_count,
    ROUND(SUM(freight_cost),2) AS total_freight_cost,
    ROUND(AVG(freight_cost),2) AS average_freight_cost,
    ROUND(AVG(transit_days),2) AS average_transit_days
FROM shipments
GROUP BY origin, destination
ORDER BY total_freight_cost DESC;

SELECT
    destination,
    COUNT(*) AS shipment_count
FROM shipments
GROUP BY destination
ORDER BY shipment_count DESC;

SELECT
    origin,
    COUNT(*) AS shipment_count
FROM shipments
GROUP BY origin
ORDER BY shipment_count DESC;


-- COST ANALYSIS

SELECT
    shipment_id,
    carrier,
    origin,
    destination,
    weight_kg,
    freight_cost,
    transit_days,
    status
FROM shipments
ORDER BY freight_cost DESC
LIMIT 5;

SELECT
    shipment_id,
    carrier,
    origin,
    destination,
    weight_kg,
    freight_cost,
    ROUND(freight_cost / weight_kg,2) AS cost_per_kg
FROM shipments
ORDER BY cost_per_kg DESC;

SELECT
    carrier,
    ROUND(SUM(freight_cost) / SUM(weight_kg),2) AS cost_per_kg
FROM shipments
GROUP BY carrier
ORDER BY cost_per_kg DESC;


-- TRANSIT ANALYSIS

SELECT
    shipment_id,
    carrier,
    origin,
    destination,
    transit_days,
    freight_cost,
    status
FROM shipments
ORDER BY transit_days DESC
LIMIT 5;


-- HEAVY SHIPMENTS

SELECT *
FROM shipments
WHERE weight_kg > 500
ORDER BY weight_kg DESC;

SELECT
    ROUND(AVG(freight_cost),2) AS average_cost_heavy_shipments
FROM shipments
WHERE weight_kg > 500;


-- OVERALL KPI SUMMARY

SELECT
    COUNT(*) AS total_shipments,
    ROUND(SUM(freight_cost),2) AS total_freight_cost,
    ROUND(AVG(freight_cost),2) AS average_freight_cost,
    ROUND(AVG(weight_kg),2) AS average_weight_kg,
    ROUND(AVG(transit_days),2) AS average_transit_days,
    SUM(CASE WHEN status = 'Delayed' THEN 1 ELSE 0 END) AS delayed_shipments,
    ROUND(
        100.0 * SUM(CASE WHEN status = 'Delayed' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS overall_delay_rate_percent
FROM shipments;