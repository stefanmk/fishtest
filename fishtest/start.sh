#!/bin/bash

pkill -f pserve
nohup pserve --monitor-restart production.ini >nohup.out &
