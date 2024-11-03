#!/bin/bash

#The script should be run as
#./I_norm.sh PeaklistFile_free PeaklistFile_bound OutputFilename


#converts scientific notation to for bc readable format
awk '{print $3}' $1 > I_0.txt
cat 'I_0.txt' 

awk '{print $3}' $2 > I.txt
cat 'I.txt'

awk '{print $4}' $1 > resn
cat 'resn'

paste I_0.txt I.txt > Intensities.txt && rm -f I_0.txt I.txt
awk '{printf "%.15f\n", ($2/$1)}' Intensities.txt > int && rm -rf Intensities.txt

#takes the maximum I/I0 ratio and normalizes all I/I0 ratios by the maximum I/I0 value
awk 'NR == FNR {if(max<$1) {max=$1}; next} {$1 = $1 / max}1' int int >> int_norm

#Calculate the average and standard deviation of noise and save it as AVG_SD.txt
awk '{sum+=$4; a[NR]=$4}END{for (i in a) y+=(a[i]-(sum/NR))^2; print sum/NR,  sqrt(y/(NR-1))}' noise_$1 >> AVG_SD_$1
awk '{sum+=$4; a[NR]=$4}END{for (i in a) y+=(a[i]-(sum/NR))^2; print sum/NR,  sqrt(y/(NR-1))}' noise_$2 >> AVG_SD_$2


#calculates the error of relative change in intensity and saves it as a file
#awk '{print ($2/$1)*sqrt((sd/$1)^2 + (sd_2/$2)^2)}' 

#for i in "${!a[@]}" ; do echo "scale=7 ; ((${b[i]}/${a[i]})*sqrt((342.2969715513/${a[i]})^2+(404.8532606767/${b[i]})^2))" | bc -l >> error_int_1_05 ; done

#writes the residue numbers and the corresponding intensity change into a file 
#paste resn int_norm >> $3.dat && rm -f resn int int_norm 

