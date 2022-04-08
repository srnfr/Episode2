#!/bin/bash

END=100

for i in $(seq 1 $END) ; do 
	kubectl create ns ns$i ; 
	kubectl apply -f webdemoNP.yml -n ns$i ; 
done 

