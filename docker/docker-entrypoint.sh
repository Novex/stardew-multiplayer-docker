#!/bin/bash

trap "echo --- Caught signal to stop server ---; /opt/shutdown.sh; exit 0" SIGTERM SIGINT SIGABRT SIGHUP

if [ -f /tmp/.X10-lock ]; then rm /tmp/.X10-lock; fi
Xvfb :10 -screen 0 1580x920x24 -ac &

while [ ! -z "`xdpyinfo -display :10 2>&1 | grep 'unable to open display'`" ]; do
  echo Waiting for display;
  sleep 5;
done

export DISPLAY=:10.0
x11vnc -display :10 -rfbport 5900 -rfbportv6 -1 -no6 -noipv6 -httpportv6 -1 -forever -desktop StardewValley -cursor arrow -passwd $VNCPASS -shared & 
sleep 5
i3 &
export XAUTHORITY=~/.Xauthority
TERM=xterm

# Configure the mods
for modPath in /data/Stardew/Stardew\ Valley/Mods/*/
do
  mod=$(basename "$modPath")

  # Normalize mod name ot uppercase and only characters, eg. "Always On Server" => ENABLE_ALWAYSONSERVER_MOD
  var="ENABLE_$(echo "${mod^^}" | tr -cd '[A-Z]')_MOD"

  # Remove the mod if it's not enabled
  if [ "${!var}" != "true" ]; then
    echo "Removing ${modPath} (${var}=${!var})"
    rm -rf "$modPath"
    continue
  fi

  if [ -f "${modPath}/config.json.template" ]; then
    echo "Configuring ${modPath}config.json"

    # Seed the config.json only if one isn't manually mounted in (or is empty)
    if [ "$(cat "${modPath}config.json" 2> /dev/null)" == "" ]; then
      envsubst < "${modPath}config.json.template" > "${modPath}config.json"
    fi
  fi
done

/opt/configure-remotecontrol-mod.sh

/opt/tail-smapi-log.sh &

/data/Stardew/Stardew\ Valley/StardewValley &
wait $!

# If we made it here Stardew exited so kill everything else since there's no point for the container to be running
sleep 5
echo killing
kill -9 1