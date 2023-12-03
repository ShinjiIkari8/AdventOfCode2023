local puzzleInput = require(script.puzzleInput)

local partOneExampleInput = [[
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green]]

local Color = { red = "red", green = "green", blue = "blue" }

-- Parsing
local games = {}
for i, line in puzzleInput:split("\n") do
	local trimmed = line:split(":")[2]

	local sets = trimmed:split(";")
	
	games[i] = {}
	for j, set in sets do
		games[i][j] = {}
		local cubes = set:split(",")

		for k, cube in cubes do
			games[i][j][k] = {}
			
			local noSpacesCube = cube:gsub(" ", "", 1)
			local words = noSpacesCube:split(" ")

			games[i][j][k].amount = tonumber(words[1])
			games[i][j][k].color = words[2]
		end
	end
end

-- Part 1
-- what is the fewest number of cubes of each color that
-- could have been in the bag to make this game possible?

local thisGame = { [Color.red] = 12, [Color.green] = 13, [Color.blue] = 14 }

local sum = 0
for i, game_ in games do
	local isPossible = true

	for _, set in game_ do
		if not isPossible then
			break
		end
		
		for _, cube in set do
			if cube.amount > thisGame[cube.color] then
				isPossible = false
				break
			end
		end
	end
	
	if isPossible then
		sum += i
	end
end
print(sum)

-- Part 2
-- Find the greatest of each color in each game
local sum = 0
for i, game_ in games do
	local maxes = {[Color.red] = 0, [Color.green] = 0, [Color.blue] = 0}
	for _, set in game_ do
		for _, cube in set do
			if cube.color == Color.red and cube.amount > maxes[Color.red] then
				maxes[Color.red] = cube.amount
			elseif cube.color == Color.green and cube.amount > maxes[Color.green] then
				maxes[Color.green] = cube.amount
			elseif cube.color == Color.blue and cube.amount > maxes[Color.blue] then
				maxes[Color.blue] = cube.amount
			end
		end
	end

	sum += maxes[Color.red] * maxes[Color.green] * maxes[Color.blue]
end
print(sum)
