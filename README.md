# Supported tags and respective `Dockerfile` links

  * [`latest` (Dockerfile)](https://github.com/wernight/docker-codiad/blob/master/Dockerfile)
  * [`alpine` (Dockerfile)](https://github.com/wernight/docker-codiad/blob/alpine/Dockerfile)


## What is Codiad

[**Codiad**](http://codiad.com/) is a web-based IDE framework with a small footprint and minimal requirements.

![Screenshot of Codiad](https://github.com/wernight/docker-codiad/raw/master/docs/screenshot.png)

You can add [many plugins](http://market.codiad.com/) from the Web UI by opening the right side bar and clicking Marketplace.


### Features of this image

  * **Simple or Lean**:
      * `latest` (~600MB) is based on Ubuntu, contains `docker` binaries and allows easily adding required development tools.
      * `alpine` (~90MB) is base on Linux Alpine (very small) with S6 supervisor (lightweight) but a few features may not work.
  * **Performant**: Using Nginx + PHP-FPM (very performant).
  * **Secure**:
      * Runs as non-root (Nginx run as `nginx` and PHP-FPM run as random UID `2743` user once started).
      * Includes a brute-force attack protection.



## How to use this image

    docker run --rm -p 8080:80 \
        -v $PWD/code:/code \
        -v /etc/localtime:/etc/localtime:ro \
        -v /var/run/docker.sock:/var/run/docker.sock:ro \
        wernight/codiad

Then open your browser at `http://localhost:8080`.

**Parameters:**

  * `-p 80` ‒ the port to expose.
  * `-v /code` ‒ persists your configuration and installed plugins (you may also use a Docker volume).
  * `-v /etc/localtime` ‒ *(optional)* used for timesync.
  * `-v /var/run/docker.sock` ‒ *(optional)* allows to **build and run Docker images** from within Codiad
    (e.g. using the Terminal plugin or Macros plugin). It also gives often nearly `root` access to your Codiad
    users so use it with care.


### Setting up your projects

  * Store your projects somewhere below `/code/`, for data persistence (or mount another volume).
  * Install common [plug-ins](http://market.codiad.com/) via the web interface, like:
      * [Collaboration](https://github.com/Codiad/Codiad-Collaborative)
      * [Terminal](https://github.com/Fluidbyte/Codiad-Terminal)
          * Change `/code/plugins/Codiad-Terminal-master/emulator/term.php` to change terminal password (default is `terminal`).
      * [CodeGit](https://github.com/Andr3as/Codiad-CodeGit)
          * Change `/code/plugins/Codiad-CodeGit-master/shell.sh` to add Git user/pass.
          * To set up SSH key (see also [Codiad Wiki](https://github.com/Andr3as/Codiad-CodeGit/wiki)) you can run using Codiad Terminal:

                ssh-keygen -f ~/.ssh/id_rsa
                ssh-keyscan -t rsa,dsa $DOMAIN_NAME >> ~/.ssh/known_hosts
                cat ~/.ssh/id_rsa.pub
      * [Drag and Drop](https://github.com/Andr3as/Codiad-DragDrop)
      * [Emmet](https://github.com/Andr3as/Codiad-Emmet)
      * [Macro](https://github.com/daeks/Codiad-Macro)
      * ...
   * Check [Codiad Hot-Keys](https://github.com/Codiad/Codiad/wiki/Hot-Keys)


### Extending the capabilies

You can easily extend to include tool you may need and have them ready
whenever you re-create your container. Just create a `Dockerfile` like:

    FROM wernight/codiad
    RUN apt update && apt install -y build-essential python

Now you can just build and use your new image:

    $ docker build -t codiad .
    $ docker run --rm -p 8080:80 codiad


## Versions

  * **2016-06-29:** Include `docker` to allow building stuff from within Codiad.
  * **2016-06-29:** Makes `latest` based on Ubuntu due to some bugs and to allow extending; keep `alpine` as a branch.
  * **2016-06-24:** Base on Alpine + S6 + Nginx + PHP-FPM.
  * **2016-06-23:** Removed plug-ins and inlined this repos' init scripts.
  * **2016-06-22:** Initial release based on the excellent [LinuxServer.io codiac image](https://github.com/linuxserver/docker-codiad)


## Feedbacks

Suggestions are welcome on our [GitHub issue tracker](https://github.com/wernight/docker-codiad/issues).
