#!/usr/bin/bash

SANDBOX=sandbox_$RANDOM

echo Using sandbox $SANDBOX

#

#Stop services

sudo /etc/init.d/apache2 stop

sudo /etc/init.d/mysql stop

#

apt-get update

#

apt-get -q -y remove apache2

apt-get -q -y install apache2

#

apt-get -q -y remove mysql-server mysql-client

echo mysql-server mysql -server/root_password password password | debconf-set-selections

echo mysql-server mysql-server/root_password_again password password | debconf-set-selections

apt-get -q -y install mysql-server mysql-client


# clone the project files from github

cd /tmp

mkdir $SANDBOX

cd $SANDBOX/

git clone https://github.com/FSlyne/NCIRL.git

cd NCIRL/

# change file locations

cp Apache/www/* /var/www/

cp Apache/cgi-bin/* /usr/lib/cgi-bin/

chmod a+x /usr/lib/cgi-bin/*


#Start services

/etc/init.d/apache2 start

/etc/init.d/mysql start

#

cat <<FINISH | mysql -uroot –ppassword
# drop database if exists

drop database if exists dbtest;

CREATE DATABASE dbtest;

GRANT ALL PRIVILEGES ON dbtest.* TO dbtestuser@localhost IDENTIFIED BY 'dbpassword';

use dbtest;

drop table if exists custdetails;

create table if not exists custdetails

(

name VARCHAR(30) NOT NULL DEFAULT'',

address VARCHAR(30) NOT NULL DEFAULT''

);
# add content to table custdetails in database

insert into custdetails (name,address) values ('John Smith','Street Address');

select * from custdetails;

# end script
