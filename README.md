#Imagewgangpplanning
#### System Requirements

* An NVIDIA GPU compatible with CUDA Version 11 and a minimum of 8GB VRAM.
* A Linux distribution with kernel compatible with 5.15.0-73-generic.

To simplify the installation process, we provide a Docker image, which can be found in this repository inside the folder _dockerfile_.

The source code can be found too inside the Docker container.  
#### Installation Steps

To run the path planner, you need to install [CUDA](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html), [Docker](https://docs.docker.com/get-docker/) and [Nvidia-Container-toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html). The installation procedure may vary depending on the chosen Linux distribution. We have tested the installation on Ubuntu 22.04 and 23.04.
###### Example Installation on Ubuntu 23.04:

In this example, we install NVIDIA drivers on a non-LTS supported version. In some cases, it may be possible to install CUDA on a regular Ubuntu version by changing the repositories to the previous LTS version. You can check the supported versions for your Linux distribution [here](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html).

To install CUDA, open a terminal and run the following commands:

    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.0-1_all.deb;sudo dpkg -i cuda-keyring_1.0-1_all.deb;sudo apt-get update;sudo apt-get -y install cuda

You can verify the installation by running:

    nvidia-smi
If installed correctly, it should display the Driver version and CUDA version.

Next, install Docker by running:

    curl https://get.docker.com | sh   && sudo systemctl --now enable docker
You can check if the installation was successful by running:

    docker info
Finally, install NVIDIA Toolkit Container:

    distribution=ubuntu22.04;curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg       && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list |             sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' |             sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list;sudo apt-get update;sudo apt-get install -y nvidia-container-toolkit;sudo nvidia-ctk runtime configure --runtime=docker;sudo systemctl restart docker

#### Create the docker container
Download the repository from here:

    https://anonymous.4open.science/r/wgan-A650/README.md

Press the "Download repository" button on the right corner of the web page.

Once downloaded, extract the file "wgan-A650.zip" to a folder with the name wgan-A650.

In the same folder where repository was extracted run:

    cd dockerfile/;imageName=imagewgangpplanning;sudo docker build -t $imageName .;

If the docker image is succesfully built, you can proceed to create a container by running :

    sudo docker run --gpus all --net=host --privileged --env="DISPLAY=$DISPLAY" --env="QT_X11_NO_MITSHM=1" --env="NVIDIA_VISIBLE_DEVICES=all" --env="NVIDIA_DRIVER_CAPABILITIES=graphics,utility,compute" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" -device=/dev/dri:/dev/dri --name imgwgangpcontainer  -it imagewgangpplanning bash

After creating the container, we need to build the planning algorithm and it's dependencies. To enter inside the container's shell please run the following command:

    sudo docker exec -it imgwgangpcontainer bash
Then, inside the container shell, proceed to run:

    cd;chmod 755 extrafiles/dockerfile/afterBuild.sh;extrafiles/dockerfile/afterBuild.sh;exit

This last process will take several minutes.

#### Running the planner
To run the planner; we need to open four new container terminals; this is done by opening a terminal emulator for each container shell (e.g. Gnome-terminal ctrl+alt+t). In each terminal emulator run first the command:

    sudo docker ps  | grep imgwgangpcontainer && sudo docker exec -it imgwgangpcontainer bash || sudo docker start -i imgwgangpcontainer

In the first terminal; run
 
    gaz
And wait until we get the message

    Gravity compensation was turned off

Now, go two the second terminal, and run
    
    activate

We should get the message

    Robot enabled

If not; please cancel the current process by pressing
    
    ctrl+c

And run 

    active

again. This process should be followed until the message

    Robot enabled

is shown.

On the third terminal, we run the command

    loadlibs;mvit

And we would wait until we got the message

    You can start planning now!
Finally, on the fourth terminal, we run the command
    
    cd /root/ws_moveit2/src/planning;loadlibs;planning --isGan true --nExperiment 0 --generateTestingData false --takeOnlyPhotos false

where, the parameter "--nExperiment" selects one of the 100 available working spaces used for testing; from 0 to 99. Each scenario changes the position of the as obstacle. In each scenario, there are 100 different initial and final configurations. 

The parameter "--isGan" from the fourth terminal can be changed between "true" and "false", in the case of "true" we will use the algorithm proposed in our paper, in the case of "false", we will run the ompl implementation of RRT.

For running RRT*, the parmeter "--isGan" should be also set to "false" and before running the planner we  would need to change the parameter "planner_id: RRTkConfigDefault" to planner_id: RRTStarkConfigDefault in the file /root/ws_moveit2/planning/src/configuration.yaml, which can be done by the command:

    sed -i -e 's/planner_id: RRTkConfigDefault/planner_id: RRTStarkConfigDefault/g' /root/ws_moveit2/src/planning/src/configuration.yaml

To switch back to RRT or our proposed implementation, run the command

    sed -i -e 's/planner_id: RRTStarkConfigDefault/planner_id: RRTkConfigDefault/g' /root/ws_moveit2/src/planning/src/configuration.yaml

The results of the planner, would be saved in the file

    /root/results.csv

Inside /root/results.csv, the first column represents the path length, the second one the planning time, the third one the total number of nodes in the graph, and the fourth one is the reduced number of waypoints of the path.


