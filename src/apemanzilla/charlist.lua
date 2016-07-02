local stringutils = require "stringutils"
local pager = require "pager"

local str = ""

for i = 32, 255 do
	str = str .. stringutils.fixLength(i .. ": " .. string.char(i), 6) .. (((i + 4) % 7 == 0 and "\n") or " ")
end

pager.scroll(str .. "\n")
