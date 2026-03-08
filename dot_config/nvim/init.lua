vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.o.breakindent = true
vim.o.breakindentopt = "sbr,shift:2"
vim.o.showbreak = "↳"
vim.o.linebreak = true
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 0
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.scrolloff = 3
vim.o.sidescrolloff = 3
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.showmode = false
vim.o.foldlevelstart = 99
vim.o.signcolumn = "yes"
vim.opt.fillchars = { eob = " " }

vim.keymap.set("n", "<C-W>b", ":bd<CR>")

-- load plugins after config
require("config.lazy")
vim.cmd.colorscheme "kanagawa"
