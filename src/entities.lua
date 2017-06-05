entity = {}

local function loadCustomEntities()
  boxt = {}
  boxt.coll = Collision:new(
    love.graphics.getWidth() / 2 - 500,
    love.graphics.getHeight() / 2 + 250,
    200,
    50
  )
  entity[#entity+1] = boxt

  box = {}
  box.coll = Collision:new(
    200,
    500,
    5,
    50
  )
  entity[#entity+1] = box

  box2 = {}
  box2.coll = Collision:new(
    215,
    500,
    5,
    50
  )
  entity[#entity+1] = box2

  box3 = {}
  box3.coll = Collision:new(
    love.graphics.getWidth() / 2 + 65,
    love.graphics.getHeight() / 2 + 90,
    5,
    50
  )
  entity[#entity+1] = box3

  box4 = {}
  box4.coll = Collision:new(
    love.graphics.getWidth() / 2 + 150,
    love.graphics.getHeight() / 2 + 90,
    5,
    50
  )
  entity[#entity+1] = box4
end

function loadEntities()
  --loadCustomEntities()
  platform = {}
  local scale = 1.95
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
  player.x = love.graphics.getWidth() / 2 - 375
  player.y = love.graphics.getHeight() / 2 - player.height - 150
  player.speed = 200
  player.ground = platform.coll:getY()
  player.y_velocity = 0
  player.jump_height = -400
  player.gravity = -1000
  player.coll = Collision:new(player.x,player.y,player.width,player.height)
end
