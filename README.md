# computercraft
A library of computercraft scripts.  Currently holds only turtles.
Uses a single script for all downloads and updates.  Bots are then run directly.

## TURTLES
Install the updater once:
```shell
wget https://raw.githubusercontent.com/Kind-Stranger/computercraft/master/uprun.lua getbot.lua
```

Use `getbot` to update it and a bot's libraries:
```shell
getbot BOTNAME
```
...where BOTNAME is the name of the required turtle script (see Available Turtles section below) e.g.
```shell
getbot farm
```

See the help for an individual bot:
```shell
BOTNAME help
```


### Available Turtles
- chop
- farm
