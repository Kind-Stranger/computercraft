-- /lib/general/stringutils.lua --

local function getSubAfterChar(s, chr)
  --[[ example:
    getSubAfterChar("minecraft:sand", ":")
      -> "sand"
  ]]--
  local pos, posEnd = string.find(s, chr)
  if not pos then return s end
  return string.sub(s, posEnd+1, string.len(s))
end

return {
  getSubAfterChar = getSubAfterChar,
}