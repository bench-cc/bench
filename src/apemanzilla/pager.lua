local pagerlib = require "pagerlib.lua"

local args = {...}

if #args < 1 then
	print("Usage:")
	print("pager <file>")
	return
end

local file = shell.resolve(args[1])
if not fs.exists(file) then
	printError("File does not exist")
	return
elseif fs.isDir(file) then
	printError("Path is directory")
	return
end

local f = fs.open(file, "r")
local d = f.readAll()
f.close()

pagerlib.scroll(d)

os.queueEvent("fake")
while os.pullEvent() ~= "fake" do end
