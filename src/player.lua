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
  self.jump_height = obj.jump_height or -400
  self.gravity     = obj.gravity or -1000
  self.dead        = obj.dead or false
  self.spawn_x     = obj.spawn_x or 300
  self.spawn_y     = obj.spawn_y or 20
end

local function death(player)
  player.dead = true
end

local function y_axis_update(player,map,dt)
  if player.y_velocity == 0 then
    if love.keyboard.isDown('space') then
      player.y_velocity = player.jump_height
    else
      player.y_velocity = 1
    end
  end

  if player.y_velocity ~= 0 then
    player.y = player.y + player.y_velocity * dt
    player.y_velocity = player.y_velocity - player.gravity * dt
  end

  if player.y_velocity > 0 then
    local entity = player:check_entities(map.all)
    if entity then
      if player:check_entities(map.death) then
        death(player)
      else
        player.y_velocity = 0
        player.y = entity.collision.y - player.h
      end
    end
  elseif player.y_velocity < 0 then
    local entity = player:check_entities(map.all)
    if entity then
      if player:check_entities(map.death) then
        death(player)
      else
        player.y_velocity = 1
        player.y = entity.collision.y + entity.collision.h
      end
    end
  end
end

local function x_axis_update(player,map,dt)
  if love.keyboard.isDown('right') then
    player.x = player.x + (player.speed * dt)
    local entity = player:check_entities(map.all)
    if entity then
      if player:check_entities(map.death) then
        death(player)
      else
        player.x = entity.collision.x - player.w
      end
    end
  elseif love.keyboard.isDown('left') then
    player.x = player.x - (player.speed * dt)
    local entity = player:check_entities(map.all)
    if entity then
      if player:check_entities(map.death) then
        death(player)
      else
        player.x = entity.collision.x + entity.collision.w
      end
    end
  end
end

function Player:update(map,dt)
  if not self.dead then
    y_axis_update(self,map,dt)
    x_axis_update(self,map,dt)
  end

  if love.keyboard.isDown('r') then
    self.x = self.spawn_x
    self.y = self.spawn_y
    self.dead = false
  end
end

return Player
