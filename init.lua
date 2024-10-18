require("core.keymaps")
require("core.options")
require("ryanConfig")
print("Welcome")

-- [[ Install `lazy.nvim` plugin manager ]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	-- insert files here to download

	--require("plugins.colortheme-rosepine")
	require("plugins.colortheme-fox"),
	require("plugins.neotree"),
	require("plugins.bufferline"),
	require("plugins.lualine"),
	require("plugins.treesitter"),
	require("plugins.telescope"),
	require("plugins.lsp"),
	require("plugins.autocompletion"),
	require("plugins.gitsigns"),
	require("plugins.indentlines"),
	require("plugins.autoformat"),
	require("plugins.greetingscreen"),
	require("plugins.undotree"),
})
