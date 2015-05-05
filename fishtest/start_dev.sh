#!/bin/bash

nohup pserve development.ini --reload >nohup.out 2>&1 &
#pserve development.ini --reload
