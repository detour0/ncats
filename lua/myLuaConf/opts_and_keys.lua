local v = vim

-- NOTE: These 2 need to be set up before any plugins are loaded.
v.g.mapleader = " "
v.g.maplocalleader = " "

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
v.opt.list = true
v.opt.listchars = {
  trail = "￮",
  -- multispace = "￮", -- shows symbol in tab indentation at start of line
  extends = "▶",
  precedes = "◀",
  nbsp =
  "‿"
}

-- Search
v.opt.ignorecase = true    -- search case insensitive
v.opt.smartcase = true     -- search matters if capital letter
v.opt.inccommand = "split" -- splits screen to show all matches
v.opt.incsearch = true     -- Show search matches as you type
v.opt.hlsearch = true      -- Highlight all search matches

-- Tabs/Indents
v.opt.expandtab = true   -- Convert tabs to spaces
v.opt.tabstop = 2        -- Number of spaces that a tab represents
v.opt.softtabstop = 2    -- Number of spaces for tab operations (editing)
v.opt.shiftwidth = 2     -- Number of spaces for each indentation level
v.opt.smartindent = true -- auto-indent based on syntax of the code

-- Minimal number of screen lines to keep above and below the cursor.
v.opt.scrolloff = 10
-- Don't redraw screen while executing macros (improves performance)
v.opt.lazyredraw = true
-- Make line numbers default
v.wo.number = true

-- Enable mouse mode
v.o.mouse = "a"

-- Indent
-- vim.o.smarttab = true
v.opt.cpoptions:append("I")
v.o.expandtab = true
-- vim.o.smartindent = true
-- vim.o.autoindent = true
-- vim.o.tabstop = 4
-- vim.o.softtabstop = 4
-- vim.o.shiftwidth = 4

-- stops line wrapping from being confusing
v.o.breakindent = true

-- Save undo history
v.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
v.o.ignorecase = true
v.o.smartcase = true

-- Keep signcolumn on by default
v.wo.signcolumn = "yes"
v.wo.relativenumber = true

-- Decrease update time
v.o.updatetime = 250
v.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
v.o.completeopt = "menu,preview,noselect"

-- NOTE: You should make sure your terminal supports this
v.o.termguicolors = true

-- [[ Disable auto comment on enter ]]
-- See :help formatoptions
v.api.nvim_create_autocmd("FileType", {
  desc = "remove formatoptions",
  callback = function()
    v.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = v.api.nvim_create_augroup("YankHighlight", { clear = true })
v.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    v.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

v.g.netrw_liststyle = 0
v.g.netrw_banner = 0

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- remove highlighting when exit search
v.keymap.set("n", "<Esc>", "<Esc>:noh<CR>")

v.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves Line Down" })
v.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves Line Up" })
v.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down" })
v.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up" })
v.keymap.set("n", "n", "nzzzv", { desc = "Next Search Result" })
v.keymap.set("n", "N", "Nzzzv", { desc = "Previous Search Result" })

v.keymap.set("n", "<leader><leader>[", "<cmd>bprev<CR>", { desc = "Previous buffer" })
v.keymap.set("n", "<leader><leader>]", "<cmd>bnext<CR>", { desc = "Next buffer" })
v.keymap.set("n", "<leader><leader>l", "<cmd>b#<CR>", { desc = "Last buffer" })
v.keymap.set("n", "<leader><leader>x", "<cmd>bdelete<CR>", { desc = "delete buffer" })
v.keymap.set("n", "<leader><leader>s", "<cmd>w<CR>", { desc = "delete buffer" })

-- Resize windows with arrow keys
v.keymap.set("n", "<Down>", ":resize +2<CR>", { desc = "Increase window height" })
v.keymap.set("n", "<Up>", ":resize -2<CR>", { desc = "Decrease window height" })
v.keymap.set("n", "<Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })
v.keymap.set("n", "<Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })

-- see help sticky keys on windows
v.cmd([[command! W w]])
v.cmd([[command! Wq wq]])
v.cmd([[command! WQ wq]])
v.cmd([[command! Q q]])

-- Remap for dealing with word wrap
v.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
v.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
v.diagnostic.config({ jump = { float = true }, underline = true})
v.keymap.set("n", "<leader>e", v.diagnostic.open_float, { desc = "Open floating diagnostic message" })
v.keymap.set("n", "<leader>q", v.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- kickstart.nvim starts you with this.
-- But it constantly clobbers your system clipboard whenever you delete anything.

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.o.clipboard = 'unnamedplus'

-- You should instead use these keybindings so that they are still easy to use, but dont conflict
v.keymap.set({ "v", "x", "n" }, "<leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })
v.keymap.set(
  { "n", "v", "x" },
  "<leader>Y",
  '"+yy',
  { noremap = true, silent = true, desc = "Yank line to clipboard" }
)
v.keymap.set({ "n", "v", "x" }, "<C-a>", "gg0vG$", { noremap = true, silent = true, desc = "Select all" })
v.keymap.set({ "n", "v", "x" }, "<leader>p", '"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })
v.keymap.set(
  "i",
  "<C-p>",
  "<C-r><C-p>+",
  { noremap = true, silent = true, desc = "Paste from clipboard from within insert mode" }
)
v.keymap.set(
  "x",
  "<leader>P",
  '"_dP',
  { noremap = true, silent = true, desc = "Paste over selection without erasing unnamed register" }
)
