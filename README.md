[![](https://badge.imagelayers.io/joostlaan/nginx-pagespeed:latest.svg)](https://imagelayers.io/?images=joostlaan/nginx-pagespeed:latest 'joostlaan/nginx-pagespeed')

# Docker with NGINX and Pagespeed (Google Module)
Use it in front of your web or application servers to proxy to them and accelerate your site with Pagespeed.

## Build

	docker build -t joostlaan/nginx-pagespeed .

## Run

	docker run --rm -ti --net host -v $(pwd)/sites-enabled:/etc/nginx/sites-enabled joostlaan/nginx-pagespeed
