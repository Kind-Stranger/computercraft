-- /lib/general/arrutils.lua --

local function slice(arr, s, e)
  --[[ Return sub-array from index
       `s` to `e` inclusive
  ]]--
  if s<1 or e>#arr then return arr end
  local sub = {}
  for i=s, e do
    table.insert(sub, arr[i])
  end
  return sub
end

local function equal(arr1, arr2)
  --[[ Returns true if arrays input are equal ]]--
  return table.concat(arr1) == table.concat(arr2)
end

return {
  slice=slice,
  equal=equal,
}