q0="${1:-1}";
q1="${2:-0}";
q2="${3:-0}";
q3="${4:-0}";
q4="${5:-0}";
q5="${6:-0}";
q6="${7:-0}";
rosservice call /gazebo/set_model_configuration '{ model_name: "baxter", urdf_param_name: "robot_description", joint_names: [ "right_s0", "right_s1", "right_e0", "right_e1", "right_w0", "right_w1", "right_w2", "left_s0", "left_s1", "left_e0", "left_e1", "left_w0", "left_w1", "left_w2" ], joint_positions: [ $q0, $q1, $q2, $q3, $q4, $q5, $q6, 0.192483, 1.047, 0.000806359, 0.491094, -0.178079, -0.0610333, -0.0124707 ] }'


