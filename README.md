emenu_deploy
============

## Initial Setup
### Step 1
Install virutal box and vagrant

### Step 2
Clone git repos into the same directory:

    git clone https://github.com/zhoulijoe/emenu_deploy.git
    git clone https://github.com/zhoulijoe/emenu_server.git

### Step 3
Create Ubuntu 12.04 virtual box:

    cd emenu_deploy
    vagrant up

### Step 4
Compile server code:
    
    # ssh to ubuntu VM from emenu_deploy directory
    cd emenu_deploy
    vagrant ssh
    
    # compile server code
    cd ~/emenu_server
    ./deploy

    # restart tomcat server
    sudo service tomcat7 restart

## View management web app
### Get VM server ip address

    # ssh to ubuntu VM from emenu_deploy directory
    cd emenu_deploy
    vagrant ssh

    # get server ip address, use ip address of eth1 adapter
    ifconfig
    
### View web app from browser
Point browser to http://[ip address]:8080

## Test with Android app
### Get VM server ip address

    # ssh to ubuntu VM from emenu_deploy directory
    cd emenu_deploy
    vagrant ssh

    # get server ip address, use ip address of eth1 adapter
    ifconfig
    
### Connect Android app to server
Configure Android app to [ip address]:8080

## Update server code
### Get latest source code from git repo

    # git pull from emenu_server directory
    git pull

### Recompile server code and restart web server

    # ssh to ubuntu VM from emenu_deploy directory
    cd emenu_deploy
    vagrant ssh
    
    # compile server code
    cd ~/emenu_server
    ./deploy

    # restart tomcat server
    sudo service tomcat7 restart
