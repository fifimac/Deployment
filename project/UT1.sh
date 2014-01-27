#!/bin/bash
# Unit Test Script
# Level 0 functions

# create is isRunning function
function isRunning {

PROCESS_NUM=$(ps -ef | grep "$1" | grep -v "grep" | wc -l)
if [ $PROCESS_NUM -gt 0 ] ; then
        return 1
else
        return 0
fi
}

# Unit Test isRunning on known Level 0 function
# This should return true

echo "Unit Testing isRunning"
isRunning apache2
if  [ $? -eq 1 ]; then

        echo "UT of isRunning Passed - Apache process found"
else
        echo "UT of isRunning failed - Apache process not found?????"
fi

# Unit Test isRunning on fake Level 0 function
# This should return false


isRunning Dummy
if  [ $? -eq 0 ];then
       echo "UT of isRunning passed - Did not find Dummy Process"
else
       echo "UT of isRunning failed - found Dummy process????"
fi

