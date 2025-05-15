#BUCKET_NAME=campusnova-admissions-$(date +%s)
# REGION=europe-west9
# PROJECT_ID=$(gcloud config get-value project)

# # Création du bucket
# gsutil mb -p $PROJECT_ID -c standard -l $REGION "gs://$BUCKET_NAME"

# # Upload des fichiers
# gsutil cp -r ../../data_lab4/* "gs://$BUCKET_NAME/data_lab4/"

# ## Liste des fichiers
# gsutil ls -r "gs://$BUCKET_NAME/data_lab4/"

BUCKET_NAME=campusnova-admissions-1747300743

## Question 1

bq mk --location=europe-west9 --dataset admissions_lab_ihab

## Chargement des fichiers
bq load --source_format=CSV --autodetect \
    admissions_lab_ihab.etudiants \
    "gs://$BUCKET_NAME/data_lab4/etudiants.csv"

bq load --autodetect --source_format=NEWLINE_DELIMITED_JSON admissions_lab_ihab.inscriptions \
  gs://$BUCKET_NAME/data_lab4/inscriptions.json

bq load --source_format=AVRO admissions_lab_ihab.examens \
  gs://$BUCKET_NAME/data_lab4/examens.avro

bq load --source_format=PARQUET admissions_lab_ihab.resultats \
  gs://$BUCKET_NAME/data_lab4/resultats.parquet


## Question 2
bq mk --table admissions_lab_ihab.candidatures \
  id:INT64,nom:STRING,formation:STRING,score:FLOAT64,date_candidature:DATE

## Question 3
bq query --use_legacy_sql=false \
  'CREATE TABLE admissions_lab_ihab.candidats_2023 AS
SELECT *
FROM admissions_lab_ihab.candidatures
WHERE EXTRACT(YEAR FROM date_candidature) = 2023'

## Question 4
bq query --use_legacy_sql=false \
  'SELECT COUNT(*) AS total_candidatures
FROM admissions_lab_ihab.candidatures;'

## Question 5
bq query --use_legacy_sql=false --destination_table=admissions_lab_ihab.compte_candidats \
  'SELECT COUNT(*) AS total_candidatures
FROM admissions_lab_ihab.candidatures;'

## Question 6
bq query --use_legacy_sql=false  \
  'CREATE TABLE admissions_lab_ihab.candidatures_optimizees
PARTITION BY date_candidature
CLUSTER BY formation
AS
SELECT * FROM admissions_lab_ihab.candidatures;'

## Question 8
bq query --use_legacy_sql=false  \
  'CREATE VIEW admissions_lab_ihab.vue_filtree AS
SELECT id, nom, formation, score
FROM admissions_lab_ihab.candidatures
WHERE score > 15;'

## Question 9
bq query --use_legacy_sql=false  \
  'CREATE MATERIALIZED VIEW admissions_lab_ihab.mv_score_moyen AS
SELECT formation, AVG(score) AS moyenne_score
FROM admissions_lab_ihab.candidatures
GROUP BY formation;'