box = {}
platform = {}
player = {}

function check_collision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function love.load()
  box.width = 100
  box.height = 50

  box.x = love.graphics.getWidth() / 2 + 75
  box.y = love.graphics.getHeight() / 2 - box.height

	platform.width = love.graphics.getWidth()
	platform.height = love.graphics.getHeight()

	platform.x = 0
	platform.y = platform.height / 2

  player.width = 32
  player.height = 32

	player.x = love.graphics.getWidth() / 2
	player.y = love.graphics.getHeight() / 2 - player.height

	player.speed = 200

	player.ground = player.y

	player.y_velocity = 0

	player.jump_height = -400
	player.gravity = -1000

  player.collision = false
  player.blocked_R = false
  player.blocked_L = false
end

function love.update(dt)
  if check_collision(player.x, player.y, player.width, player.height,
                     box.x, box.y, box.width, box.height) then
    player.collision = true
    local approx_y = 10
    local approx_x = 5

    if player.y < (box.y - player.height + approx_y) and
       player.y > (box.y - player.height - approx_y) then

      player.y_velocity = 0
      player.y = box.y - player.height + 2
      player.blocked_R = false
      player.blocked_L = false
    elseif player.x > (box.x - player.width - approx_x) and
           player.x < (box.x - player.width + approx_x) then
      player.blocked_R = true
    elseif player.x > (box.x + box.width - approx_x) and
           player.x < (box.x + box.width + approx_x) then
      player.blocked_L = true
    end
  else
    if player.collision and not love.keyboard.isDown('space') then
      player.y_velocity = 1
    end
    player.collision = false
    player.blocked_R = false
    player.blocked_L = false
  end

	if love.keyboard.isDown('right') then
		if player.x < (love.graphics.getWidth() - player.width) and not player.blocked_R then
			player.x = player.x + (player.speed * dt)
		end
	elseif love.keyboard.isDown('left') and not player.blocked_L then
		if player.x > 0 then
			player.x = player.x - (player.speed * dt)
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
end

function love.draw()
  local collision_text = "false"
  if player.collision then
    collision_text = "true"
  end
	love.graphics.setColor(255, 255, 255)

  love.graphics.print( "x:"..math.floor(player.x)..", y:"..math.floor(player.y), 0, 0)
  love.graphics.print("player.collision: "..collision_text, 0, 10)
  love.graphics.print("box.x: "..box.x, 0, 20)
  --love.graphics.print("player.y_velocity: "..math.floor(player.y_velocity), 0, 20)

  love.graphics.rectangle('fill', platform.x, platform.y, platform.width, platform.height)
  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle('fill', box.x, box.y, box.width, box.height)
  love.graphics.setColor(0, 0, 255)
  love.graphics.rectangle('fill', player.x, player.y, player.width, player.height)
end
