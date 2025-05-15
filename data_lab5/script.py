import pandas as pd
from google.cloud import bigquery

# Chemin vers la table BigQuery
project_id = "projectbigquery0"  # Remplacez par votre ID de projet
dataset_id = "ventes_france"  # Remplacez par votre ID de dataset
table_id = "transactions"  # Remplacez par votre ID de table
table_ref = f"{project_id}.{dataset_id}.{table_id}"

# Étape 1 : créer des données factices
data = [
    {"id": 1, "store": "Paris", "amount": 100.0},
    {"id": 2, "store": "Lyon", "amount": None},
    {"id": 3, "store": "Marseille", "amount": 0},
    {"id": 4, "store": "Lille", "amount": 150.0},
    {"id": 5, "store": "Nice", "amount": 80.0},
    {"id": 6, "store": "Paris", "amount": 0},
    {"id": 7, "store": "Lyon", "amount": 75.0}
]

df = pd.DataFrame(data)

# Étape 2 : écrire en local (facultatif)
df.to_csv("transactions.csv", index=False)

# Étape 3 : importer dans BigQuery
client = bigquery.Client(project=project_id)

# Créer un schéma si nécessaire
job_config = bigquery.LoadJobConfig(
    autodetect=True,
    source_format=bigquery.SourceFormat.CSV,
    skip_leading_rows=1
)

with open("transactions.csv", "rb") as source_file:
    load_job = client.load_table_from_file(
        source_file,
        table_ref,
        job_config=job_config
    )

load_job.result()  # Attendre la fin du job
print(f"✅ Données importées dans {table_ref}")
