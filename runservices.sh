#!/bin/bash
/root/ws_moveit2/src/deativateGUI.sh
alias worksp='source /root/baxterws/devel/setup.bash --extend;source /root/ws_moveit2/devel/setup.bash --extend';
alias activate='worksp; rosrun baxter_tools enable_robot.py -e;rosrun baxter_interface joint_trajectory_action_server.py;'
alias mvit='worksp;roslaunch baxter_moveit_config baxter_grippers.launch right_electric_gripper:=true left_electric_gripper:=true'
alias gaz='worksp;roslaunch multi_robot baxter_realsense_empty_world.launch'
alias loadlibs='worksp;export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/torchModel/multiwgangp/trainedSamplerModel/install/lib/:/root/torchModel/multiwgangp/cmakeForwardKinematic2d/install/lib/:/root/torchModel/libtorch/lib/'
export ROS_MASTER_URI=http://localhost:1140$PORTROS
export GAZEBO_MASTER_URI=http://localhost:1150$PORTROS
source /root/baxterws/devel/setup.bash --extend;source /root/ws_moveit2/devel/setup.bash --extend; ROS_MASTER_URI=http://localhost:1140$PORTROS roscore --port 1140$PORTROS & sleep 1 
source /root/baxterws/devel/setup.bash --extend;source /root/ws_moveit2/devel/setup.bash --extend;GAZEBO_MASTER_URI=http://localhost:1150$PORTROS roslaunch multi_robot baxter_realsense_empty_world.launch & sleep 20
source /root/baxterws/devel/setup.bash --extend;source /root/ws_moveit2/devel/setup.bash --extend;export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/torchModel/multiwgangp/trainedSamplerModel/install/lib/:/root/torchModel/multiwgangp/cmakeForwardKinematic2d/install/lib/:/root/torchModel/libtorch/lib/; roslaunch baxter_moveit_config baxter_grippers.launch right_electric_gripper:=true left_electric_gripper:=true & sleep 50; 
cd /root/ws_moveit2/src/planning;env LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/torchModel/multiwgangp/trainedSamplerModel/install/lib/:/root/torchModel/multiwgangp/cmakeForwardKinematic2d/install/lib/; rosrun onlinecollisionchecker baxter_test /joint_states:=/robot/joint_states  --isGan false --nExperiment 0 --generateTestingData false --takeOnlyPhotos false --q0 -0.3 --q1 1 --q2 2 --q3 0 --q4 0.1 --q5 0.5;
