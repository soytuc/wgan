#!/bin/bash
/root/ws_moveit2/src/deativateGUI.sh
alias worksp='source /root/baxterws/devel/setup.bash --extend;source /root/ws_moveit2/devel/setup.bash --extend';
alias activate='worksp; rosrun baxter_tools enable_robot.py -e;rosrun baxter_interface joint_trajectory_action_server.py;'
alias mvit='worksp;roslaunch baxter_moveit_config baxter_grippers.launch right_electric_gripper:=true left_electric_gripper:=true'
alias gaz='worksp;roslaunch multi_robot baxter_realsense_empty_world.launch'
alias loadlibs='worksp;export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/torchModel/multiwgangp/trainedSamplerModel/install/lib/:/root/torchModel/multiwgangp/cmakeForwardKinematic2d/install/lib/:/root/torchModel/libtorch/lib/'
export ROS_MASTER_URI=http://localhost:11409
export GAZEBO_MASTER_URI=http://localhost:11509
for i in {0..7};do source /root/baxterws/devel/setup.bash --extend;source /root/ws_moveit2/devel/setup.bash --extend; ROS_MASTER_URI=http://localhost:1140$i roscore --port 1140$i & done; sleep 1 

for i in {0..7};do source /root/baxterws/devel/setup.bash --extend;source /root/ws_moveit2/devel/setup.bash --extend;ROS_MASTER_URI=http://localhost:1140$i  GAZEBO_MASTER_URI=http://localhost:1150$i roslaunch multi_robot baxter_realsense_empty_world.launch & done; sleep 20

for i in {0..7};do source /root/baxterws/devel/setup.bash --extend;source /root/ws_moveit2/devel/setup.bash --extend;export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/torchModel/multiwgangp/trainedSamplerModel/install/lib/:/root/torchModel/multiwgangp/cmakeForwardKinematic2d/install/lib/:/root/torchModel/libtorch/lib/; ROS_MASTER_URI=http://localhost:1140$i  GAZEBO_MASTER_URI=http://localhost:1150$i roslaunch baxter_moveit_config baxter_grippers.launch right_electric_gripper:=true left_electric_gripper:=true & done; sleep 50; 

for i in {0..7};do cd /root/ws_moveit2/src/planning;env LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/torchModel/multiwgangp/trainedSamplerModel/install/lib/:/root/torchModel/multiwgangp/cmakeForwardKinematic2d/install/lib/;ROS_MASTER_URI=http://localhost:1140$i  GAZEBO_MASTER_URI=http://localhost:1150$i rosrun onlinecollisionchecker baxter_test /joint_states:=/robot/joint_states  --isGan false --nExperiment 0 --generateTestingData false --takeOnlyPhotos false --q0 -0.3 --q1 1 --q2 2 --q3 0 --q4 0.1 --q5 0.5 & done;
