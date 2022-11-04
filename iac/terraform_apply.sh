#!/bin/bash

terraform init
terraform init -upgrade # for plugins and modules
terraform apply -auto-approve
