-- if it's stupid but it works, it ain't stupid
local f = fs.open(shell.resolveProgram("lua"), "r")
local d = f.readAll()
f.close()

return load(d, "lua", nil, _ENV)(...)
