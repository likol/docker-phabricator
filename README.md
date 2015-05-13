# Introduction
* * * 

deploy **Phabricator** via docker on few minutes



#Contributing
* * *

If you find this image useful here's how you can help:

* Send a Pull Request with your awesome new features and bug fixes



#Installation
* * *

Pull the image from the docker index. This is the recommended method of installation as it is easier to update image. These builds are performed by the Docker Trusted Build service.

```bash
docker pull likol1227/phabricator
```

Alternately you can build the image locally.

```bash
git clone https://github.com/likol/docker-phabricator.git
cd docker-phabricator
docker build --tag $USER/phabricator .
```

#Quick Start
* * *

simple 2 step procedure to get started.

Step 1.Launch a mysql container

```bash
PASSWORD=5566
LOCAL_STORAGE=/var/phabricator/mysql

docker run -d --name mysql \
-e "MYSQL_ROOT_PASSWORD=${PASSWORD}" \
-v ${LOCAL_STORAGE}:/var/lib/mysql \
likol1227/mysql
```

Step 2.Launch a phabricator container

```bash
HOST=127.0.1.1
SSH_PORT=10022
LOCAL_STORAGE=/var/phabricator
LOCAL_LOG=/var/log/phd

docker run --name phab \
-e "PHD_HOST=${HOST}" \
-e "SSH_PORT=${SSH_PORT}" \
-p 10080:80 -p ${SSH_PORT}:22 \
-v ${LOCAL_STORAGE}:/var/phd \
-v ${LOCAL_LOG}:/var/log/phd \
--link mysql:mysql likol1227/phabricator
```

#Mail
* * *
The mail configuration should be specified using environment variables while starting the container. The configuration defaults to using gmail to send emails and requires the specification of a valid username and password to login to the gmail servers.

```bash
HOST=127.0.1.1
SSH_PORT=10022
MAIL_USER=USER@gmail.com
MAIL_PASS=password
LOCAL_STORAGE=/var/phabricator
LOCAL_LOG=/var/log/phd

docker run --name phab \
-e "SMTP_USER=${MAIL_USER}" \
-e "SMTP_PASS=${MAIL_PASS}" \
-e "SMTP_HOST=${MAIL_HOST}" \
-e "PHD_HOST=${HOST}" \
-e "SSH_PORT=${SSH_PORT}" \
-p 10080:80 -p ${SSH_PORT}:22 \
-v ${LOCAL_STORAGE}:/var/phd \
-v ${LOCAL_LOG}:/var/log/phd \
--link mysql:mysql --rm -it likol1227/phabricator
```
#Available Configuration Parameters
* * *
Please refer the docker run command options for the --env-file flag where you can specify all required environment variables in a single file. This will save you from writing a potentially long docker run command. Alternately you can use fig.

Below is the complete list of available options that can be used to customize your phabricator installation.

* **PHD_HOST**: The hostname of the Phabricator server. Defaults to `localhost`

* **PHD_TIMEZONE**:Configure the timezone for the Phabricator application. Defaults to `UTC`

* **NGINX_MAX_UPLOAD_SIZE**: Maximum acceptable upload size. Defaults to `20m`.

* **PHP_POST_MAX_SIZE**: Maximum acceptable post size. defaults to `0`. (no limit)

* **PHP_OPCACHE_MEMORY**: Share memory for PHP OPCODE cached. Defaults to `64m`.

* **DB_HOST**: For external MySQL Server. server hostname or ipaddress.

* **DB_PORT**: For external MySQL Server. server port.

* **DB_USER**: For external MySQL Server. server username.

* **DB_PASS**: For external MySQL Server. server password.

* **SMTP_HOST**: SMTP server host. Defaults to `smtp.gmail.com`.

* **SMTP_PORT**: SMTP server port. Defaults to `587`.

* **SMTP_USER**: SMTP server username. No defaults.

* **SMTP_PASS**: SMTP server password. No defaults.

* **SMTP_PROTOCOL**: SMTP server PROTOCOL. Defaults to `tls`.

* **ALLOW_HTTP_AUTH**: Phabricator can serve repositories over HTTP, using HTTP basic auth. Defaults to `true`.

* **SSH_PORT**: Phabricator SSH serve port. Defaults to `22`.

#Configure Local.json

If you want add some setting to your phabricator container please follow step below.
before start , be sure your container are running.

`docker exec -it phab ./bin/config set log.access.path "/var/log/phd/phd-web-access.log"`

and it'll show you succeeded or failed.

more configuration guide please visit official Phabricator book.