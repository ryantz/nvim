return {
	"thallada/farout.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("farout").setup({
			style = "night",
			styles = {
				functions = { bold = false },
				keywords = { italic = false, bold = false },
				variables = { italic = false, bold = false },
				comments = { italic = false, bold = false },
				sidebars = "dark",
				floats = "transparent",
			},

			-- Change the "hint" color to the "orange" color, and make the "error" color bright red
			on_colors = function(colors)
				colors.hint = colors.orange
				colors.error = "#ff0000"
			end,

			-- Override specific highlight groups to preserve colors for plugins
			on_highlights = function(highlights, colors)
				-- todo-comments.nvim highlight groups
				highlights.TodoFgTODO = { bg = "#00ff00" } -- Green for TODO
				highlights.TodoFgFIX = { bg = "#ff0000" } -- Red for FIX
				highlights.TodoFgHACK = { bg = "#ffff00" } -- Yellow for HACK
				highlights.TodoFgWARN = { bg = "#ff8800" } -- Orange/Yellow for WARN
				highlights.TodoFgPERF = { bg = "#8800ff" } -- Purple for PERF
				highlights.TodoFgNOTE = { bg = "#0088ff" } -- Blue for NOTE
			end,
		})
		vim.cmd.colorscheme("farout-night")
	end,
}
