#!/bin/bash

usage()
{
cat << EOF
Extracts the amino acids in gyrA and/or parC qrdr regions in E coli

gyrA positions 83 and 87
parC positions 80 and 84

[inspect the alignments befor and remove indels, specially before the QRDR]

usage: $0 options


OPTIONS
	-h show help message
	-a protein alignment (in fasta)
	-g gene [gyrA/parC or g/p]
EOF
}

ALN=
GENE=
BIN="bin"
FASTBL="FasAln2tbl.pl"
GYRA="gyrA_QRDR.pl"
PARC="parC_QRDR.pl"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

while getopts "ha:g:" OPTION
do
	case $OPTION in
		h)
			usage
			exit 1
			;;
		a)
			ALN=$OPTARG
			;;
		g)
			GENE=$OPTARG
			;;
	esac 
done

if [[ -z ${ALN} ]] || [[ -z ${GENE} ]]
then
	echo "ERROR: Please supply the appropiate inputs"
        usage
        exit 1
fi

${DIR}"/"${BIN}"/./"${FASTBL} ${ALN} > ${ALN%%.*}.tbl

if [[ $GENE == "gyrA" ]] || [[ $GENE == "g" ]]
then
	echo "Analyzing QRDR region for GyrA"
	${DIR}"/"${BIN}"/./"${GYRA} ${ALN%%.*}.tbl
elif [[ $GENE == "parC" ]] || [[ $GENE == "p" ]]
then
	echo "Analyzing QRDR region for ParC"
	${DIR}"/"${BIN}"/./"${PARC} ${ALN%%.*}.tbl
else 
	echo "ERROR: wrong gene name:"
	rm ${ALN%%.*}.tbl
	usage
	exit 1
fi

rm ${ALN%%.*}.tbl
echo "results are in ${ALN%%.*}_QRDR_AA.tbl"


exit

