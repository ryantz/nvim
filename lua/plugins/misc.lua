-- Standalone plugins with less than 10 lines of config go here
return {
	{
		-- autoclose tags
		"windwp/nvim-ts-autotag",
	},

	{
		-- detect tabstop and shiftwidth automatically
		"tpope/vim-sleuth",
	},

	{
		-- Powerful Git integration for Vim
		"tpope/vim-fugitive",
	},

	{
		-- GitHub integration for vim-fugitive
		"tpope/vim-rhubarb",
	},

	{
		-- Autoclose parentheses, brackets, quotes, etc.
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
	},

	{
		-- high-performance color highlighter
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	{
		"shortcuts/no-neck-pain.nvim",
		config = true,
	},
}
