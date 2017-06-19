local object = require "classic"
local collision = require "collision"
local color = require "color"
local entity = object:extend()

function entity:new(collision,color)
  self.collision = collision or collision()
  self.color     = color or color()
end

function entity:setCollision(collision)
  if collision:is(collision) then
    self.collision = collision
  end
end

function entity:setColor(color)
  if color:is(color) then
    self.color = color
  end
end

function entity:getCollision()
  return self.collision
end

function entity:getColor()
  return self.color
end

return entity
