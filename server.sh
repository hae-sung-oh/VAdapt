#!/bin/bash

# Function to start a Carla server in an infinite loop
start_carla_server() {
    PORT=$1
    cleanup() {
        echo "Killing Carla server on port $PORT..."
        kill $CARLA_PID
        exit 0
    }

    trap cleanup SIGINT SIGTERM

    while true; do
        # Run the server with the specific port
        $CARLA_ROOT/Dist/CARLA_Shipping_0.9.12-dirty/LinuxNoEditor/CarlaUE4.sh --world-port=$PORT \
        2> >(grep -v -e "ERROR: Invalid session: no stream available with id" \
        -e "error retrieving stream id" \
        -e "ERROR" \
        -e "Connection reset by peer" \
        -e "End of file") & CARLA_PID=$!

        wait $CARLA_PID

        echo -e "\nCarla Server on port $PORT has stopped. Restarting...\n"
        sleep 2
    done
}

# Start multiple servers with different ports in parallel
start_carla_server 20000 &
start_carla_server 20002 &
start_carla_server 20004 &
start_carla_server 20006 &

# Wait for all background jobs to complete
wait


# bash $CARLA_ROOT/Dist/CARLA_Shipping_0.9.12-dirty/LinuxNoEditor/CarlaUE4.sh --world-port=20000 &
# bash $CARLA_ROOT/Dist/CARLA_Shipping_0.9.12-dirty/LinuxNoEditor/CarlaUE4.sh --world-port=20002 &
# bash $CARLA_ROOT/Dist/CARLA_Shipping_0.9.12-dirty/LinuxNoEditor/CarlaUE4.sh --world-port=20004 &
# bash $CARLA_ROOT/Dist/CARLA_Shipping_0.9.12-dirty/LinuxNoEditor/CarlaUE4.sh --world-port=20006 &
# bash $CARLA_ROOT/Dist/CARLA_Shipping_0.9.12-dirty/LinuxNoEditor/CarlaUE4.sh --world-port=20008 &
# bash $CARLA_ROOT/Dist/CARLA_Shipping_0.9.12-dirty/LinuxNoEditor/CarlaUE4.sh --world-port=20010 &
# bash $CARLA_ROOT/Dist/CARLA_Shipping_0.9.12-dirty/LinuxNoEditor/CarlaUE4.sh --world-port=20012 &
# bash $CARLA_ROOT/Dist/CARLA_Shipping_0.9.12-dirty/LinuxNoEditor/CarlaUE4.sh --world-port=20014 &
# bash $CARLA_ROOT/Dist/CARLA_Shipping_0.9.12-dirty/LinuxNoEditor/CarlaUE4.sh --world-port=20016 &
# bash $CARLA_ROOT/Dist/CARLA_Shipping_0.9.12-dirty/LinuxNoEditor/CarlaUE4.sh --world-port=20018 &
# bash $CARLA_ROOT/Dist/CARLA_Shipping_0.9.12-dirty/LinuxNoEditor/CarlaUE4.sh --world-port=20020 &
# bash $CARLA_ROOT/Dist/CARLA_Shipping_0.9.12-dirty/LinuxNoEditor/CarlaUE4.sh --world-port=20022 &
# bash $CARLA_ROOT/Dist/CARLA_Shipping_0.9.12-dirty/LinuxNoEditor/CarlaUE4.sh --world-port=20024 &
# bash $CARLA_ROOT/Dist/CARLA_Shipping_0.9.12-dirty/LinuxNoEditor/CarlaUE4.sh --world-port=20026 &