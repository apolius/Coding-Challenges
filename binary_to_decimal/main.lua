-- #119 Binary to Decimal Conversion - Karim Jerbi(@apolius)

function love.load()
	love.window.setTitle("Binary to Decimal Conversion")
	width, height = love.graphics.getDimensions()
	love.graphics.setDefaultFilter('nearest')
	bits = '11111111'
	r = 255

	function convert(bits)
		local r = 0
		for i=1,8 do
			if string.reverse(bits):sub(i,i) == '1' then
				r = r + 2^(i-1)
			end
		end
		return r
	end

	x,y = love.mouse.getPosition()

	function clicked(x,y,cx)
		-- check if the mouse has clicked a bit which x's = cx
		return (x - cx)^2 + (y - 100)^2 < 25^2 and love.mouse.isDown(1)
	end

	function flip(bits,x)
		local bit = bits:sub(x,x)
		if bit == '1' then bit = '0' else bit = '1' end
		-- generate a new byte with the new bit
		-- based on the position of the new bit
		-- there are 3 positions: 
		-- start / end \ inside
		if x == 1 then
			return bit .. bits:sub(2,-1)
		elseif x == bits:len() then
			return bits:sub(1,-2)..bit
		else
			return bits:sub(1,x-1)..bit..bits:sub(x+1,-1)
		end
	end
end

function love.update(dt)
	x,y = love.mouse.getPosition()
	for i=1,8 do
		if clicked(x,y,20+(i*55))then
			bits = flip(bits,i)
			r = convert(bits)
			love.timer.sleep(0.12)
		end
	end
end

function love.draw()
	love.graphics.clear(0.6,0.5,0.75)
	for i=1,8 do
		if bits:sub(i,i) == '1' then
			love.graphics.setColor(1,1,1)
			love.graphics.ellipse('fill',20+(i*55),100,25,25)
		end
		love.graphics.ellipse('line',20+(i*55),100,25,25)
	end
	love.graphics.print(r,width/4,height/4,0,8,8)
end