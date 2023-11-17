#https://docs.zenml.io/v/docs/stacks-and-components/component-guide/orchestrators/kubeflow

#zenml up --docker

# ensure some integrations are installed
yes | zenml integration install kubeflow

# clean up if exists aleady
# stack
zenml stack set default
#yes | zenml stack delete comp_test_kubeflow_stack
# component (destroy/remove)
#yes | zenml container-registry delete comp_test_container_registry_default
yes | zenml stack destroy comp_test_kubeflow_stack
# destory does not remove the registration or the cr, so we do it manually
yes | zenml container-registry delete comp_test_kubeflow  
# set up
# the docker container mounts the local zenml store, but since this is run from inside a devcontainer, it will try to mount from the host machine. So this can only work when running this from the host
# deploy/register components
zenml stack deploy -n comp_test_kubeflow -p k3d -r remote ### TODO may need to tell kubeflow more config

#using zenml deploy

#zenml stack deploy -p k3d -r local -name comp_test_kubeflow


#now the reigstry is set up, you may need to add it to the host hosts to be able to use it from the host.... 
#zenml container-registry register comp_test_container_registry_default --flavor=default --uri=0.0.0.0:5000

# set up stack
# copy the default
zenml stack copy default comp_test_kubeflow_stack
zenml stack set comp_test_kubeflow_stack
# add to stack
zenml stack update comp_test_kubeflow_stack -o comp_test_kubeflow -c comp_test_kubeflow


# run pipeline  
python basic_pipeline.py

#yes | zenml container-registry delete comp_test_container_registry_default
yes | zenml stack destroy comp_test_kubeflow_stack
# destory does not remove the registration or the cr, so we do it manually
yes | zenml container-registry delete comp_test_kubeflow  