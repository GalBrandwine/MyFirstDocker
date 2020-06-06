#!/bin/bash
set -e
echo "setup ros environment"
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
echo "alias pycharm='/opt/pycharm/bin/pycharm.sh'" >> ~/.bashrc
export PYTHONPATH=/usr/local/lib/python3.5/dist-packages/:/opt/ros/melocid/lib/python2.7/dist-packages/
source ~/.bashrc
exec "$@"

