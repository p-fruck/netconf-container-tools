#!/bin/sh
set -e

# base url for the container image
base_url=ghcr.io/p-fruck/netconf-container-tools
# which container engine to use
ce=podman

_get_image() {
  image=$(echo "$1" | cut -d '.' -f 2)
  echo "${base_url}/${image}"
}

for containerfile in Containerfile.*
do
  image=$(_get_image "${containerfile}")
  echo "Building ${image}"
  "${ce}" build -f "${containerfile}" -t "${image}"
done

# check if github token is provided, then push to registry
if [ -n "${GITHUB_TOKEN}" ]
then
  # login to registry
  registry=$(echo "${base_url}" | cut -d '/' -f 1)
  user=$(echo "${base_url}" | cut -d '/' -f 2)
  echo "${GITHUB_TOKEN}" | "${ce}" login "${registry}" -u "${user}" --password-stdin

  for containerfile in Containerfile.*
  do
    image=$(_get_image "${containerfile}")
    echo "Pushing ${image}"
    ${ce} push "${image}"
  done 
else
  echo "No token provided, cannot push to registry"
fi

