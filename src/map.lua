local Object = require "classic"
local Map = Object:extend()

function Map:new(obj)  -- The constructor
  if type(obj) ~= "table" then
    obj = {}
  end

  self.entities = obj.entities or nil
end

return Map
