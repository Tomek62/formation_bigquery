from google.cloud import bigquery
import functions_framework

@functions_framework.http
def generate_report(request):
    client = bigquery.Client()
    query = """
    SELECT
      flight_date AS date,
      carrier,
      delay_cause AS cause,
      SUM(num_delays) AS num_delays
    FROM
      `projectbigquery0.causes_delay.us_delay_causes`
    WHERE
      flight_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY)
    GROUP BY
      date, carrier, cause
    HAVING
      num_delays > 15
    """

    try:
        job_config = bigquery.QueryJobConfig(destination="`projectbigquery0.causes_delay.daily_flight_report`", write_disposition="WRITE_TRUNCATE")
        query_job = client.query(query, job_config=job_config)
        query_job.result()
        return "✅ Rapport généré avec succès", 200
    except Exception as e:
        return f"❌ Erreur: {str(e)}", 500