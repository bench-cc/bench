return repo {
	package {
		name = "hello-lib",
		description = "An example library that exports a single function",
		version = 1.0,
		author = "apemanzilla",
		files = {
			["init.lua"] = "raw:return function() print('hello world') end"
		}
	},
	package {
		name = "hello",
		version = 1.0,
		author = "apemanzilla",
		depends = { "hello-lib" },
		files = {
			["hello.lua"] = "raw:require('hellolib')()"
		},
		launch = "hello.lua"
	}
}