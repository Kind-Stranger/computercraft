-- /farm.lua --
local moveU
local cropU = require("lib.farm.croputils")
local itemU = require("lib.general.itemutils")

--[[ usage: farm [crop] [move_pattern]

where: crop - restrict to specific crop type
         defaults to any if omitted
       move_pattern - specify a movement pattern module
         defaults to snake if omitted
]]--

seedSlot = 1
cropArg = arg[1]
if not cropArg or #cropArg == 0 then
  cropArg = "any"
end

local function setMoveU(module)
  local s, e
  if not module or #module == 0 then
    arg = "snake"
  end
  if not string.match(module, "^[a-z]+$") then
    error("Invalid move arg", 1)
  end
  moveU = require("lib.move."..module)
end

local moveArg
if not arg[2] or not #arg[2] then
  arg[2] = "snake"
end
stat, err = pcall(setMoveU, arg[2])
if not stat then
  print(err)
  error("Invalid move arg", 1)
end
moveArg = arg[2]

local function harvest()
  print("..harvesting")
  turtle.digDown()
end

local function sowSeed()
  turtle.select(seedSlot)
  local seedData = turtle.getItemDetail()
  local seedName = itemU.getSimpleName(seedData)
  print("..sowing "..seedName)
  turtle.placeDown()  
end

local function harvestIfMature(block)
  if cropU.isMature(block) then
    harvest()
    sowSeed()
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
  -- print(textutils.serialise(block)) --

  if cropArg == "any" or
     cropArg == blockName then
    harvestIfMature(block)
  else
    print("..ignoring")
  end
end

local function main()
  local nextBlockName
  local moveHist = {"R"}
  while turtle.getFuelLevel() > 0 do
    nextBlockName = farm()
    move, moveHist = moveU.next(moveHist)
    sleep(1)
    if move == "X" then
      sleep(300)
    end
  end
  print("*** out of fuel ***")
end

print("Farming crop: \""..cropArg.."\"")
print("..moving using \""..moveArg.."\"")
main()