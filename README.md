# docker-lamp
Docker containers with Apache, MySql 5.7, PhpMyAdmin and PHP fully supporting system Anton

**FOR ANTON YOU HAVE TO GET ACCESS FROM MENDELU**

# Install on Fedora

```
git clone https://github.com/rvsia/docker-lamp-for-Anton.git
```

Create a folder "dump" where you should insert a dump of Anton database called "myDb.sql"

```
mkdir dump
cp path-to-my-dump dump/myDb.sql
```
Now you should clone repository of Anton

```
cd www
git clone http://git.pef.mendelu.cz/xvsiansk/anton.git
```

# Usage

```
sudo docker-compose up
```

Go to **localhost:8000** (root, test) and run a command (**always**!)

```
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
```

That's it! Let's go make a magic!

Anton should be running on **localhost:8001/anton/www**

PHPMyAdmin on **localhost:8000**

Main script for comparing documents

```
sudo docker exec dockerlamp_www_1 /var/www/html/anton/app/backend/do-all.sh
```

# Possible problems

1. Look into log files in Anton/log
2. Be sure you have right permissions on your Host: Docker should have writable rights in an-data, an-data-sc, temp, log and it should be able to execute scripts in app/backend

# FAQ

1. How to setup debug mode?

Go to `app/bootstrap.php` and setup `Debugger::enable();` with no specific IP address

2. Could not find driver

Change driver in `app/config/config.neon` to mysql

3. Cannot run the comparison sciprt

Change driver back to `mysqli` (just for the script)

# TODO

1. Setup database right to not write the SQL command everytime
