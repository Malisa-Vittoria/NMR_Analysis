#!/bin/bash

#The script should be run as 
# ./pk.sh input.txt output.txt

#Remove the headline and rows with not assigned resonances
sed '1d' $1 > $1_mod.txt

#Calculate the average and standard deviation of noise and save as avg_sd.txt
awk ' /None/ {print}' $1 >> noise_$1.txt
sed -i '/None/' $1

#Calculate the average and standard deviation of noise and save it as AVG_SD.txt
awk '{sum+=$4; a[NR]=$4}END{for (i in a) y+=(a[i]-(sum/NR))^2; print sum/NR,  sqrt(y/(NR-1))}' noise_$1.txt >> AVG_SD_$1.txt

#Calculate the gaussian error propagation  


#Write all sidechains into a new file
sed -i -e '/Hd/w sidechains.txt' -e '//d' $1 
sed -i -e '/Hb/w tmpfile' -e '$e cat tmpfile >> sidechains.txt && rm tmpfile' -e '//d' $1
sed -i -e '/He/w tmpfile' -e '$e cat tmpfile >> sidechains.txt && rm tmpfile' -e '//d' $1
cat sidechains.txt > sidechain_$2 && rm sidechains.txt 

#Convert inputfile (1a0.txt) --> outputfile (1_0.txt)
awk '{gsub("[^0-9.-]","",$3)}1' $1 > out.txt
awk '{print $1,$2,$3}' out.txt > $2
awk '{print $1,$2,$4,$3}' out.txt > I_$2 && rm out.txt
