# Little docker test
Simple playground to illustrate possible docker setups that:

- Features static frontend sites(HTMX 🙂)
- Features a minimal PHP container which responds with "Hello, World!" and an incrementing counter(Swoole)
- Features a 3rd party service (Mailhog)
- Exposes a load balancer/reverse proxy(Caddy)
- Separates the 3rd party services into their own network that cannot directly talk to our 1st party applications through

# Usage

Simply update your hosts or DNS to forward all requests to main.test, docs.test, and prototype.test to 127.0.0.1, and run `make optionX` replacing `X` with the [option](##Differences-between-the-docker-compose-files) that you would like to explore.

Then you can visit `http://main.test:8080`, `http://docs.test:8080`, `http://prototype.test:8080`, and `http://mail.test:8080`. 
## DNS (On Mac)
[Guide](https://gist.github.com/ogrrd/5831371)
## Hosts
```bash
echo '127.0.0.1 mail.test'      | sudo tee -a /etc/hosts
echo '127.0.0.1 main.test'      | sudo tee -a /etc/hosts
echo '127.0.0.1 docs.test'      | sudo tee -a /etc/hosts
echo '127.0.0.1 prototype.test' | sudo tee -a /etc/hosts
```

## Differences between the docker compose files
The differences are listed at the top of each docker compose file, so check there for the most up-to-date information, yet as of the time of writing, the differences are as follows:

### Option 1 - All in one, Swoole
This docker compose gives a less explicit view into which static assets are being served by having all sites served through the /sites folder.
This can be a little confusing at first glance yet allows us to deploy new sites by just changing the caddy file and reloading caddy.

### Option 2 - A little more separate, Swoole
This docker compose gives a more explicit view into which static assets are being served by having each one be in its own volume.
The downside being needing to redeploy the stack whenever we want to add any new sites

### Option 3 - The most separate, Swoole
This docker compose gives an even more explicit view into which static assets are being served by having each one be in its container.
The downside being needing to redeploy the stack whenever we want to add any new sites
However, an additional upside is slightly more granular control over the environment that each static site is in.
This does come with its own downside though, being additional overhead and resources.

### Option 4 - All in one, PHP-FPM + Caddy
This docker compose is the exact same as option 1, however our backend image is more traditional, using PHP-FPM and Caddy instead of Swoole.
The downside being a bit of added complexity with multiple more processes and needing to use something like supervisord to wrangle them up.
The upside being that its a lot more traditional, supported, documented, and we can rely on the official php image instead of the Swoole one.

### Option 5 - Go with alpine image
This docker compose is the same as option 1 except using ✨Go✨
Benefit is smaller, lighter, faster, stronger
Downside is type safe and compiled languages can take longer to develop if youre not familiar

### Option 5_1 - Go with scratch image
This docker compose is the same as option 1 except using ✨Go✨ (and a scratch image for a smaller size)
Benefit is smaller, lighter, faster, stronger, and now with an even smaller total image size
Downside is scratch doesnt have stuff like curl, so no built in healthchecks

## Performance differences

Below are screenshots from the docker images showing steps and sizes of the images for option 4, 5, and 5_1. I also ran a loop hitting the backend every 250ms for around 30 seconds (120 requests) and took a screenshot of the peak loads.

### Option 4 - PHP + FPM + Caddy
![container size](docs/php.png)
![performance](docs/php_perf.png)

### Option 5 - Go with alpine image
![container size](docs/go.png)
![performance](docs/go_perf.png)

### Option 5_1 - Go with scratch image
![container size](docs/go_scratch.png)
![performance](docs/go_scratch_perf.png)
