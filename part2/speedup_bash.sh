#!/bin/bash

rm speedup.csv
javac BruteForceDES.java

#declare -i z=8

for i in 1 2 4 8 16
    do
        echo -e "\n--- # Threads = $i ---\n" >> speedup.csv  
        for n in `seq 1 20`;
            do
                echo -e "\nthreads: $i"
                java BruteForceDES "$i" 22
            done
    done 
