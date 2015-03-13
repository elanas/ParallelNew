#!/bin/bash

rm speedup.csv
javac CoinFlip.java

declare -i z=16

for i in `seq 1 "$z"`;
    do
        echo -e "\n--- # Threads = $i ---\n" >> speedup.csv  
        for n in `seq 1 1`;
            do
                # echo -e "\nthread $i"
                java CoinFlip "$i" 100000000
            done
    done 
