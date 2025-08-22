return {
	"kristijanhusak/vim-hybrid-material",
	lazy = false,
	priority = 1000,
	config = function()
		vim.opt.background = "light"
		vim.cmd("colorscheme hybrid_reverse")
	end,
}
