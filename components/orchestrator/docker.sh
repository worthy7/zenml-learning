#https://docs.zenml.io/v/docs/stacks-and-components/component-guide/orchestrators/local-docker

# ensure some integrations are installed
# NA

# clean up if exists aleady\
# stack
zenml stack set default
yes | zenml stack delete comp_test_orc_docker_stack
# component (destroy/remove)
yes | zenml orchestrator delete comp_test_orc_docker

# set up
# the docker container mounts the local zenml store, but since this is run from inside a devcontainer, it will try to mount from the host machine. So this can only work when running this from the host
# deploy/register components
zenml orchestrator register comp_test_orc_docker --flavor=local_docker

# set up stack
# copy the default
zenml stack copy default comp_test_orc_docker_stack
zenml stack set comp_test_orc_docker_stack
# add to stack
zenml stack update comp_test_orc_docker_stack -o comp_test_orc_docker


# run pipeline
python basic_pipeline.py

# stop and delete all containers
#docker stop $(docker ps -a -q)
#docker remove $(docker ps -a -q)
#docker volume remove $(docker volume ls -q)