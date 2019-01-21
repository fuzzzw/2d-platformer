local Object = require "classic"
local Collision = require "collision"
local Color = require "color"
local Entity = Object:extend()

function Entity:new(obj)
  if type(obj) ~= "table" then
    obj = {}
  end

  self.collision  = obj.collision or Collision()
  self.color      = obj.color or Color()
  self.script     = obj.script or nil
  self.block      = obj.block or false
  self.updateable = obj.updateable or nil
  self.time       = obj.time or 0
end

function Entity:iTime()
  self.time = self.time + 1
end

return Entity
