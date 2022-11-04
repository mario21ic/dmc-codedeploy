#!/bin/bash

packer init config.pkr.hcl # install plugins
packer build template.pkr.hcl
