#!/bin/bash

set -e

while true
    do
        echo "Howdy Texas Tribune"
        sleep 5
    done

#Alternative way to trigger a python script (aws ec2 come with python3 installed). 
#However, I recommend not using python code in this way. Only run things that are runnable with
#bash to prepare the instance environment.
# cd /home
# git clone https://github.com/user/data_pipeline.py
# cd /home/sample_script
# chmod +x pipeline.py
# while true
#     do
#         python3 pipeline.py
#         sleep 5
#     done


#Or use a docker