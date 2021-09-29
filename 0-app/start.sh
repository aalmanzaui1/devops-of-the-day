#!/bin/bash
export DJANGO_SETTINGS_MODULE=iotd.settings
export RDS_DB_NAME=""
export RDS_USERNAME=""
export RDS_PASSWORD=""
export RDS_HOSTNAME=""
export RDS_PORT=""
export S3_BUCKET_NAME=""
#pipenv run python ~/iotd/manage.py migrate
#pipenv run python ~/iotd/manage.py createsu
#pipenv run python ~/iotd/manage.py test
#pipenv run python ~/iotd/manage.py runserver

python /usr/src/app/iotd/manage.py migrate
python /usr/src/app/iotd/manage.py createsu
python /usr/src/app/iotd/manage.py test
python /usr/src/app/iotd/manage.py runserver