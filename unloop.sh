#!/bin/bash

END=100

for i in $(seq 1 $END) ; do 
	kubectl delete ns ns$i --wait=false ;
done 

