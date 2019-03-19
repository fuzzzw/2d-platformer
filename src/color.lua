local Object = require "classic"
local Color = Object:extend()

function Color:new(obj)  -- The constructor
  if type(obj) ~= "table" then
    obj = {}
  end

  self.r = toFloat(obj.r) or 0 -- r red
  self.g = toFloat(obj.g) or 0 -- g green
  self.b = toFloat(obj.b) or 0 -- b blue
end


function toFloat(color)
  return color/255
end

return Color
