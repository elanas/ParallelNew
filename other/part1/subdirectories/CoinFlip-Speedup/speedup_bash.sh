#!/bin/bash

rm speedup.csv
./make.sh
# javac CoinFlip.java
#declare -i z=8

for i in 1 2 4 8 16
    do
        echo -e "\n--- # Threads = $i ---\n" >> speedup.csv  
        for n in `seq 1 20`;
            do
                echo -e "\nthreads: $i"
                java CoinFlip "$i" 1000000000
            done
    done 
