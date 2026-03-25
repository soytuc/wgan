cd /root/baxterws
source /opt/ros/noetic/setup.bash
catkin build
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
apt update
apt upgrade -y
apt dist-upgrade -y
apt purge -y librealsense2*
apt install -y ros-noetic-librealsense2
apt install -y ros-noetic-pybind11-catkin
apt install -y ros-noetic-eigenpy
apt install -y libsdformat-dev
cd /root/extrafiles/; git pull;
cd /root/extrafiles/runservices.sh /root/;chmod 755 /root/runservices.sh
# cd /root/
# cd /root/ws_moveit2/;catkin clean -y
cd /root/
source /opt/ros/noetic/setup.bash --extend; cd /root/baxterws; catkin build --cmake-args -DG=Ninja;source /root/baxterws/devel/setup.bash --extend;cd /root/ws_moveit2;catkin build -j6 --no-deps ompl --cmake-args -DG=Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5;source /root/ws_moveit2/devel/setup.bash --extend;cd /root/torchModel/multiwgangp/trainedSamplerModel;mkdir build;cd build; cmake -DCMAKE_INSTALL_PREFIX=../install/ -DCMAKE_BUILD_TYPE=Release ..;make;make install;cd /root/torchModel/multiwgangp/cmakeForwardKinematic2d;mkdir build;cd build;cmake -DCMAKE_INSTALL_PREFIX=../install/ -DCMAKE_BUILD_TYPE=Release ..;make;make install;cd /root/ws_moveit2;catkin build -j6 --cmake-args -DG=Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5;catkin build -j6 --cmake-args -DG=Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5;/root/ws_moveit2/src/deativateGUI.sh
#export ROS_MASTER_URI=http://localhost:11402
#export GAZEBO_MASTER_URI=http://localhost:11502

