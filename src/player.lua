local Collision = require "collision"
local Player = Collision:extend()

function Player:new(obj)  -- The constructor
  if type(obj) ~= "table" then
    obj = {}
  end

  Player.super.new(self,{
    x = obj.x or 10,
    y = obj.y or 300,
    w = obj.w or 30,
    h = obj.h or 30
  })

  self.speed       = obj.speed or 200
  self.y_velocity  = obj.y_velocity or 0
  self.jump_height = obj.jump_height or -300
  self.gravity     = obj.gravity or -1000
  self.dead        = obj.dead or false
  self.spawn_x     = obj.spawn_x or 300
  self.spawn_y     = obj.spawn_y or 20
  self.map_spawn_x = obj.map_spawn_x or 0
  self.map_spawn_y = obj.map_spawn_y or 0
  self.respawn     = obj.respawn or false

end

function Player:update_y(dt)
  if self.dead then
    return
  end

  if self.y_velocity == 0 then
    if love.keyboard.isDown('w', 'up', 'space') then
      self.y_velocity = self.jump_height
    else
      self.y_velocity = 50
    end
  end



  if self.y_velocity ~= 0 then
    self.y = self.y + self.y_velocity * dt
    self.y_velocity = self.y_velocity - self.gravity * dt
  end
end

function Player:update_x(dt)
  if self.dead then
    return
  end

  if love.keyboard.isDown('d', 'right') then
    self.x = self.x + (self.speed * dt)
  elseif love.keyboard.isDown('a', 'left') then
    self.x = self.x - (self.speed * dt)
  end
end

function Player:update_other()
  -- Respawn
  if love.keyboard.isDown('r') then
    self.x = self.spawn_x
    self.y = self.spawn_y
    self.respawn = true
    self.dead = false
  end
end

return Player
