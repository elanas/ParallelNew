#!/bin/bash

rm output.csv
./make.sh

#declare -i z=8

for i in 0 1 2 3 4 
    do
        echo -e "\n--- # Threads = $i ---\n" >> output.csv  
        for n in `seq 1 20`;
            do
                declare -i t=2**$i
                declare -i n=$(($i + 18))
                echo -e "\nthreads: $t"


                java BruteForceDES "$t" "$n"
            done
    done 
