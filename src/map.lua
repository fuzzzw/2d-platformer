local Object = require "classic"
local Map = Object:extend()

function Map:new(obj)  -- The constructor
  if type(obj) ~= "table" then
    obj = {}
  end

  self.entities = obj.entities or nil
  self.x    = obj.x or 0
  self.y    = obj.y or 0
end

return Map
