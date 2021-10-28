# adr
## Introduction
adr or automatic dynamic routing is just traefik, [see here](https://traefik.io/) for information

## Reason
This is used to route request from the external internet to specific services. Majority of the config can be found in docker-compose files under labels and the two dev / prod toml files.

Requests that do not need to go from the internet should use the internal docker network e.g. authorize jwts, but it could go through the external network if need be.
