#!/bin/bash
if [ $(ps aux | grep -e '/opt/chef/embedded/bin/ruby bin/rails s -e production -d$' | grep -v grep | wc -l | tr -s "\n") -eq 0 ]; then
  echo `date` 'starting the rails process'
  source /home/deployer/.bash_profile
  cd /home/deployer/eb-v3/current/
  bundle exec rails s -e production -d

else
  echo `date` 'rails is already running, skipping'
fi
