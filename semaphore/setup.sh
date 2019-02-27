#!/bin/bash

if [ ! -L /usr/bin/ruby ]; then
  sudo ln -s $(which ruby) /usr/bin/ruby
fi

# same as `make install`
sudo ln -s $(pwd)/textplay /usr/local/bin/

bundle install
