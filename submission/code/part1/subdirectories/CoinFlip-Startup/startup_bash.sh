#!/bin/bash

rm startup.csv
./make.sh

#declare -i z=8

for i in 1 2 4 8 16
    do
        echo -e "\n--- # Threads = $i ---\n" >> startup.csv  
        for n in `seq 1 20`;
            do
                echo -e "\nthreads: $i"
                java CoinFlip "$i" 0
            done
    done 
