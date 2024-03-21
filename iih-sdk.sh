#!/bin/bash
#set -e

SELF_PATH=$(realpath "$0")
WORKDIR=$(dirname "${SELF_PATH}")
cd "${WORKDIR}"

images=(
    "siemensindustrialedge/dataservicedevelopmentkit:1.8.0"
    "siemensindustrialedge/dataservicesimulation:1.5.2"
    "swaggerapi/swagger-generator-v3:3.0.46"
    "siemensindustrialedge/sdk-mb:1.0.0"
    "siemensindustrialedge/sdk-ui:1.0.0"
    "siemensindustrialedge/sdk-be:1.0.0"
    "siemensindustrialedge/sdk-db:1.0.0"
    "siemensindustrialedge/sdk-fc:1.0.0" 
    "siemensindustrialedge/sdk-ap:1.0.0"
)

srv_containers=(
    "ie-databus"
    "edgeappdataservice"
    "ie-flow-creator"
    "simulation"
    "simulation-broker"
)


PreChecks() {	
    if [[ -d "${WORKDIR}/scripts" ]] && [[ -f "${WORKDIR}/scripts/docker-compose.yaml" ]] && [[ -d "${WORKDIR}/docs" ]] && [[ -f "${WORKDIR}/README.md" ]]; then    
        echo ""    
    else
        echo "Pre-requisite checks failed. Please check your installation package."
        exit 1
    fi
}

if [[ "$#" -eq 1 ]] && [[ "$1" =~ ^(install|start|stop|remove)$ ]]
then
	case $1 in 
		"install") 
			PreChecks
            echo -e "----> Installing IIH SDK <----\n"

            echo -e "----> Importing IIH SDK images....\n"
            for image in "${images[@]}"; do
                if ! docker pull $image; then
                    echo -e "Something went wrong while importing the SDK images. Please check your network."
                    exit 1
                fi
            done
            echo -e "----> Imported IIH SDK images !! \n"

			# Check and create docker network
            echo -e "----> Creating proxy-redirect bridge network network.... \n"
			NETWORK="proxy-redirect"
			docker network inspect ${NETWORK} &>/dev/null || docker network create ${NETWORK}
			echo -e "---> Created proxy-redirect bridge network !!\n"

			echo -e "----> IIH SDK is installed <----\n"
			exit 0
		;;

		"start")
            PreChecks
            echo -e "---->  Starting IIH SDK <----\n"
            DOCKER_COMPOSE_LOCATION=${WORKDIR}/scripts/docker-compose.yaml
            COMMAND="up --detach --force-recreate"
            if ! docker compose -f ${DOCKER_COMPOSE_LOCATION} ${COMMAND}; then
                echo -e "Something went wrong while starting the SDK."
                exit 1
            fi
            echo -e "----> Started IIH SDK. Open  http://localhost:48080/ in browser <----\n"
            exit 0
		;;

 		"stop")
            PreChecks
            echo -e "---->  Stopping IIH SDK <----\n"
            for srv in "${srv_containers[@]}"; do
                if docker container inspect ${srv} &>/dev/null; then
                    echo "IIH SDK not stopped as few running emulation apps were detected. Please navigate to the 'Test Application' workflow page and Stop all running services by clicking the top right 'Stop All Services' button."
                    exit 1
                fi
            done
            DOCKER_COMPOSE_LOCATION=${WORKDIR}/scripts/docker-compose.yaml
            COMMAND="down --remove-orphans"
            if ! docker compose -f ${DOCKER_COMPOSE_LOCATION} ${COMMAND}; then
                echo "Something went wrong while stopping the IIH SDK. Please check !!"
                exit 1
            fi
            echo -e "---->  Stopped IIH SDK <----\n"
            exit 0
		;;
  
        "remove") 
            PreChecks
			echo -e "----> Remove/Uninstall IIH SDK : Start <----\n" 
            for srv in "${srv_containers[@]}"; do
                if docker container inspect ${srv} &>/dev/null; then
                    echo "IIH SDK not stopped as few running emulation apps were detected. Please navigate to the 'Test Application' workflow page and Stop all running services by clicking the top right 'Stop All Services' button."
                    exit 1
                fi
            done

            echo -e "----> Stopping IIH SDK <----\n"
            DOCKER_COMPOSE_LOCATION=${WORKDIR}/scripts/docker-compose.yaml
            COMMAND="down --remove-orphans --volumes"
            if ! docker compose -f ${DOCKER_COMPOSE_LOCATION} ${COMMAND}; then
                echo "Something went wrong while stopping the IIH SDK."
                exit 1
            fi
            echo -e "---->  Stopped IIH SDK <----\n"
            # Remove the images
            echo "Clearing IIH SDK Images..."
            for image in "${images[@]}"; do
                docker image rm "$image"
            done
			# Remove Docker Network
			NETWORK="proxy-redirect"
			docker network remove proxy-redirect
			echo -e "---> Removed proxy-redirect bridge network.\n"
			echo -e "----> Remove/Uninstall IIH SDK : Complete <----\n"
			exit 0
		;;
	esac
else
	echo "Invalid Usage or Option. Please use as given below."
    echo "./iih-sdk.sh install"
	echo "./iih-sdk.sh start"
	echo "./iih-sdk.sh stop"
    echo "./iih-sdk.sh remove"
	exit 1
fi