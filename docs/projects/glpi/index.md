---
title: Dockerized GLPI
description: How to use No Fuss Computings docker container GLPI.
date: 2023-08-29
template: project.html
about: https://gitlab.com/nofusscomputing/projects/ansible/docker-glpi
---

This docker container contains GLPI and is intended to be production ready and requires minimal configuration to use.

!!! info
    **TLDR** The docker container is available on dockerhub. `docker pull nofusscomputing/docker-glpi:dev`

This container is designed to be ephemeral with all data residing within docker volumes. Outside of this container, the only reqirements is hard disk space and a MySQL/MariaDB database.


## Features

To see a full list of changes/features see the [changelog](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/blob/development/CHANGELOG.md).

- Data Volumes for _(relative paths are for glpi www root, `/var/www/html`)_

    - `config/`

    - `data/`

    - `files/`

    - `plugins/`

    - `marketplace/`

    - `/var/log/`

- Inventory endpoints only available with use of feature flag

- Container health check reports for all services (apache, cron, supervisord)

- GLPI cron script scheduled within container cron. _See notes below._

- GLPI WWW root setup under `public/`


## Cron

Cron is installed as part of the image and runs automagically on container start. GLPI cron script is also scheduled to run every minute. However for GLPI to use the CLI cron, you must configure it.

Once GLPI has been setup and configured: 

1. navigate to `Setup -> Automatic Actions`

1. select all items in the list

1. click the `Actions` button

1. select `Update`

1. select `Run Mode`

1. select `CLI`

1. click `Submit`

Now GLPI will use the CLI cron script to run automagic actions.


## Inventory

It is posssible to use the inventory features available within GLPI, however by default access to the endpoints is disabled and behind a feature flag.The image by default will return HTTP/404 for the following paths:

- `plugins/fusioninventory/` fusioninventory

- `front/inventory.php` Native (non-GlpiInventory plugin)

- `marketplace/glpiinventory/` GlpiInventory plugin (Marketplace installed)

- `plugins/glpiinventory/` GlpiInventory plugin (plugin folder installed)

To enable an inventory endpoint, using the values above, set environmental variable `GLPI_INVENTORY_PATH` when launching the container. i.e. to use GLPI native inventory `GLPI_INVENTORY_PATH=front/inventory.php`. on launching the container with this variable set, that endpoint is available for use for the inventory feature of GLPI.

!!! tip
    when using either `marketplace/glpiinventory/` or `plugins/glpiinventory/` as the inventory path you are required to prepend `index.php` to the end of the `server` directive in `agent.cfg`. i.e. `server = https://my-glpi-server/plugins/glpiinventory/index.php`

!!! warning
    It is strongly advised that when using the inventory features of GLPI, that the endpoints be configured for client authentication.


### Client Authentication

Due to the limitations of the inventory agents, mTLS is not available so HTTP Basic Authentication is configurable. by default, when you set the environmental variable `GLPI_INVENTORY_PATH` HTTP basic auth is enabled by default. To configure the users follow these steps:

1. run command from within the container `htpasswd -c /apache-passwd-glpi-inventory {Username to create}`

1. enter the password and confirm when prompted

1. configure the `user` and `password` entries in the `agent.cfg` file.

!!! tip
    Ensure you limit the permissions on the `agent.cfg` file as it contains a password in clear text. Only the user the agent is run as requires access and you are encouraged to limit to that user only.

!!! warning
    HTTP Basic authentication is inherently insecure. to overcome this shortfall, ONLY use HTTP Basic Auth over a secure connection _(https)_. 
