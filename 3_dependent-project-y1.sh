#!/bin/bash
#
# This script creates  SONATA project with external dependencies based on the demo 
# for year 1.
# It receives two arguments, the workspace location and the path where the project
# should be created
#

# Verify vars and arguments

if [ "$SON_WORKDIR" == "" ]; then
        echo "Need to set SON_WORKDIR (location of son-workspace, son-package, son-publish, son-push)"
        exit 1
fi

if [[ $# < 2 ]] || [[ $# > 3 ]]; then
        echo "Usage: `basename "$0"` <workspace_location> <project_location> [<project template>]"
        exit 1
fi
 
if [[ $# == 2 ]]; then
        new_project=true
elif [[ $# == 3 ]]; then
        new_project=false
        project_template=$3
fi

# Define global parameters
eval SON_WORKDIR=$SON_WORKDIR
set -xe
timestamp="$(date +%s).$(date +%N)"
package_dir="packages.$timestamp"

# Create project

if [[ "$new_project" = true ]]; then
        $SON_WORKDIR/son-workspace --workspace $1 --project $2
else 
        # Create predefined project. Make project incomplete, remove some VNFs
        unzip -o $project_template
        mv project-Y1 $2
	rm -rf $2/sources/vnf/firewall
	rm -rf $2/sources/vnf/iperf
fi

# Package project
$SON_WORKDIR/son-package --workspace $1 --project $2 -d $package_dir -n project-Y1

# Push packaged project to Gatekeeper
$SON_WORKDIR/son-push http://127.0.0.1:5000 -U $package_dir/project-Y1.son

