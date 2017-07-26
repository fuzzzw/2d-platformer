local object = require "classic"
local color = object:extend()

function color:new(obj)  -- The constructor
  self.r = obj.r or 0 -- r red
  self.g = obj.g or 0 -- g green
  self.b = obj.b or 0 -- b blue
end

return color
