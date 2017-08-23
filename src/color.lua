local Object = require "classic"
local Color = Object:extend()

function Color:new(obj)  -- The constructor
  self.r = obj.r or 0 -- r red
  self.g = obj.g or 0 -- g green
  self.b = obj.b or 0 -- b blue
end

return Color
