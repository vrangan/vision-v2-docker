# Docker container for building the StarFive VisionV2 SBC artifcats

After running into several issues to build with the Ubuntu 22.04 LTS version, I decided to create a 20.04 container to build and it has been helpful.


## Clone this repo to you directory

cd to the directory

## How to build the docker container

docker build -t vision-v2-build:latest .

There are a few build args available. (For example Ubuntu version to use). You can pass them to docker build with --build-arg option.  For example,
to change the Timezone to New_York, you can build with docker build -t vision-v2-build:latest --build-arg TZ=America/New_York


## Running the container

Start the container using the command line given below. Change repodir to a location on the host where the repos have to be cloned. 

  docker run --rm -it  -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro -v <repodir>:/vision-v2-repos -u $(id -u):$(id -g) vision-v2-build

We ro mount  the passwd and group directories on to the container so that the we can use users defined in the host to be used.
<repodir> - Directory where the repo is cloned and built.  Make sure you have atleast 20GB of free space available in this directory.
--rm option is used to cleanup the container on exit - Can be removed.

After the container is launched, you can switch to /vision-v2-repos directory and invoke the build.sh command 

### Inside the container
  cd /vision-v2-repos
  /vision-v2/build.sh
  
  Or you can use individual build steps
  




