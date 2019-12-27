# How to initialize Senzing with Docker

## Overview

Instructions for installing [Senzing API](../WHATIS/senzing-api.md)
using Docker containers.

### Contents

1. [Install Senzing](#install-senzing)
1. [Install database drivers](#install-database-drivers)
    1. [Postgresql](#postgresql)
    1. [MySQL](#mysql)
    1. [SQLite](#sqlite)
    1. [Db2](#db2)
    1. [MS SQL](#ms-sql)
1. [Initialize Senzing](#initialize-senzing)
1. [References](#references)

## Install Senzing

1. Install Senzing files using docker container.
    1. See [senzing/yum](https://github.com/Senzing/docker-yum) documentation.

## Install database drivers

**Note:**
Docker formations
(e.g. [docker-compose-demo](https://github.com/Senzing/docker-compose-demo))
will install database drivers.
If using a docker formation, the "Install database drivers" step may be skipped;
proceed to [Configure](#configure) step.

### Postgresql

1. No additional steps.

### MySQL

1. No additional steps.

### SQLite

1. No additional steps.

### Db2

1. See [How to support Db2](support-db2.md).

### MS SQL

1. See [How to support MS SQL](support-mssql.md).

## Initialize Senzing

1. Initialize Senzing using docker container or command line
    1. See [senzing/init-container](https://github.com/Senzing/docker-init-container) documentation.

## References
