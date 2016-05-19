local colorhex = {}

for k, v in pairs(colors) do
	if type(v) == "number" then
		colorhex[k] = ("%x"):format(math.log(v) / math.log(2))
	end
end

function colorhex.unhex(h)
	expect(h, "string", 1)
	local n = tonumber(h, 16)
	if not n then error("invalid color", 2) end
	return 2 ^ n
end

return colorhex
