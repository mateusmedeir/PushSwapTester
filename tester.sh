#!/bin/bash

PUSH_SWAP_PATH="../"

BLUE="\033[1;34m"
GREEN="\033[1;32m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
BOLD="\033[1;37m"
RESET="\033[0m"

OK=" ${GREEN}[ OK ]${RESET}"
KO=" ${RED}[ KO ]${RESET}"

paths=($(ls -v inputs))

make -C ${PUSH_SWAP_PATH}
mkdir outputs

counter=0
size_inputs=$(ls -vl inputs | grep -v '^total' | wc -l)

while [ $counter -lt $size_inputs ]
do
	mkdir outputs/${paths[$counter]}
	counter=`expr $counter + 1`
done

clear

#=================================== TESTERS ===================================#


printf "\n${BLUE}============== ${BOLD}PUSH SWAP TESTER${BLUE} ==============${RESET}\n"

counter=0

while [ $counter -lt $size_inputs ]
do
	printf "\n${BOLD}$(echo ${paths[$counter]} | tr 'a-z' 'A-Z') INPUTS${RESET}\n"

	index=0
	size=$(ls -l inputs/${paths[$counter]} | grep -v '^total' | wc -l)
	while [ $index -lt $size ]
	do
		${PUSH_SWAP_PATH}push_swap $(cat inputs/${paths[$counter]}/test-$index) 1> outputs/${paths[$counter]}/test-$index-result.txt 0> /dev/null
		cat outputs/${paths[$counter]}/test-$index-result.txt | wc -l 1> outputs/${paths[$counter]}/test-$index-instructions.txt
		cat outputs/${paths[$counter]}/test-$index-result.txt | ${PUSH_SWAP_PATH}checker $(cat inputs/${paths[$counter]}/test-$index) 1> outputs/${paths[$counter]}/test-$index-check.txt

		printf "\nTest $index:"
	
		if [ $(cat outputs/${paths[$counter]}/test-$index-check.txt | grep "OK" | wc -l) != 0 ]
		then
			printf "${OK}: ${BOLD}${YELLOW}$(cat outputs/${paths[$counter]}/test-$index-instructions.txt)${RESET} instructions"
		else
    			printf "${KO}"
		fi
		index=`expr $index + 1`
	done

	printf "\n"
	counter=`expr $counter + 1`
done

printf "\n${BLUE}==============================================${RESET}\n\n"
printf "${OK} = passed the test\n"
printf "${KO} = did not pass the test\n"
printf "\nYou can see the logs in ${BOLD}outputs/${RESET}\n"
printf "\n${BLUE}==============================================${RESET}\n\n"
