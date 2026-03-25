import os
import argparse
parser = argparse.ArgumentParser()
parser.add_argument('--q0', type=float)
parser.add_argument('--q1', type=float)
parser.add_argument('--q2', type=float)
parser.add_argument('--q3', type=float)
parser.add_argument('--q4', type=float)
parser.add_argument('--q5', type=float)
parsedArguments=parser.parse_args()
cmd = 'rosservice call /gazebo/set_model_configuration \'{ model_name: "baxter", urdf_param_name: "robot_description", joint_names: [ "right_s0", "right_s1", "right_e0", "right_e1", "right_w0", "right_w1", "right_w2", "left_s0", "left_s1", "left_e0", "left_e1", "left_w0", "left_w1", "left_w2" ], joint_positions: ['+ str(parsedArguments.q0)+', '+str(parsedArguments.q1)+', '+str(parsedArguments.q2)+', '+str(parsedArguments.q3)+', '+str(parsedArguments.q4)+', '+str(parsedArguments.q5)+', 0.0265941, 0.192483, 1.047, 0.000806359, 0.491094, -0.178079, -0.0610333, -0.0124707 ] }\''
os.system(cmd)

