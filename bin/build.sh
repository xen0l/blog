#!/usr/bin/env bash

set -o errexit

SITE_NAME="blog.xenol.eu"

ROOT=$(cd $(dirname $0)/../; pwd)

cd ${ROOT}
hugo -d ./public

echo "${SITE_NAME}" > ${ROOT}/public/CNAME

touch ${ROOT}/public/.nojekyll
