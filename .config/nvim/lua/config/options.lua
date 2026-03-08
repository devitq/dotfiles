vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 10
opt.sidescrolloff = 8

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

opt.splitright = true
opt.splitbelow = true

opt.termguicolors = true
opt.updatetime = 250
opt.timeoutlen = 400

opt.clipboard = "unnamedplus"
opt.undofile = true

