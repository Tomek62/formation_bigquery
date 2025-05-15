CREATE OR REPLACE TABLE dataset.transactions (
  id INT64,
  amount FLOAT64,
  store STRING,
  event_date DATE
);

INSERT INTO dataset.transactions
VALUES
  (1, 0.0, "Paris", DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)),
  (2, NULL, "Lyon", CURRENT_DATE()),
  (3, 9.99, "Paris", CURRENT_DATE()),
  (4, 50.0, "Marseille", CURRENT_DATE()),
  (5, 0.0, "Paris", CURRENT_DATE());
