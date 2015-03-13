#!/bin/bash

rm scaleup.csv
javac CoinFlip.java

#declare -i z=8

for i in 1 2 4 8 16
    do
        echo -e "\n--- # Threads = $i ---\n" >> scaleup.csv  
        for n in `seq 1 1`;
            do
                echo -e "\nthreads: $i"
                java CoinFlip "$i" 1000000000
            done
    done 
