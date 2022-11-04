#!/bin/bash
set -e
set -x

echo "## DMC script"
WORKDIR=$PWD
# Agregar o quitar acorde al numero de alumnos
array=( alumno1 alumno2 alumno3 alumno4 alumno5 alumno6 alumno7 alumno8 alumno9 alumno10 alumno11 alumno12 alumno13 alumno14 alumno15 alumno16 alumno17 alumno18 alumno19 alumno20 alumno21 alumno22 alumno23 alumno24 alumno25 )
for alumno in "${array[@]}"
do
    echo "######### $alumno"
    git clone https://github.com/mario21ic/dmc-codedeploy.git $alumno
    cd $alumno/iac
    #cp ~/Alo2.pem ./
    terraform init
    terraform apply -var="name=$alumno" -auto-approve
    read  -n 1 -p "COPIAR Codedeploy nombres y EC2 IP Publicas del $alumno. Presionar ENTER para continuar" rpta
    echo $rpta
    echo $PWD
    cd $WORKDIR
done


