-- /lib/farm/croputils.lua --
local itemU = require("lib.general.itemutils")

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

return {
  isMature = isMature,
}