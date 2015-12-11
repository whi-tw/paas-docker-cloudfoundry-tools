require 'serverspec'

set :backend, :docker
set :os, family: :debian

# bosh-init

BOSH_INIT_PACKAGES = "build-essential zlibc zlib1g-dev ruby ruby-dev openssl libxslt1-dev libxml2-dev \
    libssl-dev libreadline6 libreadline6-dev libyaml-dev libsqlite3-dev sqlite3"
BOSH_INIT_BIN = "/usr/local/bin/bosh-init"
BOSH_INIT_VERSION = "0.0.81-775439c-2015-12-09T00:36:03Z"

# spruce

SPRUCE_BIN = "/go/bin/spruce"
SPRUCE_VERSION = "0.12.0"
