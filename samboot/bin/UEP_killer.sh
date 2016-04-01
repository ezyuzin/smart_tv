#!/bin/sh

while : 
do 
	ps | grep UEP.b | grep -v grep | while read child_pid others
	do
		echo "Killing child process $child_pid of UEP.b"
		kill -9 $child_pid
	done 
    sleep 10 
done 

