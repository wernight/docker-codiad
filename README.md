# Supported tags and respective `Dockerfile` links

  * [`latest` (Dockerfile)](https://github.com/wernight/docker-codiad/blob/master/Dockerfile)


## What is Codiad

Codiad is a web-based IDE framework with a small footprint and minimal requirements.

![Screenshot of Codiad](https://github.com/wernight/docker-codiad/raw/master/docs/screenshot.png)


## Features of this image

We have added a few plugins by default:

  * Collaboration - https://github.com/Codiad/Codiad-Collaborative
  * Terminal - https://github.com/Fluidbyte/Codiad-Terminal
  * CodeGit - https://github.com/Andr3as/Codiad-CodeGit
  * Drag and Drop - https://github.com/Andr3as/Codiad-DragDrop

More can be added in the marketplace in the WebUI.


## How to use this image

```
docker run -p 80:80 \
    -v /etc/localtime:/etc/localtime:ro \
    -v $PWD/config:/config \
    -e PUID=$UID -e PGID=$GID \
    wernight/codiad
```

**Parameters:**

* `-p 80` ‒ the port(s) to expose.
* `-v /etc/localtime` ‒ *(optional)* used for timesync.
* `-v /config` ‒ persists configuration (you may also use a Docker volume).
* `-e PUID` and `-e PGID` ‒ UserID and GroupID under which to run, see below for explanation.

It is based on [linuxserver/baseimage.apache](https://hub.docker.com/r/linuxserver/baseimage.apache/) which is a [phusion-baseimage](https://github.com/phusion/baseimage-docker) with ssh removed (if you need shell access whilst the container is running do `docker exec -it my-codiad-container-name bash`).


### User / Group Identifiers

**TL;DR** - The `PGID` and `PUID` values set the user / group you'd like your container to 'run as' to the host OS. This can be a user you've created or even root (not recommended).

Part of what makes our containers work so well is by allowing you to specify your own `PUID` and `PGID`. This avoids nasty permissions errors with relation to data volumes (`-v` flags). When an application is installed on the host OS it is normally added to the common group called users, Docker apps due to the nature of the technology can't be added to this group. So we added this feature to let you easily choose when running your containers.

### Setting up the application 

  * Use `/config/projects` to save your projects, for data persistence.
  * Change `/config/www/plugins/Codiad-CodeGit-master/shell.sh` to add Git user/pass.
  * Change `/config/www/plugins/Codiad-Terminal-master/emulator/term.php` to change terminal password.


### Updates

  * Upgrade to the latest version simply `docker restart codiad`.
  * To monitor the logs of the container in realtime `docker logs -f codiad`.


## Versions

  - **2016-06-22:** Initial release based on the excellent [LinuxServer.io codiac image](https://github.com/linuxserver/docker-codiad)


## Feedbacks

Suggestions are welcome on our [GitHub issue tracker](https://github.com/wernight/docker-codiad/issues).
