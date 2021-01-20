#!/usr/bin/env bash
git pull --force && git submodule update && hugo >> /var/log/cherylhsu.ca.deploy.log
