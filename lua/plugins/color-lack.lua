-- example lazy.nvim install setup
return {
	"slugbyte/lackluster.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		--vim.cmd.colorscheme("lackluster-night")
		vim.cmd.colorscheme("lackluster-hack")
		-- vim.cmd.colorscheme("lackluster-mint")
	end,
}
