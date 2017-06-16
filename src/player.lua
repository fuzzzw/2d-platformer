local collision = require "collision"
local player = {}

function player.load()
  local player = {}
  player.width = 32
  player.height = 32
  player.x = 10
  player.y = 300
  player.speed = 200
  player.ground = love.graphics.getHeight() - player.height
  player.y_velocity = 0
  player.jump_height = -400
  player.gravity = -1000
  player.coll = collision:new(
    player.x,
    player.y,
    player.width,
    player.height
  )
  player.color = {
    red   = 0,
    green = 0,
    blue  = 255
  }

  return player
end

return player
