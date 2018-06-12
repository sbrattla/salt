# MariaDB

This profile installs MariaDB with support for multiple database instances. Each database instance runs as its own
process and data directory - and has it's own configuration section in `/etc/mysql/my.cnf`.

Configuration of each database instance is done in the configuration file `/etc/mysql/my.cnf`. You only need to set
parameters unique to each database instance. If a parameter is not set for an instance, it will either use the one
set for `[mysqld]` or the default MariaDB value.

`/etc/mysql/my.cnf`

```
[mysqld]
...
...
...
...

[mysqld7182]
user                    = mysql
pid-file                = /var/run/mysqld/mysqld7182.pid
socket                  = /var/run/mysqld/mysqld7182.sock
port                    = 7182
datadir                 = /var/lib/mysql7182
slow_query_log_file     = /var/log/mysql/mariadb7182-slow.log

[mysqld7184]
user                    = mysql
pid-file                = /var/run/mysqld/mysqld7184.pid
socket                  = /var/run/mysqld/mysqld7184.sock
port                    = 7184
datadir                 = /var/lib/mysql7184
slow_query_log_file     = /var/log/mysql/mariadb7184-slow.log

```

## Adding a new database instance

Let's assume you want to add a new database instance. The first thing you need to do is to specify a new `[mysqldX]` block 
in `/etc/mysql/my.cnf` :

```
[mysqld7190]
user                    = mysql
pid-file                = /var/run/mysqld/mysqld7190.pid
socket                  = /var/run/mysqld/mysqld7190.sock
port                    = 7190
datadir                 = /var/lib/mysql7190
slow_query_log_file     = /var/log/mysql/mariadb7190-slow.log
```

Note 1! It is very important that you validate the naming of `pid-file`, `socket`, `port`, `datadir` and `slow_query_log_file`
when you set up a new instance.

Note 2! You must use a number to represent a database instance. You can not name a database instance e.g. `[mysqldsolar_drupaldb]`.

#### Starting from scratch? 

You can initialise the database with a blank schema:

```
bin/mysqld --initialize --user=mysql
         --datadir=/var/lib/mysql7190
```

If you'd like to start the database instance using existing data, then you'd have to copy that database into the data
directory `/var/lib/mysql7190`.

#### Starting from an existing database?

Copy the database into `/var/lib/mysql/7190`.

#### Ready?

To start, stop or restart e.g. the 7190 instance, simply run `service mysqld_multi@7190 start|stop|restart`.
