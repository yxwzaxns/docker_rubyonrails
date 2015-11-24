#!/bin/bash --login
rails s
tail -f ./log/development.log
