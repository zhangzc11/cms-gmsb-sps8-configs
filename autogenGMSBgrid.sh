#!/bin/sh

## config
year=${1:-"2016"}
if [[ "${year}" != "2016" ]] && [[ "${year}" != "2017" ]]
then
    echo "Only 2016 and 2017 are valid options for year! Exiting..."
    exit
fi

## template file
infile="GMSB_LXXXTeV_CtauYYYcm_Pythia8_13TeV_cff.py"

## output directory
outdir="Configuration/GenProduction/python/ThirteenTeV/GMSB"

## make directory
mkdir -p "${outdir}"

## loop over L, ctau: produce python configs
for lambda in 100 150 200 250 300 350 400
do
    for ctau in 10 50 100 200 400 600 800 1000 1200 10000
    do
	outfile="${outdir}/GMSB_L${lambda}TeV_Ctau${ctau}cm_Pythia8_13TeV_cff.py"

	sed "s/XXX/${lambda}/" <"${infile}" > "${outfile}"
	sed -i '' "s/YYY/${ctau}/" "${outfile}"

	if [[ "${year}" == "2016" ]]
	then
	    sed -i '' "s/FILE/Pythia8CUEP8M1/" "${outfile}"
	    sed -i '' "s/TUNE/CUEP8M1/" "${outfile}"
	elif [[ "${year}" == "2017" ]]
	then
	    sed -i '' "s/FILE/MCTunes2017.PythiaCP5/" "${outfile}"
	    sed -i '' "s/TUNE/CP5/" "${outfile}"
	else
	    echo "How did this happen?? Only 2016 and 2017 are valid years! Exiting..."
	    exit
	fi

    done
done
