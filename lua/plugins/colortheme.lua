return {
	--	"rose-pine/neovim",
	--	name = "rose-pine",
	--	config = function()
	--		require("rose-pine").setup({
	--			variant = "main",
	--			dim_inactive_windows = true,
	--			styles = {
	--				bold = false,
	--				italic = false,
	--			},
	--		})
	--		vim.cmd("colorscheme rose-pine")
	--	end,
	"EdenEast/nightfox.nvim",
	name = "nightfox",
	config = function()
		vim.cmd("colorscheme nightfox")
	end,
}
