from google.cloud import bigquery

client = bigquery.Client()  # utilise l’auth par défaut
query = """
    SELECT name, SUM(number) as total
    FROM `bigquery-public-data.usa_names.usa_1910_2013`
    GROUP BY name
    ORDER BY total DESC
    LIMIT 10
"""
results = client.query(query)

for row in results:
    print(row.name, row.total)
