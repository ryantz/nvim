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
		vim.opt_local.cinoptions = vim.opt_local.cinoptions + "(0"
	end,
})

-- packages
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	--require("plugins.color-lack"),
	--require("plugins.color-far"),
	require("plugins.color-falcon"),
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
	require("plugins.trouble"),
	require("plugins.rendermd"),
})

vim.cmd("highlight StatusLineFileType guibg=none")
vim.cmd("highlight StatusLineGitUser guifg=#F1502F")
vim.cmd("highlight StatusLineGitBranch guifg=#ffffff")
vim.cmd("highlight StatusLine guifg=#ffffff guibg=#000000")
vim.cmd("highlight ModeMsg guifg=#ffffff")
vim.cmd("highlight StatusLineMod guifg=#000000")
vim.cmd("highlight netrwDir guifg=#ffaa11")

-- Function to check if the file has uncommitted changes
function Git_uncommitted()
	local file = vim.fn.expand("%")
	if vim.fn.system("git status --porcelain " .. file) ~= "" then
		vim.cmd("highlight StatusLineUncommitted guifg=#ff0000") -- Red color for uncommitted files
		return " Not Commited " -- Red dot if uncommitted
	end
	vim.cmd("highlight StatusLineUncommitted guifg=#00ff00") -- Red color for uncommitted files
	return " Commited " -- Green dot if committed
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

function FileModified()
	if vim.bo.modified then
		vim.cmd("highlight StatusLineMod guifg=#ff0000") -- Red color for uncommitted files
		return " Not Saved "
	else
		vim.cmd("highlight StatusLineMod guifg=#00ff00") -- Red color for uncommitted files
		return " Saved "
	end
end

-- Your existing statusline configuration, updated to use the new icon function
vim.opt.statusline = "%#StatusLine#"
	.. "  %F                                " -- File name
	.. "%#StatusLineFileType#"
	.. "%#StatusLine#"
	.. "%#StatusLineMod#"
	.. " %{luaeval('FileModified()')} " -- Modified flag
	.. "%#StatusLine#"
	.. " <"
	.. "%#StatusLineUncommitted#"
	.. "%{luaeval('Git_uncommitted()')}" -- Correct Lua function call
	.. "%#StatusLine#"
	.. "> "
	.. "%#StatusLine#"
	.. "%s " -- Readonly flag
	.. "%=" -- Right align
	.. "%Y  " -- File type icon and type
	.. "%#StatusLineGitUser#"
	.. " %{luaeval('GitUser()')}"
	.. "%#StatusLine#"
	.. "%#StatusLineGitBranch#"
	.. " %{FugitiveHead()}" -- Git branch (Fugitive)
	.. "%#StatusLine#"
	.. "  line %l/%L " -- Percentage through the file

-- Preserve status line colors after changing background
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		-- Re-apply your custom highlights after colorscheme change
		vim.cmd("highlight StatusLineFileType guibg=none")
		vim.cmd("highlight StatusLineGitUser guifg=#F1502F")
		vim.cmd("highlight StatusLineGitBranch guifg=#ffffff")
		vim.cmd("highlight StatusLine guifg=#ffffff guibg=#000000")
		vim.cmd("highlight ModeMsg guifg=#ffffff")
		vim.cmd("highlight StatusLineMod guifg=#ff0000")
		vim.cmd("highlight netrwDir guifg=#ffaa11")

		-- Re-apply the function to check for uncommitted changes
		vim.cmd(
			"highlight StatusLineUncommitted guifg="
				.. (vim.fn.system("git status --porcelain " .. vim.fn.expand("%")) ~= "" and "#ff0000" or "#00ff00")
		)
		--vim.api.nvim_set_hl(0, "Visual", { bg = "#3a3a3a", fg = "#ECD98A" })
	end,
})

local function create_side_terminal()
	-- Open a vertical split on the right side
	vim.cmd("vertical rightbelow new")

	-- Get the current window
	local window = vim.api.nvim_get_current_win()
	local buffer = vim.api.nvim_create_buf(false, true)

	-- Set the buffer for the window
	vim.api.nvim_win_set_buf(window, buffer)

	-- Set window width to half the screen
	vim.api.nvim_win_set_width(window, math.floor(vim.o.columns * 0.5))

	-- Open terminal in the buffer
	vim.fn.termopen(vim.o.shell)

	-- Set buffer and window options
	vim.api.nvim_set_option_value("buflisted", false, { buf = buffer })

	-- Start in insert mode
	vim.cmd("startinsert")

	return {
		buffer = buffer,
		window = window,
	}
end

-- Global variable to track terminal state
local terminal = nil

function ToggleSideTerminal()
	-- If terminal is already open, close it
	if terminal and vim.api.nvim_win_is_valid(terminal.window) then
		vim.api.nvim_win_close(terminal.window, true)
		vim.api.nvim_buf_delete(terminal.buffer, { force = true })
		terminal = nil
		return
	end

	-- Create new side terminal
	terminal = create_side_terminal()
end

-- Map <leader>tt to toggle side terminal
vim.api.nvim_set_keymap("n", "<leader>tt", ":lua ToggleSideTerminal()<CR>", { noremap = true, silent = true })

-- Optional: Exit terminal mode with Esc
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { buffer = true })
	end,
})
