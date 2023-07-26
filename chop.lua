local itemU = require("lib.general.itemutils")
local invU = require("lib.general.inventoryutils")

local function spiralSuck(dia)
  local dia = dia or 1
  local currDia
  for currDia=1, dia do
    for side=1, 4 do
      for _=1, currDia do
        turtle.suck()
        turtle.forward()
      end
      turtle.turnLeft()
    end
  end
end

local function spinSuck()
  for i=1, 4 do
    turtle.suck()
    turtle.turnLeft()
  end
end

local function plant()
  if turtle.inspect() then
    --Something in the way
    --Hopefully a chop will fix it
    return
  end
  local saplingSlot = invU.scanFor("sapling")
  if not saplingSlot then
    saplingSlot = invU.scanFor("blockrubsapling")
  end
  assert(saplingSlot,
         "*** out of saplings ***")
  turtle.select(saplingSlot)
  assert(turtle.place())
end

local function saplingInFront()
  local hasBlock
  local block
  hasBlock, block = turtle.inspect()
  if hasBlock then
    local name = itemU.getSimpleName(block)
    return name == "sapling" or
           name == "blockrubsapling"
  end
end

local function fertilise()
  local messaged = false
  while saplingInFront() do
    local bmSlot = invU.scanFor("dye", 15) --Bone meal
    if bmSlot then
      messaged = false
      turtle.select(bmSlot)
      while turtle.getItemCount() > 0 and saplingInFront() do
        assert(turtle.place())
        sleep(0.5)
      end
    else
      if not messaged then
        print("..no bone meal")
        messaged = true
      end
      sleep(60)
    end
  end
end

local function chop()
  --[[
    blockrubwood or
    ^logs?\.?%d*$
  ]]
  while turtle.dig() do
    turtle.digUp()
    turtle.up()
  end
end

local function main()
  while turtle.down() do end
  spinSuck()
  while turtle.getFuelLevel() > 0 do
    plant()
    fertilise()
    chop()
    while turtle.down() do end
    spiralSuck()
  end
  print("*** out of fuel ***")
end

main()
