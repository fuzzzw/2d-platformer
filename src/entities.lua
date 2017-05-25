entity = {}

function loadEntities()
  box = {}
  box.coll = Collision:new(
    love.graphics.getWidth() / 2 + 75,
    love.graphics.getHeight() / 2 - 50,
    100,
    50
  )
  entity[#entity+1] = box

  box2 = {}
  box2.coll = Collision:new(
    love.graphics.getWidth() / 2 + 350,
    love.graphics.getHeight() / 2 - 100,
    200,
    100
  )
  entity[#entity+1] = box2

  box3 = {}
  box3.coll = Collision:new(
    love.graphics.getWidth() / 2 + 175,
    love.graphics.getHeight() / 2 - 50,
    100,
    50
  )
  entity[#entity+1] = box3

  platform = {}
  local scale = 1.0
  platform.coll = Collision:new(
    0,
    (love.graphics.getHeight() * scale) / 2,
    love.graphics.getWidth(),
    love.graphics.getHeight() * scale
  )
  entity[#entity+1] = platform

  player = {}
  player.width = 32
  player.height = 32
  player.x = love.graphics.getWidth() / 2
  player.y = love.graphics.getHeight() / 2 - player.height
  player.speed = 200
  player.ground = platform.coll:getY()
  player.y_velocity = 0
  player.jump_height = -400
  player.gravity = -1000
  player.coll = Collision:new(player.x,player.y,player.width,player.height)
end
