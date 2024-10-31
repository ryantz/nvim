return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({

			variant = "main",
			dim_inactive_windows = false,
			extend_background_behind_borders = false,
			styles = {
				transparency = true,
				bold = false,
				italic = false,
			},
		})
		vim.cmd("colorscheme rose-pine")
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end,
}
