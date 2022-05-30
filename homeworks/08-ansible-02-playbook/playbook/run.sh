#!/usr/local/env bash
docker-compose up -d
ansible-playbook --diff -i inventory/prod.yml site.yml
#docker-compose down
