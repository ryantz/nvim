return {
	"EdenEast/nightfox.nvim",
	name = "nightfox",
	config = function()
		require("nightfox").setup({
			options = {
				transparent = true,
				styles = {
					comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
					conditionals = "NONE",
					constants = "NONE",
					functions = "NONE",
					keywords = "NONE",
					numbers = "NONE",
					operators = "NONE",
					strings = "NONE",
					types = "NONE",
					variables = "NONE",
				},
			},
		})
		vim.cmd("colorscheme terafox")
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end,
}
