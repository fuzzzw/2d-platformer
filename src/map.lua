local Object = require "classic"
local Map = Object:extend()

function Map:new(obj)  -- The constructor
  if type(obj) ~= "table" then
    obj = {}
  end

  self.levels   = obj.levels or nil
  self.level_x  = obj.level_x or nil
  self.level_y  = obj.level_y or nil
end

return Map
