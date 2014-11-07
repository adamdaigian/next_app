#!/bin/bash
if [ $(ps aux | grep -e 'resque-1.25.1' | grep -v grep | wc -l | tr -s "\n") -eq 0 ]; then
  echo `date` 'starting the resque process'
  source /home/deployer/.bash_profile
  cd /home/deployer/eb-v3/current/
  QUEUE='*' rake environment resque:work RAILS_ENV=production &
else
  echo `date` 'resque is already running, skipping'
fi
