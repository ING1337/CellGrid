-- CellGrid by ING
-- allows massive 3d entity management

class 'CellGrid'

function CellGrid:__init(cellSize, offsetX, offsetY)
	self.grid      = {}
	self.size      = cellSize or 100
	self.offsetX   = offsetX or -15000
	self.offsetY   = offsetY or -15000
end

-- #################################################################################################################################

function CellGrid:AddEntity(entity, position, radius)
	range = radius and (math.ceil(radius / self.size)) or 0
	x = math.max(1, math.floor((position.x - self.offsetX) / self.size - range))
	y = math.max(1, math.floor((position.z - self.offsetY) / self.size - range))
	
	for i = x, range * 2 + x, 1 do
		if self.grid[i] == nil then self.grid[i] = {} end
		for j = y, range * 2 + y, 1 do
			if self.grid[i][j] == nil then self.grid[i][j] = {} end
			table.insert(self.grid[i][j], entity)
		end
	end
end

function CellGrid:RemoveEntity(entity, position, radius)
	range = radius and (math.ceil(radius / self.size)) or 0
	x = math.max(1, math.floor((position.x - self.offsetX) / self.size - range))
	y = math.max(1, math.floor((position.z - self.offsetY) / self.size - range))
	
	for i = x, range * 2 + x, 1 do
		for j = y, range * 2 + y, 1 do
			for k, comp in ipairs(self.grid[i][j]) do
				if comp == entity then
					table.remove(self.grid[i][j], k)
					break
				end
			end
		end
	end
end

function CellGrid:GetCell(position)
	x = math.max(1, math.floor((position.x - self.offsetX) / self.size))
	y = math.max(1, math.floor((position.z - self.offsetY) / self.size))
	
	if not self.grid[x] then return nil end
	return self.grid[x][y]
end


