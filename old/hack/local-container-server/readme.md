# Running a Containerized Middleman Server for Local Testing

These instructions will show you how to run a local container to test the OKD
community website. This process should be used in situations where installing
the site build dependencies is troublesome.

This document assumes you have [Podman](https://podman.io) available on your
system. This process _should_ work with [Docker](https://docker.com), but you
will need to modify the instructions and `server.sh` script accordingly.

You should perform these actions from the root from the project repository.

1. Create a local container to run the Middleman server. This will create a
   container with all the necessary dependencies to run the site. It will
   copy files from the site directory, but these will be overwritten with your
   local changes when you run the `server.sh` script. You will need to rebuild
   this container if you add dependencies to the Gemfile.
   ```
   podman build -t okdio-server -f hack/local-container-server/Dockerfile.server .
   ```

2. Run the server using the `server.sh` script. This script will handle mounting
   the local content files and exposing port `4567` on the localhost. If you
   do not have a local `data/participants.yml` file, this script will create an
   empty file for you.
   ```
   ./hack/local-container-server/server.sh
   ```

3. Open your web browser to [localhost:4567](http://localhost:4567).
