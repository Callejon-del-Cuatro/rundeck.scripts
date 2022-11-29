#!/bin/bash

# Read Arguments
git_repo=$1
path=$2
branch=$3

#Git Clone / Git Pull
cd $path
echo "Path: ${path}"
subdirectory=`echo $git_repo | cut -d "/" -f 5`
subdirectory="${subdirectory}.${branch}"
echo "Subirectory: ${subdirectory}"
echo "Git Repository: ${git_repo}"
echo ""

if [ -d "$subdirectory" ]; then
    echo "Pulling Repository..."
    cd $subdirectory
    git pull
    git checkout $branch
    git pull
else
    echo "Cloning Repository..."
    git clone $git_repo $subdirectory
    cd $subdirectory
    git checkout $branch
fi

if [ -f "requirements.yml" ]; then
    echo "Getting roles with ansible-galaxy" 
    echo "Loading Virtualenv for Ansible 7"
    source /var/lib/rundeck/venvs/ansible7/bin/activate
    ansible-community --version
    echo ""
    ansible-galaxy install --force -r requirements.yml -p ./roles
    echo ""
fi
echo "Clone/Pull Finished"
echo ""