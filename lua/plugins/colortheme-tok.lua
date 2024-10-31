return {
	"folke/tokyonight.nvim",
	priority = 1000,
	opts = function()
		return {
			transparent = true,
			styles = {
				comments = { italic = true },
				keywords = { italic = false },
				functions = { bold = false },
				variables = { italic = false },
				sidebars = "transparent",
				floats = "transparent",
			},
		}
	end,

	init = function()
		vim.cmd("colorscheme tokyonight-night")
	end,
}
