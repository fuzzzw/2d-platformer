require "collision"
entity = {}
box = {}
box2 = {}
box3 = {}
platform = {}
player = {}

function love.load()
  box.width = 100
  box.height = 50
  box.x = love.graphics.getWidth() / 2 + 75
  box.y = love.graphics.getHeight() / 2 - box.height
  box.coll = Collision:new(box.x,box.y,box.width,box.height)
  entity[#entity+1] = box

  box2.width = 200
  box2.height = 100
  box2.x = love.graphics.getWidth() / 2 + 350
  box2.y = love.graphics.getHeight() / 2 - box2.height
  box2.coll = Collision:new(box2.x,box2.y,box2.width,box2.height)
  entity[#entity+1] = box2

  box3.width = 100
  box3.height = 50
  box3.x = love.graphics.getWidth() / 2 + 175
  box3.y = love.graphics.getHeight() / 2 - box3.height
  box3.coll = Collision:new(box3.x,box3.y,box3.width,box3.height)
  entity[#entity+1] = box3

	platform.width = love.graphics.getWidth()
	platform.height = love.graphics.getHeight() * 1.0
	platform.x = 0
	platform.y = platform.height / 2
  platform.coll = Collision:new(platform.x,platform.y,platform.width,platform.height)
  entity[#entity+1] = platform

  player.width = 32
  player.height = 32
	player.x = love.graphics.getWidth() / 2
	player.y = love.graphics.getHeight() / 2 - player.height
	player.speed = 200
	player.ground = platform.y
	player.y_velocity = 0
	player.jump_height = -400
	player.gravity = -1000
  player.coll = Collision:new(player.x,player.y,player.width,player.height)

end

function collision_evaluation(ent)
  if player.coll:check_collision(ent.coll) then
    local approx_y = 10

    if player.coll:ground_collision(ent.coll, player.y_velocity, approx_y) then
      player.y_velocity = 0
      player.y = ent.y - player.height + 1
    end
  else
    if not love.keyboard.isDown('space') and
       player.y_velocity == 0 then
      player.y_velocity = 1
    end
  end
end

function love.update(dt)

  local approx_x = 5
  -- collision checks
  for _, ent in ipairs(entity) do
    collision_evaluation(ent)
  end

	if love.keyboard.isDown('right') then
		if player.x < (love.graphics.getWidth() - player.width) then
      local blocked = false
      for _, ent in ipairs(entity) do
        if player.coll:right_collision(ent.coll, approx_x) then
          blocked = true
          break
        end
      end
      if not blocked then
        player.x = player.x + (player.speed * dt)
      end
		end
	elseif love.keyboard.isDown('left') then
    local blocked = false
    for _, ent in ipairs(entity) do
      if player.coll:left_collision(ent.coll, approx_x) then
        blocked = true
        break
      end
    end
    if not blocked then
  		if player.x > 0 then
  			player.x = player.x - (player.speed * dt)
  		end
    end
	end

	if love.keyboard.isDown('space') then
		if player.y_velocity == 0 then
			player.y_velocity = player.jump_height
		end
	end

	if player.y_velocity ~= 0 then
		player.y = player.y + player.y_velocity * dt
		player.y_velocity = player.y_velocity - player.gravity * dt
	end

	if player.y > player.ground then
		player.y_velocity = 0
    player.y = player.ground
	end

  --update player collision
  player.coll:setX(player.x)
  player.coll:setY(player.y)
  player.coll:setW(player.width)
  player.coll:setH(player.height)
end

function love.draw()
	love.graphics.setColor(255, 255, 255)

  --debug
  love.graphics.print( "x:"..math.floor(player.x)..", y:"..math.floor(player.y), 0, 0)
  --love.graphics.print("player.collision: "..collision_text, 0, 10)
  love.graphics.print("player.y_velocity: "..math.floor(player.y_velocity), 0, 15)
  --love.graphics.print("debuf something: ", 0, 40)

  love.graphics.rectangle('fill', platform.x, platform.y, platform.width, platform.height)
  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle('fill', box.x, box.y, box.width, box.height)
  love.graphics.rectangle('fill', box2.x, box2.y, box2.width, box2.height)
  love.graphics.setColor(255, 255, 0)
  love.graphics.rectangle('fill', box3.x, box3.y, box3.width, box3.height)
  love.graphics.setColor(0, 0, 255)
  love.graphics.rectangle('fill', player.x, player.y, player.width, player.height)
end
