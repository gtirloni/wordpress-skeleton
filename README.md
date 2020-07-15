# WordPress skeleton

WordPress website skeleton project, managed with PHP Composer and based on [Bedrock](https://roots.io/bedrock).

## Requirements

* [PHP](https://php.net) >= 7.4
* [Composer](https://getcomposer.org/) >= 1.10
* [Docker CE](https://docs.docker.com/install) >= 19.03
* [Docker Compose](https://docs.docker.com/compose) >= 1.26

## Getting started

* Make sure that at least Docker CE and Docker Compose are installed (PHP and Composer will run from within containers)
* Clone this repository
* Run `make install`
* Run `make start`
* Access [http://localhost:8080](http://localhost:8080)

## Project Structure

The project is based on the [Bedrock](https://roots.io/bedrock) Wordpress structure:

```text
├── composer.json
├── config
│   ├── application.php
│   └── environments
│       ├── development.php
│       ├── staging.php
│       └── production.php
├── vendor
└── web
    ├── app
    │   ├── mu-plugins
    │   ├── plugins
    │   ├── themes
    │   └── uploads
    ├── wp-config.php
    ├── index.php
    └── wp
```

The basic philosophy is that the WordPress admin panel is **not** used to manage WordPress, except to create content. This enforces the separation of code, configuration and data.

## Local development environment

The local development environment is based on Docker Compose and can be started by using the `make` command.

```text
$ make help

Usage:
  make <target>

Targets:
  help             Display this help
  build            Build new images
  clean            Stop and remove containers
  clean-all        Stop and remove containers, images and volumes (CAREFUL)
  clean-db         Remove volume containing database
  clean-wordpress  Remove volume containing project code
  install          Performs initial project configuration (install packages, etc.)
  logs             Show container logs
  restart          Stop and start containers
  start            Start containers, network and volumes
  stop             Stop containers
  status           Show container and volume statuses
  update           Update Composer packages

```

All the configuration is done through [environment variables](https://roots.io/bedrock/docs/environment-variables/).

The `.env` file in the project rootdir comes with default settings that you can customize as necessary. It's only used in the local development environment (in production/staging we make use of the platform's preferred way to manage environment variables).
