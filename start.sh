#!/bin/bash --login
rails s -b 0.0.0.0
tail -f ./log/development.log
