# DIVA-Algorithm

## Documentation

The code documentation can be generated with rdoc and is located in the new generated 'html' folder inside the root of the project:

```
rake rdoc
```


## Setup

### Development

The following guide will help you to setup the necessary dependencies. You can skip this guide if you already have a machine setup with Ruby, Rails, Bundler and Postgresql.

#### 1. Install ruby (e.g via RVM)

```sh
$ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
$ \curl -sSL https://get.rvm.io | bash -s stable
$ rvm install ruby-2.1.5
$ rvm use 2.1.5 --default
```
For more details see: https://rvm.io/

#### 2. Install Ruby on Rails
```sh
$ gem install rails
```

#### 3. Install Bundler
```sh
$ gem install bundler --no-rdoc --no-ri
```

#### 4. Install Postgresql
```sh
$ sudo apt-get install postgresql postgresql-contrib libpq-dev
```
Create a postgres user:
```sh
$ sudo -u postgres psql
$ \password postgres
```
Set the password to 'postgres' and exit the postgresql console:
```sh
\q
```
Install the postgresql gem:
```sh
gem install pg
```

#### 5. Install node.js
```sh
sudo apt-get install nodejs
```

#### 6. Clone and setup repo
```sh
$ git clone git@bitbucket.org:StupidBird/diva_algorithm.git
```
Navigate to the repo and install the missing dependencies via bundler:
```sh
$ cd /diva_algorithm
$ bundle install
```

#### 7. Create .env file
Create a new file called '.env' inside the root folder (/diva_algorithm) and append to it:
```
RECAPTCHA_PUBLIC_KEY=6Lc6BAAAAAAAAChqRbQZcn_yyyyyyyyyyyyyyyyy
RECAPTCHA_PRIVATE_KEY=6Lc6BAAAAAAAAKN3DRm6VA_xxxxxxxxxxxxxxxxx
DIVA_SERVICES_HOST=localhost:8080
```
These are dummy keys, use your own.

Make sure that you set the port used in development in your .env file via:
```
PORT=4000
```
However, do not forget to start a rails server with the port option set, because rails will not care about the environment value. (It is necessary to run delayed_jobs and any other asynchronous application on the correct port): E.g. 'rails server -p 4000'.

If you wish to send exceptions to a Slack Channel, set the following ENV values:

```
SLACK_HOOK_DEV="https://slackhook"
SLACK_CHANNEL_DEV="#channelname"
```

#### 8. Install ClamAV
```sh
$ sudo apt-get update
$ sudo apt-get install clamav
$ sudo apt-get install clamav-daemon
```

Install the newest databases for clamscan
```sh
$ sudo freshclam
```

Ensure that clamscan is installed under '/usr/bin/clamdscan', otherwise alter the entry under /config/initializers/clam_scan.rb. Check the current install directory with:
```sh
$ which clamscan
```

#### Run the server

Create database on first run:
```sh
$ rake db:create db:migrate db:seed
```

Run server:
```sh
$ rails s
```

Run the delayed_job daemon:
```sh
$ ./bin/delayed_job start
```


### Produtction

#### 1. Clone the repository to your local machine.

#### 2. Setup a server instance with similar dependencies as the development Environment

* Ruby (e.g. with rvm)
* Postgres (with a user called 'postgres')
* Rails (gem install rails)
* Bundler (gem install bundler --no-rdoc --no-ri)
* ClamAV (similar to development)

#### 3. Use mina to init and deploy

Run the commands on your development environment to use mina for the deployment:

```
mina setup
mina deploy
mina stop
mina reset_db
mina stop
mina seed
mina restart
```

#### 4. Environment values

Like in the development enviromnent, the .env file located in /home/<user>/<app>/shared/ must contain the following entries:

* RECAPTCHA_PUBLIC_KEY
* RECAPTCHA_PRIVATE_KEY
* RAILS_DB_USER=<pg username>
* RAILS_DB_PASSWORD=<pg password>
* HOST_URL=<server url>
* SECRET_KEY_BASE=<new generated secret key>
* DIVA_SERVICES_HOST=<url of DIVAServices>
* SLACK_HOOK_PROD=<https://slackhook>
* SLACK_CHANNEL_PROD=<#channelname>

#### Updating version

If you want to update the live version, simply commit to the master and run the following commands:

```
mina deploy
mina restart
```
