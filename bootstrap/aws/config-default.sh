#!/bin/bash

# Keeping atlas variable without prefix as it's been shared by consul and tf at the moment.
export ATLAS_TOKEN=${ATLAS_TOKEN:?"Need to set ATLAS_TOKEN non-empty"}
export ATLAS_INFRASTRUCTURE=${ATLAS_INFRASTRUCTURE:-capgemini/apollo}

export TF_VAR_user=${TF_VAR_user:?"Need to set User non-empty"}
export TF_VAR_access_key=${TF_VAR_access_key:?"Need to set TF_VAR_access_key non-empty"}
export TF_VAR_secret_key=${TF_VAR_secret_key:?"Need to set TF_VAR_secret_key non-empty"}
export TF_VAR_key_file=${TF_VAR_key_file:-$HOME/.ssh/apollo_aws_rsa}
export TF_VAR_key_name=${TF_VAR_key_name:-apollo}

# Overrides default folder in Terraform.py inventory.
export TF_VAR_STATE_ROOT="${APOLLO_ROOT}/terraform/aws"

export ANSIBLE_SSH_ARGS="-F ${APOLLO_ROOT}/terraform/${APOLLO_PROVIDER}/ssh.config -q"

# Terraform mappings needs to be statically passed as -var parameters
# so no really needed to export them. Exporting for consitency.
export TF_VAR_atlas_artifact_master=${TF_VAR_atlas_artifact_master:-capgemini/apollo-ubuntu-14.04-amd64}
export TF_VAR_atlas_artifact_slave=${TF_VAR_atlas_artifact_slave:-capgemini/apollo-ubuntu-14.04-amd64}
export TF_VAR_atlas_artifact_version_master=${TF_VAR_atlas_artifact_version_master:-latest}
export TF_VAR_atlas_artifact_version_slave=${TF_VAR_atlas_artifact_version_slave:-latest}

export TF_VAR_region=${TF_VAR_region:-eu-west-1}
export TF_VAR_master_size=${TF_VAR_master_size:-m1.medium}
export TF_VAR_slave_size=${TF_VAR_slave_size:-m1.medium}
export TF_VAR_slaves=${TF_VAR_slaves:-1}
export TF_VAR_zone-0=${TF_VAR_zone-0:-eu-west-1a}
export TF_VAR_zone-1=${TF_VAR_zone-1:-eu-west-1b}
export TF_VAR_zone-2=${TF_VAR_zone-2:-eu-west-1c}

export APOLLO_consul_dc=${APOLLO_consul_dc:-$TF_VAR_region}
export APOLLO_mesos_cluster_name=${APOLLO_mesos_cluster_name:-$TF_VAR_region}
