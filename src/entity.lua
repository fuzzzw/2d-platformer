local object = require "classic"
local collision = require "collision"
local color = require "color"
local entity = object:extend()

function entity:new(obj)
  self.collision = obj.collision or collision()
  self.color     = obj.color or color()
end

return entity
