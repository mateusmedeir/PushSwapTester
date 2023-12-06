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


make -C ${PUSH_SWAP_PATH}
mkdir outputs
clear

#=================================== TESTERS ===================================#


printf "\n${BLUE}============== ${BOLD}PUSH SWAP TESTER${BLUE} ==============${RESET}\n"


#========================= MANDATORY =========================#


#BASIC TESTS

index=0
size=$(ls -l inputs/ | wc -l)

while [ $index -lt `expr $size - 1` ]
do
	${PUSH_SWAP_PATH}push_swap $(cat inputs/test-$index) 1> outputs/test-$index-result.txt 2> /dev/null
	cat outputs/test-$index-result.txt | wc -l 1> outputs/test-$index-instructions.txt
	cat outputs/test-$index-result.txt | ${PUSH_SWAP_PATH}checker $(cat inputs/test-$index) 1> outputs/test-$index-check.txt

	printf "\nTest $index: "

	if [ $(cat outputs/test-$index-check.txt | grep "OK" | wc -l) != 0 ]
	then
		printf "${OK}: ${BOLD}${YELLOW}$(cat outputs/test-$index-instructions.txt)${RESET} instructions"
	else
    		printf "${KO}"
	fi
	index=`expr $index + 1`
done

printf "\n"

printf "\n${BLUE}==============================================${RESET}\n\n"
printf "${OK} = passed the test\n"
printf "${KO} = did not pass the test\n"
printf "\nYou can see the logs in ${BOLD}outputs/${RESET}\n"
printf "\n${BLUE}==============================================${RESET}\n\n"
