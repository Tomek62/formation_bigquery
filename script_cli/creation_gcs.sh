### Création d'un bucket GCS
# Usage: ./creation_gcs.sh <BUCKET_NAME>
# Exemple: ./creation_gcs.sh my-bucket my-project-id
# Vérification des arguments

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <BUCKET_NAME>"
    exit 1
fi
# Récupération des arguments
BUCKET_NAME=$1
PROJECT_ID=$2
# Vérification de l'existence du bucket
if gsutil ls -b "gs://$BUCKET_NAME" &> /dev/null; then
    echo "Le bucket gs://$BUCKET_NAME existe déjà."
else
    # Création du bucket
    gsutil mb -p $PROJECT_ID -c standard -l europe-west9 "gs://$BUCKET_NAME"
    if [ $? -eq 0 ]; then
        echo "Le bucket gs://$BUCKET_NAME a été créé avec succès."
    else
        echo "Erreur lors de la création du bucket gs://$BUCKET_NAME."
        exit 1
    fi
fi