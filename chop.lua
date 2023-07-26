local itemU = require("lib.general.itemutils")
local invU = require("lib.general.inventoryutils")

local function spinSuck()
  while turtle.down() do end
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
  local saplingSlot = assert(
    invU.scanFor("sapling"),
    "*** out of saplings ***")
  turtle.select(saplingSlot)
  assert(turtle.place())
end

local function isInFront(name)
  return name == itemU.getSimpleName(turtle.inspect())
end

local function fertilise()
  local messaged = false
  while isInFront("sapling") do
    local bmSlot = invU.scanFor("dye", 15) --Bone meal
    if bmSlot then
      messaged = false
      turtle.select(bmSlot)
      while turtle.getItemCount() > 0 and isInFront("sapling") do
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
  spinSuck()
  while turtle.getFuelLevel() > 0 do
    plant()
    fertilise()
    chop()
    sleep(2)
    spinSuck()
  end
  print("*** out of fuel ***")
end

main()
