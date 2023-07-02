-- /lib/farm/croputils.lua --
local itemU = require("lib.general.itemutils")
local invU = require("lib.general.inventoryutils")

local cropToSeed = {
  wheat = "wheat_seeds",
  beetroot = "beetroot_seeds",
  potato = "potato",
  carrot = "carrot",
  pumpkin = -1, -- do not replant pumpkins
  melon = -1, --do not replant melon
}

local function isMature(block)
  --[[ Check if crop is ripe for harvesting
    Returns false if `block` is not a crop
  ]]--
  local name = itemU.getSimpleName(block)
  if name == "wheat" or
     name == "potato" or
     name == "carrot"
  then
    return block.state.age == 7
  elseif name == "beetroot" then
    return block.state.age == 3
  else
    -- No age check required --
    return name == "melon" or
           name == "pumpkin"
  end
end

local function setSeedSlot(block)
  local seedSlot
  local cropName = itemU.getSimpleName(block)
  local seedName = cropToSeed[cropName]
  if seedName == nil then
    return nil, "Unrecognised crop"
  elseif seedName == -1 then
    return nil, "Replant not required"
  end
  seedSlot = invU.scanFor(seedName)
  return seedSlot, seedName
end

return {
  cropToSeed = cropToSeed,
  isMature = isMature,
  setSeedSlot = setSeedSlot,
}