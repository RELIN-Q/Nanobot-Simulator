-- @ScriptType: ModuleScript
--local NanoForms = {}

--function NanoForms.GenerateDynamicCircle(count)
--	if count < 1 then return {} end

--	local minSpacing = 4        -- Minimum spacing between bots
--	local baseRadius = 2        -- Radius for 1 bot
--	local spacingFactor = 1.1   -- Increase radius per bot (scales gradually)
--	local verticalHeight = 3    -- Total height the circle will rise (adjust as needed)
	
--	local radius = baseRadius + (count * spacingFactor)
	
--	local formation = {}
--	for i = 0, count - 1 do
--		local angle = (2 * math.pi / count) * i
--		local x = math.cos(angle) * radius
--		local z = math.sin(angle) * radius
--		local y = 0
--		if count > 1 then
--			y = i * (verticalHeight / (count - 1))
--		end
--		table.insert(formation, Vector3.new(x, y, z))
--	end
--	for i = 1, #formation do
--		formation[i] = formation[i] + Vector3.new(0, verticalHeight/2, 0)
--	end
	
--	return formation
--end

---- Tool-specific generator functions
--NanoForms.Formations = {
--	["Scooper"] = NanoForms.GenerateDynamicCircle,
--	-- Add more tools and formation generators as needed
--}

---- Universal accessor: returns local offsets for the formation
--function NanoForms.GetFormation(toolName, count)
--	local generator = NanoForms.Formations[toolName]
--	if generator then
--		return generator(count)
--	else
--		return {} -- fallback if tool isn't mapped
--	end
--end

---- Given a referenceCFrame (primary nanobot's CFrame), return world positions for the formation
----function NanoForms.GetWorldFormationPositions(toolName, count, referenceCFrame)
----	local localOffsets = NanoForms.GetFormation(toolName, count)
----	local worldPositions = {}
----	for i = 1, #localOffsets do
----		-- Place each nanobot at the offset relative to the referenceCFrame (primary nanobot)
----		local worldPos = referenceCFrame:ToWorldSpace(CFrame.new(localOffsets[i])).Position
----		table.insert(worldPositions, worldPos)
----	end
----	return worldPositions
----end

--return NanoForms