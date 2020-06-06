# ROS with hardware acceleration support
The docker includes
* Ubuntu 18.04
* ROS melodic
* python 3.5.2 (In addition to python2 which comes with ROS)
* OpenCV 4.1
* All needed ROS-related configuration to run python3 with
	* rospy
	* rosbag
	* cv_bridge
* pycahrm community with virtual enviroment under `/root/PycharmProjects/dev`

## How to setup docker
```
sudo apt-get install docker.io
sudo groupadd docker
sudo usermod -aG docker $USER
```
restart computer (or service) after this point

## How to build 
```
git clone https://github.com/GalBrandwine/MyFirstDocker.git
cd MyFirstDocker
chmod +x build_docker.sh
./build_docker.sh
```

## How to run and make the display working on the host machine (tested on ubuntu 18.04)
```
chmod +x run_docker.sh
./run_docker.sh
```

## Nice docker commands
```shell script
docker image rm $(docker images -aq)# Remove all images
docker rm $(docker ps -aq)          # Remove all containers
```

## Thanks to
* [AmirAvni](https://github.com/amiravni), for his DockerFile skeleton
* [rycus86](https://hub.docker.com/r/rycus86/pycharm/dockerfile), for Pycharm Dockerfile skeleton