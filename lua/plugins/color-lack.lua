return {
	"slugbyte/lackluster.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local lackluster = require("lackluster")
		local color = lackluster.color

		lackluster.setup({
			tweak_background = {
				normal = "default", -- main background
				--normal = "none", -- transparent
				--normal = "#002b36", -- hexcode
				-- normal = color.green,    -- lackluster color
				telescope = "default", -- telescope
				menu = "default", -- nvim_cmp, wildmenu ... (bad idea to transparent)
				popup = "default", -- lazy, mason, whichkey ... (bad idea to transparent)
			},

			disable_plugin = {
				todo_comments = false,
				trouble = true,
			},
		})
		vim.api.nvim_set_hl(0, "Visual", { bg = "#5555ff", fg = "NONE" })

		-- Override the highlight groups
		vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "#363636" }) -- For reference highlighting
		vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "#363636" })
		vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "#363636" })

		--vim.cmd.colorscheme("lackluster-night")
		vim.cmd.colorscheme("lackluster-hack")
		-- vim.cmd.colorscheme("lackluster-mint")
	end,
}
