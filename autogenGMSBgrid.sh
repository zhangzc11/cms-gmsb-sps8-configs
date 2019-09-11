#!/bin/sh

## config
year=${1:-"2016"}
if [[ "${year}" != "2016" ]] && [[ "${year}" != "2017" ]] && [[ "${year}" != "2018" ]]
then
    echo "Only 2016, 2017 and 2018 are valid options for year! Exiting..."
    exit
fi

## template file
infile="GMSB_LXXXTeV_CtauYYYcm_Pythia8_13TeV_cff.py"
infile_2018="GMSB_LXXXTeV_CtauYYYcm_Pythia8_13TeV_cff_2018.py"

## output directory
outdir="Configuration/GenProduction/python/ThirteenTeV/GMSB"

## make directory
mkdir -p "${outdir}"

## loop over L, ctau: produce python configs
for lambda in 100 150 200 250 300 350 400 450 500
do
    for ctau in 10 50 100 200 400 600 800 1000 1200 10000
    do
	outfile="${outdir}/GMSB_L${lambda}TeV_Ctau${ctau}cm_Pythia8_13TeV_cff.py"
	if [[ "${year}" == "2016" ]]
	then
	    sed "s/XXX/${lambda}/" <"${infile}" > "${outfile}"
	    sed -i '' "s/YYY/${ctau}/" "${outfile}"
	    sed -i '' "s/FILE/Pythia8CUEP8M1/" "${outfile}"
	    sed -i '' "s/TUNE/CUEP8M1/" "${outfile}"
	elif [[ "${year}" == "2017" ]]
	then
	    sed "s/XXX/${lambda}/" <"${infile}" > "${outfile}"
	    sed -i '' "s/YYY/${ctau}/" "${outfile}"
	    sed -i '' "s/FILE/MCTunes2017.PythiaCP5/" "${outfile}"
	    sed -i '' "s/TUNE/CP5/" "${outfile}"
	elif [[ "${year}" == "2018" ]]
	then
	    sed "s/XXX/${lambda}/" <"${infile_2018}" > "${outfile}"
	    sed -i "s/YYY/${ctau}/" "${outfile}"
	else
	    echo "How did this happen?? Only 2016, 2017 and 2018  are valid years! Exiting..."
	    exit
	fi

    done
done
