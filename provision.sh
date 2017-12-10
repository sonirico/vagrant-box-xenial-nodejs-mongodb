#!/bin/bash

set -e


# unnatended apt installations
APT_OPTS="-uy -q --allow-unauthenticated --no-install-recommends"

# update system
apt-get update ;
apt-get upgrade $APT_OPTS ;

apt-get install build-essential libssl-dev $APT_OPTS ;
apt-get install git vim  $APT_OPTS ;


function nodejs_install () {
    echo -e '\n\tInstalling nodejs...\n';

    wget -O /opt/nodejs.tar.xz https://nodejs.org/dist/v9.2.1/node-v9.2.1-linux-x64.tar.xz
    cd /opt ;
    tar xfvs nodejs.tar.xz ;
    rm -f /usr/bin/node ;
    ln -s /opt/node-v9.2.1-linux-x64/bin/node /usr/bin/node ;

    # Cleanup
    rm -rf nodejs.tar.xz ;
};

function mongodb_install () {
    echo -e '\n\tInstalling mongo...\n';

    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5;
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list;
    apt-get update;
    apt-get install mongodb-org $APT_OPTS;

    echo "mongodb-org hold" | sudo dpkg --set-selections ;
    echo "mongodb-org-server hold" | sudo dpkg --set-selections ;
    echo "mongodb-org-shell hold" | sudo dpkg --set-selections ;
    echo "mongodb-org-mongos hold" | sudo dpkg --set-selections ;
    echo "mongodb-org-tools hold" | sudo dpkg --set-selections ;

    echo -e '\n\tStarting mongo...\n';
    service mongod start;
};


nodejs_install;
mongodb_install;