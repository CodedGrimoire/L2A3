-- Query 1: JOIN
-- Retrieve booking info with customer and vehicle names.
SELECT
    b.id AS booking_id,
    u.name AS customer_name,
    v.name AS vehicle_name,
    b.start_date,
    b.end_date,
    b.status,
    b.total_cost
FROM bookings b
INNER JOIN users u ON u.id = b.user_id
INNER JOIN vehicles v ON v.id = b.vehicle_id;

-- Query 2: NOT EXISTS
-- Find vehicles that have never been booked.
SELECT
    v.id,
    v.name,
    v.registration_number,
    v.type,
    v.availability
FROM vehicles v
WHERE NOT EXISTS (
    SELECT 1
    FROM bookings b
    WHERE b.vehicle_id = v.id
);

-- Query 3: WHERE
-- Retrieve all available vehicles of a specific type (use a bind/placeholder for the type).
SELECT
    v.id,
    v.name,
    v.registration_number,
    v.type,
    v.rental_price_per_day
FROM vehicles v
WHERE v.availability = 'available'
  AND v.type = :vehicle_type; -- e.g., 'car', 'bike', 'truck'

-- Query 4: GROUP BY and HAVING
-- Count bookings per vehicle and show only vehicles with more than 2 bookings.
SELECT
    v.id,
    v.name,
    v.registration_number,
    COUNT(*) AS booking_count
FROM vehicles v
INNER JOIN bookings b ON b.vehicle_id = v.id
GROUP BY v.id, v.name, v.registration_number
HAVING COUNT(*) > 2;
