#!/bin/bash
#
# This script creates a SONATA workspace and configures it with the appropriate
# catalogue servers and schema repositories, for integration tests
# It receives one argument to declare  where the workspace should be created
#

# Verify vars and arguments
if [ "$SON_WORKDIR" == "" ]; then
	echo "Need to set SON_WORKDIR (location of son-workspace, son-package, son-publish, son-push)"
	exit 1
fi

if [[ $# != 1 ]]; then
	echo "Usage: `basename "$0"` <workspace_location>"
	exit 1
fi 

# Define global parameters
eval SON_WORKDIR=$SON_WORKDIR
set -xe
export cat_server1="http://192.168.56.101:4011"


# Create workspace
$SON_WORKDIR/son-workspace --init --debug --workspace $1

# Configure workspace
sed -ri '/^.*catalogue_servers:|id:|publish:|url:.*$/d' $1/workspace.yml
echo -e "catalogue_servers:\n- id: cat1\n  publish: 'yes'\n  url: $cat_server1" >> $1/workspace.yml

