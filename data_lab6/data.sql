CREATE TABLE `your_project_id.your_dataset.us_delay_causes` (
  flight_date DATE,
  carrier STRING,
  delay_cause STRING,
  num_delays INT64
);
INSERT INTO `your_project_id.your_dataset.us_delay_causes` (flight_date, carrier, delay_cause, num_delays)
VALUES
  (DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY), 'DL', 'Weather', 22),
  (DATE_SUB(CURRENT_DATE(), INTERVAL 3 DAY), 'AA', 'Late Aircraft', 17),
  (DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY), 'UA', 'Security', 18),
  (DATE_SUB(CURRENT_DATE(), INTERVAL 5 DAY), 'DL', 'NAS', 16),
  (DATE_SUB(CURRENT_DATE(), INTERVAL 6 DAY), 'SW', 'Carrier', 25),
  (DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY), 'AA', 'Weather', 12),
  (DATE_SUB(CURRENT_DATE(), INTERVAL 8 DAY), 'UA', 'Late Aircraft', 30),
  (DATE_SUB(CURRENT_DATE(), INTERVAL 9 DAY), 'DL', 'NAS', 14),    
  (DATE_SUB(CURRENT_DATE(), INTERVAL 10 DAY), 'SW', 'Security', 19),
  (DATE_SUB(CURRENT_DATE(), INTERVAL 11 DAY), 'AA', 'Carrier', 23);
