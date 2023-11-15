#https://docs.zenml.io/v/docs/stacks-and-components/component-guide/orchestrators/kubernetes

# ensure some integrations are installed
yes | zenml integration install kubernetes

# clean up if exists aleady\
# stack
zenml stack set default
yes | zenml stack delete comp_test_kubernetes_stack
# component (destroy/remove)
yes | zenml orchestrator destroy comp_test_kubernetes  -p k3d 
# destory does not remove the registration or the cr, so we do it manually
yes | zenml container-registry delete comp_test_kubernetes  

# set up
# the docker container mounts the local zenml store, but since this is run from inside a devcontainer, it will try to mount from the host machine. So this can only work when running this from the host
# deploy/register components
zenml orchestrator deploy comp_test_kubernetes --flavor=kubernetes -p k3d -r local

# set up stack
# copy the default
zenml stack copy default comp_test_kubernetes_stack
zenml stack set comp_test_kubernetes_stack
# add to stack
zenml stack update comp_test_kubernetes_stack -o comp_test_kubernetes -c comp_test_kubernetes


# run pipeline
python basic_pipeline.py
