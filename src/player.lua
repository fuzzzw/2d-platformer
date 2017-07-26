local collision = require "collision"
local player = collision:extend()

function player:new(obj)  -- The constructor
  player.super.new(self,obj)
  self.speed       = obj.speed or 200
  self.y_velocity  = obj.y_velocity or 0
  self.jump_height = obj.jump_height or -400
  self.gravity     = obj.gravity or -1000
  self.ground      = obj.ground or love.graphics.getHeight()
end

return player
