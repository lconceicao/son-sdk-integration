#!/bin/bash

#cleanup
./cleanup.sh
./clean-catalogue-server.sh 192.168.56.101 4011


export SON_WORKDIR="/home/lconceicao/pycharm_projects/son-cli/bin"

./1_create_son_workspace.sh ws1

# son-emu
./1_create_son_workspace.sh ws1
./2_standalone-project-y1.sh ws1 prj1 resources/project-Y1-emu.zip
./3_dependent-project-y1.sh ws1 prj2 resources/project-Y1-emu.zip

# clean catalogues
./clean-catalogue-server.sh 192.168.56.101 4011


# son-sp
./1_create_son_workspace.sh ws2
./2_standalone-project-y1.sh ws2 prj3 resources/project-Y1-sp.zip
./3_dependent-project-y1.sh ws2 prj4 resources/project-Y1-sp.zip


