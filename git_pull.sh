#!/bin/bash
#Git Clone / Git Pull
cd $RD_OPTION_PATH
echo "Path: ${RD_OPTION_PATH}"
SUBDIRECTORY=`echo $RD_OPTION_GIT_REPOSITORY | cut -d "/" -f 5`
SUBDIRECTORY="${SUBDIRECTORY}.${RD_OPTION_BRANCH}"
echo "Subirectory: ${SUBDIRECTORY}"
echo "Git Repository: ${RD_OPTION_GIT_REPOSITORY}"
echo ""

if [ -d "$SUBDIRECTORY" ]; then
    echo "Pulling Repository..."
    cd $SUBDIRECTORY
    git pull
    git checkout $RD_OPTION_BRANCH
    git pull
else
    echo "Cloning Repository..."
    git clone $RD_OPTION_GIT_REPOSITORY $SUBDIRECTORY
    cd $SUBDIRECTORY
    git checkout $RD_OPTION_BRANCH
fi

if [ -f "requirements.yml" ]; then
    echo "Getting roles with ansible-galaxy" 
    echo "Loading Virtualenv for Ansible 7"
    source /var/lib/rundeck/venvs/ansible7/bin/activate
    ansible-community --version
    echo ""
    ansible-galaxy install -r requirements.yml -p ./roles
    echo ""
fi
echo "Clone/Pull Finished"
echo ""