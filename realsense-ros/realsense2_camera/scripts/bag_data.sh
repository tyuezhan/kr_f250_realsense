#!/bin/sh

TOPICS="
/tf
/tf_static
/dragonfly67/quadrotor_ukf/control_odom
/f250_ariel/mavros/imu/data
/camera/depth/image_rect_raw
/camera/depth/camera_info
/camera/color/image_raw
/camera/infra1/image_rect_raw
/camera/infra2/image_rect_raw
/camera/imu
/camera/aligned_depth_to_color/image_raw
/camera/aligned_depth_to_color/camera_info
/scarab40/odom_laser
/scarab41/odom_laser
/scarab42/odom_laser
/scarab43/odom_laser
/scarab44/odom_laser
/scarab45/odom_laser
/scarab46/odom_laser
/camera/depth/camera_info
/camera/aligned_depth_to_color/camera_info
"

ALL_TOPICS=$TOPICS

BAG_STAMP=$(date +%F-%H-%M-%S-%Z)
CURR_TIMEZONE=$(date +%Z)

BAG_PREFIX=V${MAV_ID}-${CURR_TIMEZONE}

eval rosbag record -b512 $ALL_TOPICS -o $BAG_PREFIX
