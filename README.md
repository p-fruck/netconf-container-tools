# NETCONF container tools

A set of tools to play around with NETCONF. During my master thesis, I played around with NETCONF on various Linux distributions. To enhance my personal developer experience, I decided to package the tools I used as container images so they will be usable across all my distributions and allow me to use specific versions of dependencies like libyang3 which isn't packaged on Fedora at the moment and will not be packaged on Debian for even longer.

Containerfiles are located in the `containers` folder and built using GitHub action. Aliases can be sourced using `source bash_aliases`. This allows to run `netopeer2-cli` instead of `podman run --rm --network=host -it ghcr.io/p-fruck/netconf-container-tools/netopeer:latest`
