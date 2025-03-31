return {
	"fenetikm/falcon",
	config = function()
		-- Set colorscheme first
		vim.cmd.colorscheme("falcon")

		-- Function to remove italics while preserving colors
		local function remove_italics(group)
			local hl = vim.api.nvim_get_hl(0, { name = group, link = false }) -- Get current highlight
			hl.italic = false -- Disable italics
			vim.api.nvim_set_hl(0, group, hl) -- Reapply with italics removed
		end

		-- Remove italics from commonly affected groups
		local groups = { "Comment", "Function", "Identifier", "Keyword", "Statement", "Type" }
		for _, group in ipairs(groups) do
			remove_italics(group)
		end
	end,
}
