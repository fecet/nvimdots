return function()
	vim.g.wildfire_objects = {
		["*"] = { "iw", "i'", 'i"', "i)", "i]", "i}", "if", "af", "ic", "ac" },
		["html,xml"] = { "it", "at" },
		["tex,markdown,rmd"] = { "iw", "i'", 'i"', "i)", "i]", "i}", "id", "i$" },
	}
end
