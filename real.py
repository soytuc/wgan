import numpy as np
import rospy
from sensor_msgs.msg import Image as msg_Image
from sensor_msgs.msg import PointCloud2 as msg_pc 
from cv_bridge import CvBridge, CvBridgeError
import sys
import os
import cv2
import argparse
from sensor_msgs.point_cloud2 import read_points

class ImageListener:
    def __init__(self, topic):
        self.topic = topic
        self.bridge = CvBridge()
        self.sub = rospy.Subscriber(topic, msg_Image, self.imageDepthCallback)

    def imageDepthCallback(self, data):
        try:
            cv_image = self.bridge.imgmsg_to_cv2(data, data.encoding)
            pix = (data.width/2, data.height/2)
            sys.stdout.write('%s: Depth at center(%d, %d): %f(mm)\r' % (self.topic, pix[0], pix[1], cv_image[pix[1], pix[0]]))
            sys.stdout.flush()
        except CvBridgeError as e:
            print(e)
            return


if __name__ == '__main__':
    folder='/root/db/'
    argParser = argparse.ArgumentParser()
    argParser.add_argument("-e", "--experiment", nargs=3, type=float, default=[0, 1,np.pi/2],
                           help="position and orientation of woman in radians, only for x,y position and z rotation, example 0,0,0")

    args = argParser.parse_args()
    rospy.init_node("depth_image_processor")

    # data=rospy.wait_for_message('/camera/depth/color/points',msg_pc,1)
    # for point in read_points(data, field_names=('x', 'y', 'z')):
    #     print(f"x: {point[0]}, y: {point[1]}, z: {point[2]}")
    # print(data)
    # exit(0)
    data=rospy.wait_for_message('/camera/depth/image_raw',msg_Image,1)
    bridge = CvBridge()
    cv_image = bridge.imgmsg_to_cv2(data, data.encoding)
    # exit(0)
    cv2.imwrite(folder+'imageDepth'+'_'+str(args.experiment[0])+'_'+str(args.experiment[1])+'_'+str(args.experiment[2])+'.png',cv_image)
    data = rospy.wait_for_message('/camera/color/image_raw', msg_Image, 1)
    bridge = CvBridge()
    cv_image = bridge.imgmsg_to_cv2(data, data.encoding)
    cv2.imwrite(folder+'imageColor'+'_'+str(args.experiment[0])+'_'+str(args.experiment[1])+'_'+str(args.experiment[2])+'.png', cv2.cvtColor(cv_image, cv2.COLOR_RGB2BGR))






