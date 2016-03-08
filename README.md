[![](https://badge.imagelayers.io/joostlaan/nginx-pagespeed:latest.svg)](https://imagelayers.io/?images=joostlaan/nginx-pagespeed:latest 'joostlaan/nginx-pagespeed')

# Joost van der Laan NGINX proxy with Pagespeed & HTTP/2 support built from source

### Usage

Create an empty folder

Add following Dockerfile into the root of the folder:

    FROM joostlaan/nginx-proxy:latest

Then copy nginx.conf and the sites-enabled folder

Then adjust the nginx settings to proxy somewhere

Then build the docker image with

    docker build -t yourname/nginx-proxy .


#### Some old stuff

# Docker with NGINX and Pagespeed (Google Module)
Use it in front of your web or application servers to proxy to them and accelerate your site with Pagespeed.

## Build

	docker build -t joostlaan/nginx-pagespeed .

## Run

	docker run --rm -ti --net host -v $(pwd)/sites-enabled:/etc/nginx/sites-enabled joostlaan/nginx-pagespeed
