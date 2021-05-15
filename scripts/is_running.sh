#!/bin/bash

CONTAINER=$1

test_running() {
	RUNNING=$(docker inspect --format="{{.State.Running}}" $CONTAINER 2> /dev/null)

	if [ "$RUNNING" == "false" ]; then
	  echo "Container not running"
	  return 1
	fi

	RESTARTING=$(docker inspect --format="{{.State.Restarting}}" $CONTAINER)

	if [ "$RESTARTING" == "true" ]; then
	  echo "Container is restarting"
	  return 1
	fi

	if [ "$RUNNING" == "true" ]; then
		echo "Container is running"
		return 0
	fi

	return 1
}

echo "Waiting for $CONTAINER to be up"

i=0

while ! test_running; do
	i=$((i + 1))
	if [ "$i" -ge 30 ]; then
		echo " - Not ready"
		docker logs --tail 50 "$CONTAINER"
		exit 1
	fi
	sleep 1
done

echo '- Done'