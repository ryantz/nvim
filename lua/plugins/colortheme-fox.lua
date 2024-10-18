return {
	"EdenEast/nightfox.nvim",
	name = "nightfox",
	config = function()
		require("nightfox").setup({
			options = {
				styles = {
					comments = "italic",
					keywords = "NONE",
					types = "italic,bold",
				},
			},
		})
		vim.cmd("colorscheme nightfox")
		vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#ff0000", bg = "#1c1c1c" }) -- Customize colors
		vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#ffa500", bg = "#1c1c1c" })
		vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#0000ff", bg = "#1c1c1c" })
		vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#00ff00", bg = "#1c1c1c" })
	end,
}
