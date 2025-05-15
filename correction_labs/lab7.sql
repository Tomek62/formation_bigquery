CREATE OR REPLACE FUNCTION ventes_france.mask_phone(phone_number STRING)
RETURNS STRING
AS (
    REGEXP_REPLACE(phone_number,r'^((\d{2})\s){3}','XX XX XX ')
);

SELECT ventes_france.mask_phone('06 12 34 44 44');