-- /farm.lua --

--[[ usage: farm [crop] [move_pattern]

where: crop - restrict to specific crop type
         defaults to any if omitted
       move_pattern - specify a movement pattern module
         defaults to snake if omitted
]]--

local cropArg = arg[1]
if not cropArg then cropArg = "any" end
local moveArg = arg[2]
if not moveArg then moveArg = "snake" end

local cropU = require("lib.farm.croputils")
local itemU = require("lib.general.itemutils")
local moveU = assert(
  require("lib.move."..moveArg),
  error("Invalid move arg", 1))
               
local function harvest(block)
  local crop = itemU.getSimpleName(block)
  print("..harvesting"..crop)
  turtle.digDown()
end

local function sowSeed(block)
  local seedSlot, msg = cropU.setSeedSlot(block)
  if not seedSlot then
    print("..not replanting: "..msg)
    return
  end
  print("..sowing "..msg)
  turtle.select(seedSlot)
  turtle.placeDown()
end

local function harvestIfMature(block)
  if cropU.isMature(block) then
    harvest(block)
    sowSeed(block)
  else
    print("..ignoring")
  end
end

local function farm()
  local hasBlock, block = turtle.inspectDown()
  if not hasBlock then
    print("Only air")
    return
  end
  local blockName = itemU.getSimpleName(block)
  print("Found:", blockName)

  if cropArg == "any" or
     cropArg == blockName then
    harvestIfMature(block)
  else
    print("..ignoring")
  end
end

local function help()
  print("Only works in rectangle enclosures.")
  print("Place turtle in layer directly above crops.")
  print("Turtle requires border fence around whole farm at its level (any solid block above crop level)")
  print("Will not plant new crops.")
  print("Will only replant existing crops.")
end

local function main()
  if arg[1] and string.lower(arg[1]) == 'help' then
    help()
    return
  end
  print("Farming crop: \""..cropArg.."\"")
  print("..moving using \""..moveArg.."\"")
  -- Initialise move history --
  local move
  local moveHist = {"R"}
  while turtle.getFuelLevel() > 0 do
    farm()
    move, moveHist = assert(moveU.next(moveHist))
    if move == "X" then
      sleep(300)
    else
      sleep(1)
    end
  end
  print("*** out of fuel ***")
end

main()
