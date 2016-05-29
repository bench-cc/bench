local stringutils = {}

function stringutils.lines(text)
	expect(text, "string", 1)
	if text:sub(-1) ~= "\n" then text = text .. "\n" end
	local lines = {}
	for line in text:gmatch("(.-)\n") do
		table.insert(lines, line)
	end
	return lines
end

function stringutils.wrapLines(text, width)
	expect(text, "string", 1)
	expect(width, "number", 2)
	local split = stringutils.lines(text)
	local lines = {}
	for _, line in ipairs(split) do
		local l = ""
		for word in line:gmatch("(%S+)") do
			if #word + #l + 1 > width then
				table.insert(lines, l)
				l = word
			else
				if l == "" then l = word else l = l .. " " .. word end
			end
		end
		table.insert(lines, l)
	end
	return lines
end

stringutils.longtext = "this is a really long string, i hope it gets wrapped properly.\nit also has a couple\n\nnew\nlines"

return stringutils
