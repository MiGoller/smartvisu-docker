# smartVISU for Docker

Run [smartVISU](https://github.com/Martin-Gleiss/smartvisu) as a visualization frontend for your smart-home simply as a Docker container or stack on your favorite or personal Docker host.

smartVISU for Docker is a [php-fpm based Docker image](https://hub.docker.com/_/php) to use with fpm-capable web-servers like [Apache httpd](https://httpd.apache.org/) or [nginx](https://www.nginx.com/).

Have a look at the example and the tutorial.

## What is smartVISU?

"smartVISU is a framework to create a visualisation for a knx-installation with simple html-pages." (s. [smartVISU](https://github.com/Martin-Gleiss/smartvisu) repository). 

### Supported smart-home backends

But you can run it against various smart-home backends.

- [smarthomeNG](https://github.com/smarthomeNG)
- [linknx](http://sourceforge.net/projects/linknx/)
- [ioBroker](https://github.com/ioBroker/ioBroker)
- [openHAB2](https://github.com/openhab)
- [FHEM](https://fhem.de/)
- [knxd](https://github.com/knxd/knxd)
- [eibd](http://www.auto.tuwien.ac.at/~mkoegler/index.php/eibd) (deprecated)

### Key features

- Pretty: Responsive design, auto adjustment to smartphones and tablets
- Strict: One template for all devices
- Easy: Implementation with HTML5
- Simple: Connect to KNX with commands directly in HTML
- Universal: Small concept of widgets
- Connectable: Using drivers for different KNX installations

## And why should I run smartVISU on my Docker host?

Well, that's a good question. Probably you will have to to so because your NAS does not allow you to install custom software. But there are some more advantages.

- Do not care about installing, updating and hardening a local web-server and PHP.
- Do not care about installing and updating smartVISU.
- Focus yourself on your visualization.

And finally: Spend your time for the things that really matter.

## Usage

I recommend to use `docker-compose`to create, to run and to manage a stack of microservices for your smartVISU visualization.

Create a `docker-compose.yml` with a content similar to the example taken from this repository.

```yml
version: '2'

services:
  app:
    build: ..
    # image: migoller/smartvisu
    networks:
      - default
    volumes:
      # Map date and time settings from Docker host
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
      # Offline storage for demo (DO map in productional environments, too)
      - ./temp:/var/www/html/temp
      # Your smartVISU global configuration file
      - ./config.ini/:/var/www/html/config.ini
      # Your custom smartVISU page
      - ./mypage/:/var/www/html/pages/mypage
    
    # Run as user with id=1001 and gid=1001. Set to something that matches your needs!
    user: 1001:1001
  
  web:
    image: nginx
    ports:
      - 8080:80
    links:
      - app
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
    volumes_from:
      - app

```

Ensure you have created an empty directory `temp` for smartVISU's offline storage and a clear file `config.ini` for smartVISU's global configuration.

Create an empty directory `mypage` for your personal smartVISU page, too.

Adjust the `user` setting to your account user id (uid) and group id (gid). To get theses ids simply run the following command on your Linux shell.

```sh
$ id

uid=1001(abc) gid=1001(abc) groups=1001(abc),...
```

Now start your smartVISU stack. Type in your shell (assuming your running this from the `example` directory):

```sh
$ docker-compose up

Creating network "example_default" with the default driver
Creating example_app_1 ... done
Creating example_web_1 ... done
Attaching to example_app_1, example_web_1
...
```

You should be able to open the smartVISU configuration page in your browser: http://localhost:8080 .

## Creating a new page from the smartVISU template page

The smartVISU author recommends to create new pages based on the smartVISU template.

After you have started your smartVISU stack (s. previous chapter), you can create a new page from the command line.

```sh
$ docker exec -it example_app_1 cp -r /var/www/html/pages/_template/. /var/www/html/pages/mypage
```

Ensure you have mounted a volume or folder to `/var/www/html/pages/mypage` to persist your new page.

Go on and build your smartVISU visualization for your smart-home.


Good luck and enjoy.
