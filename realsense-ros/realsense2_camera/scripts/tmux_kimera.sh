#!/bin/bash

WORLD_FRAME_ID=world

# MASTER_URI=http://10.42.0.1:11311
# SETUP_ROS_STRING="export ROS_MASTER_URI=${MASTER_URI}"
SETUP_ROS_STRING=""
SESSION_NAME=kimera

CURRENT_DISPLAY=${DISPLAY}
if [ -z ${DISPLAY} ];
then
  echo "DISPLAY is not set"
  CURRENT_DISPLAY=:0
fi

if [ -z ${TMUX} ];
then
  TMUX= tmux new-session -s $SESSION_NAME -d
  echo "Starting new session."
else
  echo "Already in tmux, leave it first."
  exit
fi

# Make mouse useful in copy mode
tmux setw -g mouse on

tmux new-window -t $SESSION_NAME -n "Main"
tmux send-keys -t $SESSION_NAME "$SETUP_ROS_STRING; sleep 1; roslaunch realsense2_camera d455.launch" Enter
tmux select-layout -t $SESSION_NAME tiled

tmux new-window -t $SESSION_NAME -n "Kimera"
tmux send-keys -t $SESSION_NAME "$SETUP_ROS_STRING; sleep 2; roslaunch kimera_vio_ros kimera_vio_ros_realsense_IR.launch" Enter
# tmux split-window -t $SESSION_NAME
# tmux send-keys -t $SESSION_NAME "$SETUP_ROS_STRING; sleep 4; roslaunch scan2shape_launch real_robot_process_cloud_node.launch" Enter


# Add window to easily kill all processes
tmux new-window -t $SESSION_NAME -n "Kill"
tmux send-keys -t $SESSION_NAME "tmux kill-session -t ${SESSION_NAME}"

tmux select-window -t $SESSION_NAME:5
tmux -2 attach-session -t $SESSION_NAME