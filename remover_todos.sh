#!/bin/bash
set -e

echo "## DMC script"
WORKDIR=$PWD
# Agregar o quitar acorde al numero de alumnos
array=( alumno1 alumno2 alumno3 alumno4 alumno5 alumno6 alumno7 alumno8 alumno9 alumno10 alumno11 alumno12 alumno13 alumno14 alumno15 alumno16 alumno17 alumno18 alumno19 alumno20 alumno21 alumno22 alumno23 alumno24 alumno25 )
for alumno in "${array[@]}"
do
    echo "######### $alumno"
    cd $alumno/iac
    terraform destroy -var="name=$alumno" -auto-approve
    read  -n 1 -p "Revisar si los recursos de $alumno fueron eliminados. Presionar ENTER para continuar" rpta
    echo $rpta
    echo $PWD
    cd $WORKDIR
    rm -rf $alumno
done
