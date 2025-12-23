--Query 1

SELECT
  bk.booking_id, usr.name, vh.name, bk.start_date, bk.end_date, bk.status
FROM bookings AS bk
  INNER JOIN users AS usr ON bk.user_id = usr.user_id
  INNER JOIN vehicles AS vh ON bk.vehicle_id = vh.vehicle_id;

--Query 2

SELECT vh.vehicle_id, vh.name, vh.type, vh.model, vh.registration_number, vh.rental_price, vh.status
FROM vehicles AS vh
WHERE
  NOT EXISTS (
    SELECT 1 FROM bookings AS bk WHERE bk.vehicle_id = vh.vehicle_id
  );

--Query 3

SELECT vehicle_id, name, type, model, registration_number, rental_price, status
FROM vehicles
WHERE status = 'available' AND type = 'car';

--Query 4

SELECT vh.name, COUNT(bk.booking_id)
FROM vehicles AS vh
JOIN bookings AS bk ON vh.vehicle_id = bk.vehicle_id
GROUP BY vh.vehicle_id, vh.name
HAVING COUNT(bk.booking_id) > 2;