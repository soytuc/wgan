x="${1:-1}";
y="${2:-0}";
zr="${3:-0}";
#x= $1;
#y= $2;
#zr=$3;
isSpawned=$(rosservice call /gazebo/get_model_state casual_female base | grep success: | awk {'print $2'});
echo $isSpawned;
if [ "$isSpawned" = True ]; then
  rosservice call gazebo/delete_model '{model_name: casual_female}';
#  rosservice call gazebo/delete_model '{model_name: hammer}';
#  rosservice call gazebo/delete_model '{model_name: little_table}'
fi;
#rosservice call gazebo/delete_model '{model_name: hammer}';
#rosservice call /gazebo/reset_simulation "{}"
#isSpawned=$(rosservice call /gazebo/get_model_state hammer base | grep success: | awk {'print $2'})
rosrun gazebo_ros spawn_model -file /root/.ignition/fuel/fuel.ignitionrobotics.org/openrobotics/models/casual\ female/3/model.sdf  -sdf -x $x -y $y -z 0 -R 0 -P 0 -Y $zr  -model casual_female; 
#rosrun gazebo_ros spawn_model -file /root/.ignition/fuel/fuel.ignitionrobotics.org/openrobotics/models/storagerack/2/model.sdf -sdf -x 0 -y -1.4 -z -0.95 -R 0 -P 0 -Y 0  -model hammer -reference_frame base;
#rosrun gazebo_ros spawn_model -file /root/.ignition/fuel/fuel.ignitionrobotics.org/openrobotics/models/storagerack/2/model.sdf -sdf -x 1.3 -y -0.3 -z -0.95 -R 0 -P 0 -Y 1.57  -model hammer -reference_frame base;
#if [ "$isSpawned" = False ]; then
#  rosrun gazebo_ros spawn_model -file /root/.ignition/fuel/fuel.ignitionrobotics.org/openrobotics/models/adjtable/3/model.sdf -sdf -x 1.7 -y -0.6 -z -0.95 -model little_table -reference_frame base;
  #rosrun gazebo_ros spawn_model -file /root/.ignition/fuel/fuel.ignitionrobotics.org/openrobotics/models/coke/2/model.sdf -sdf -x 1 -y -0.3 -z -0.14 -model hammer -reference_frame base;
#fi;
#rosservice call /gazebo/reset_world "{}"
