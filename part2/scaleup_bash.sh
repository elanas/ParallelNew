#!/bin/bash

rm scaleup.csv
javac BruteForceDES.java

#declare -i z=8

for i in 0 1 2 3 4 
    do
        echo -e "\n--- # Threads = $i ---\n" >> scaleup.csv  
        for n in `seq 1 20`;
            do
                declare -i t=2**$i
                declare -i n=$(($i + 18))
                echo -e "\nthreads: $t"


                java BruteForceDES "$t" "$n"
            done
    done 
