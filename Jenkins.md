# Running Jenkins locally
The full Jenkins installation instructions with all options are here: https://www.jenkins.io/doc/book/installing. However it can be a bit tricky to find the relevant information so I've tried to summarise it below with instructions for the two different options; installing jenkins on your machine or running it in docker on your machine.

## Installing and running Jenkins on your machine
I found this approach easiest, although it requires installing via homebrew (on a mac) or an installer (on windows) so might not be possible for all learners.

Instructions are here for mac: https://www.jenkins.io/download/lts/macos/, and here for windows: https://www.jenkins.io/download/#downloading-jenkins (select the windows installer).

The precise commands I ended up needing for a mac were:
1. `brew install jenkins-lts`
2. `jenkins-lts` (make a note of the password in the logs from this as you'll need it later)

## Running Jenkins through docker
There is a big docker section in the documentation: https://www.jenkins.io/doc/book/installing/#docker. I found the exact commands I needed to run (on a mac) were:
1. `docker network create jenkins`
2. `docker volume create jenkins-docker-certs`
3. `docker volume create jenkins-data`
4. `docker image pull docker:dind`
5. `docker container run --name jenkins-docker --rm --detach \
  --privileged --network jenkins --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --publish 2376:2376 docker:dind`
6. `docker container run --name jenkins-blueocean --rm --detach \
  --network jenkins --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  --publish 8080:8080 --publish 50000:50000 jenkinsci/blueocean`
7. `docker logs jenkins-blueocean` (make a note of the password in these logs as you'll need it later)

## Setting up Jenkins once it's running
Jenkins should now be running on http://localhost:8080/. If you go to this url in a browser it should show you a set up page.
1. Login with the password you got from the logs when starting Jenkins.
2. Select the necessary plugins (you can always add more later so it's not essential to get this exactly right first time). See image below for which ones I added. The most important one which isn't automatically selected is GitHub.
![Jenkins plugins](https://github.com/CorndelWithSoftwire/DevOps-Module-07-Workshop/tree/model-answer/img/jenkins-plugins.png)
3. Create an admin user.
4. Use the default jenkins url (http://localhost:8080)

You should now see the Jenkins dashboard. One last thing it might be worth doing is going to Manage Jenkins -> Configure System -> GitHub API usage and change the limiting strategy to "Throttle at/near rate limit". Otherwise I found it refused to scan for new branches when I added a build.
![GitHub Api settings](https://github.com/CorndelWithSoftwire/DevOps-Module-07-Workshop/tree/model-answer/img/jenkins-throttle.png)

## Setting up the Jenkins build for the mini app
1. Select New Item.
2. Set it to a multibranch pipeline.
3. Leave all the defaults other than setting the branch sources to GitHub. Leave the defaults for the branch source other than setting the repository url to https://github.com/CorndelWithSoftwire/DevOps-Module-07-Workshop (or to the fork url if you're using a fork).
4. If you're running jenkins in docker then set it to use the jenkinsfile in docker-jenkins instead of the one in the repositor main folder. This will make sure a docker image with node is used when running npm commands and a docker image with .NET Core 3.1 is used when running dotnet commands.
5. Click Save to create the Jenkins job.
6. Add the slack plugin by going to Manage Jenkins -> Manage Plugins -> Available. Search for slack and install the slack notification plugin.
7. Add slack credentials to your build as per the instructions here: https://swiki.softwire.com/display/Technical/How+to+notify+Slack+from+a+Jenkins+2+build (although you shouldn't need to enable project-based security).
8. If you're using Windows instead of a mac you need to replace `sh` in the jenkinsfile with `bat`.