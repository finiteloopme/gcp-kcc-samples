#!/bin/bash

export PROJECT_ID_PREFIX=kl-k8s
export PROJECT_MGMT=mgmt
export PROJECT_DEV=dev
export PROJECT_PROD=prod
export FOLDER_ID=318624525653
export PROJECT_ID="${PROJECT_ID_PREFIX}-${PROJECT_MGMT}"
export GSA_ID=gsa-cnrm-system
export GSA_EMAIL="${GSA_ID}@${PROJECT_ID}.iam.gserviceaccount.com"
export BILLING_ACCOUNT_ID="018FA1-1C556F-6B1100"

gcloud projects create ${PROJECT_ID} --folder=${FOLDER_ID}
gcloud services enable container.googleapis.com --project ${PROJECT_ID}

gcloud alpha billing projects link ${PROJECT_ID} --billing-account $BILLING_ACCOUNT_ID

gcloud iam service-accounts create ${GSA_ID} --project ${PROJECT_ID}
gcloud alpha resource-manager folders add-iam-policy-binding ${FOLDER_ID} --member "serviceAccount:${GSA_EMAIL}" --role roles/resourcemanager.projectCreator
gcloud iam service-accounts keys create --iam-account "${GSA_EMAIL}" ./key.json
