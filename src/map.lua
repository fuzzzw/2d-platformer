local Object = require "classic"
local Map = Object:extend()

function Map:new(obj)  -- The constructor
  if type(obj) ~= "table" then
    obj = {}
  end

  self.entities = obj.entities or nil
  self.spawn_x  = obj.spawn_x or nil
  self.spawn_y  = obj.spawn_y or nil
end

return Map
