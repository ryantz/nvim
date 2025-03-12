require("core.keymaps")
require("core.options")

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

-- rust
vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.expandtab = true
	end,
})

vim.cmd("highlight StatusLineFileType guibg=none gui=bold")
vim.cmd("highlight StatusLineGitUser guifg=#F1502F gui=bold")
vim.cmd("highlight StatusLineGitBranch guifg=#ff0000 guibg=none gui=bold")
vim.cmd("highlight StatusLine guifg=#ffffff")
vim.cmd("highlight ModeMsg guifg=#ffffff")
vim.cmd("highlight StatusLineMod guifg=#ff0000")
--vim.cmd("highlight netrwDir guifg=#00ff99")

-- Function to check if the file has uncommitted changes
function Git_uncommitted()
	local file = vim.fn.expand("%")
	if vim.fn.system("git status --porcelain " .. file) ~= "" then
		vim.cmd("highlight StatusLineUncommitted guifg=#ff0000") -- Red color for uncommitted files
		return "  " -- Red dot if uncommitted
	end
	vim.cmd("highlight StatusLineUncommitted guifg=#00ff00") -- Red color for uncommitted files
	return "  " -- Green dot if committed
end

function GitUser()
	local handle = io.popen("git config --get user.name 2>/dev/null")
	if handle then
		local result = handle:read("*a")
		handle:close()
		return result:gsub("\n", "") or "No Git User"
	end
	return "No Git User"
end

-- Updated status line
vim.opt.statusline = "%#StatusLine#"
	.. "   %f " -- File name
	.. "%#StatusLineFileType#"
	.. "%y " -- File type
	.. "%#StatusLine#"
	.. "%#StatusLineMod#"
	.. " %m " -- Modified flag
	.. "%#StatusLine#"
	.. "%r " -- Readonly flag
	.. "%=" -- Right align
	.. "%#StatusLineGitUser#"
	.. "  %{luaeval('GitUser()')} "
	.. "%#StatusLine#"
	.. "| git:("
	.. "%#StatusLineGitBranch#"
	.. " %{FugitiveHead()}" -- Git branch (Fugitive)
	.. "%#StatusLine#"
	.. ")"
	.. "%#StatusLineUncommitted#"
	.. "%{luaeval('Git_uncommitted()')}" -- Correct Lua function call
	.. "%#StatusLine#"
	.. "| %l:%c | " -- Cursor position: line,col
	.. "%p%%  " -- Percentage through the file

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	require("plugins.color-lack"),
	require("plugins.treesitter"),
	require("plugins.telescope"),
	require("plugins.lsp"),
	require("plugins.autocompletion"),
	require("plugins.gitsigns"),
	require("plugins.indentlines"),
	require("plugins.autoformat"),
	require("plugins.undotree"),
	require("plugins.misc"),
	require("plugins.devicons"),
})
