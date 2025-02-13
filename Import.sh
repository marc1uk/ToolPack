#!/bin/bash

if ! command -v dialog &> /dev/null
then
    
    if [ "$1" == "" ]
    then
	echo -e "Usage: ./Import <\"Toolname\" or \"All\">"
    elif [ "$1" == "All" ]
    then
	for Tool in `ls -d */|sed s:/::`
	do
	    ln -s `pwd`/$Tool ../../InactiveTools/$Tool
	done
    else
	test=0
	for Tool in `ls -d */`
	do
	    if [ "$1/" == "$Tool" ]
	    then
		ln -s `pwd`/$1 ../../InactiveTools/$1
	    fi
	done  
	
    fi
else
    num=0
    dialog --checklist "Select Tools to import with <spacebar>, Enter for OK and ESC for Cancel:" 0 0 0 \
    `for Tool in \`ls -d */|sed s:/::\`
    do
            echo "$Tool $num off "
          num=$(expr 1 + $num)
    done` 2> tmptools

  if [ $? -eq 0 ]
  then
      clear
      for Tool in `cat tmptools`
      do
	  ln -s `pwd`/$Tool ../../InactiveTools/$Tool
  	  echo -e "\e[38;5;226m$Tool Imported  \e[0m"
      done
      rm tmptools
      
  else clear
  fi
fi


