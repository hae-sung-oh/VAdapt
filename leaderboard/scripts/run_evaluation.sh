#!/bin/bash

export CARLA_ROOT=/home/ohs-dyros/carla
export CARLA_SERVER=${CARLA_ROOT}/CarlaUE4.sh
export PYTHONPATH=$PYTHONPATH:${CARLA_ROOT}/PythonAPI
export PYTHONPATH=$PYTHONPATH:${CARLA_ROOT}/PythonAPI/carla
export PYTHONPATH=$PYTHONPATH:$CARLA_ROOT/PythonAPI/carla/dist/carla-0.9.12-py3.8-linux-x86_64.egg
export PYTHONPATH=$PYTHONPATH:leaderboard
export PYTHONPATH=$PYTHONPATH:leaderboard/team_code
export PYTHONPATH=$PYTHONPATH:scenario_runner

export INTERFUSER_ROOT=/home/ohs-dyros/gitRepo/InterFuser

export LEADERBOARD_ROOT=${INTERFUSER_ROOT}/leaderboard
export CHALLENGE_TRACK_CODENAME=SENSORS
export PORT=20000 # same as the carla server port
export TM_PORT=25000 # port for traffic manager, required when spawning multiple servers/clients
export DEBUG_CHALLENGE=0
export REPETITIONS=1 # multiple evaluation runs
export ROUTES=${INTERFUSER_ROOT}/leaderboard/data/training_routes/routes_town05_long.xml
export TEAM_AGENT=${INTERFUSER_ROOT}/leaderboard/team_code/interfuser_agent.py # agent
export TEAM_CONFIG=${INTERFUSER_ROOT}/leaderboard/team_code/interfuser_config.py # model checkpoint, not required for expert
export CHECKPOINT_ENDPOINT=${INTERFUSER_ROOT}/results/sample_result.json # results file
export SCENARIOS=${INTERFUSER_ROOT}/leaderboard/data/scenarios/town05_all_scenarios.json
export SAVE_PATH=${INTERFUSER_ROOT}/data/eval # path for saving episodes while evaluating
export RESUME=False

python ${LEADERBOARD_ROOT}/leaderboard/leaderboard_evaluator.py \
--scenarios=${SCENARIOS}  \
--routes=${ROUTES} \
--repetitions=${REPETITIONS} \
--track=${CHALLENGE_TRACK_CODENAME} \
--checkpoint=${CHECKPOINT_ENDPOINT} \
--agent=${TEAM_AGENT} \
--agent-config=${TEAM_CONFIG} \
--debug=${DEBUG_CHALLENGE} \
--record=${RECORD_PATH} \
--resume=${RESUME} \
--port=${PORT} \
--trafficManagerPort=${TM_PORT}

