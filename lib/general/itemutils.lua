-- /lib/general/itemutils.lua --
local stringU = require("lib.general.stringutils")

local function getSimpleName(item)
  --[[ Get basic item name from block or item data
    {.., "name":"minecraft:fence"} -> "fence"
  ]]--
  return stringU.getSubAfterChar(item.name, ":")
end

return{
  getSimpleName = getSimpleName,
}