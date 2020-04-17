# Stardew Valley Multiplayer Docker Compose

This project aims to autostart a Stardew Valley Multiplayer Server as easy as possible. It's a [fork of printfuck's excellent base](https://github.com/printfuck/stardew-multiplayer-docker), which includes terraform/ansible config if needed.

## Setup
Everything is set up using docker-compose, the easiest way to get going with the defaults is by running:
 
```
git clone https://github.com/printfuck/stardew-multiplayer-docker

docker-compose up --build
```

If you want persistent admin users for the remote control mod, create an empty `configs/remotecontrol.json` file and use this docker-compose command instead

```
docker-compose -f docker-compose.yml -f remotecontrol.override.yml up -d --build
```

### Game Setup

The server can be configured by creating a `.env` file in the repository root

The main thing to be configured is the game save to be loaded. You can copy it from an existing game and put it in the valley_saves directory (eg. `valley_saves/Host_123456789/...`), bearing in mind the original player will become the unplayable host.

Intially you have to create or load a game once after first startup. After that the Autoload Mod jump starts into the previously loaded savegame everytime you rerun the container. You can also edit the config file of the Autoload Mod to archieve similar behaviour.

### Example .env file
```
# 10 second timespeect = 20 minute days
ENABLE_TIMESPEED_MOD=true
TIME_SPEED_DEFAULT_TICK_LENGTH=10.0
TIME_SPEED_TICK_LENGTH_BY_LOCATION_INDOORS=10.0
TIME_SPEED_TICK_LENGTH_BY_LOCATION_OUTDOORS=10.0
TIME_SPEED_TICK_LENGTH_BY_LOCATION_MINE=10.0

UNLIMITED_PLAYERS_PLAYER_LIMIT=100

AUTO_LOAD_GAME_LAST_FILE_LOADED=Host_244102323

REMOTE_CONTROL_EVERYONE_IS_ADMIN=true
```


## Included Mods

* [AutoLoadGame](https://www.nexusmods.com/stardewvalley/mods/2509)
* [Always On](https://community.playstarbound.com/threads/updating-mods-for-stardew-valley-1-4.156000/page-20#post-3353880)
* [Unlimited Players](https://www.nexusmods.com/stardewvalley/mods/2213)
* [Remote Control](https://github.com/Novex/StardewValley-RemoteControl)

## Troubleshooting

### Error Messages in Console

Usually you should be able to ignore any message there. If the game doesn't start or any errors appear, you should look for messages like "cannot open display", which would most likely indicate permission errors.

The SMAPI log will be tailed to the 

### VNC

Access the game via VNC to initially load or start a pregenerated savegame. You can control the Server from there or edit the config.json files in the configs folder.