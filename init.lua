local vim = vim

vim.g.mapleader = ' '

-- Uncomment this only if you have onedark downloaded 
pcall(vim.cmd, [[colorscheme onedark]])

--vim.cmd 'au ColorScheme * hi! Normal guibg=none'
vim.cmd 'au ColorScheme * hi! Normal guibg=NONE'
vim.cmd 'au ColorScheme * hi! SignColumn guibg=NONE'
vim.cmd 'au ColorScheme * hi! LineNr guibg=NONE'
vim.cmd 'au ColorScheme * hi! CursorLineNr guibg=NONE'

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false
  }
)

vim.g.closetag_filetypes = 'html,xhtml,phtml,typescriptreact,javascriptreact,javascript,typescript'


local o = vim.o
local bo = vim.bo
local wo = vim.wo

o.termguicolors = true
o.syntax = 'on'
o.errorbells = false
o.smartcase = true
o.showmode = false
bo.swapfile = false
o.backup = false
o.undodir = vim.fn.stdpath('config') .. '/undodir'
o.undofile = true
o.incsearch = true
o.hidden = true
o.completeopt='menuone,noinsert,noselect'
bo.autoindent = true
bo.smartindent = true

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.scrolloff = 7
o.expandtab = true
o.foldlevelstart = 99
wo.number = true -- display line numbers
wo.relativenumber = true -- display relative line numbers
wo.signcolumn = 'yes'
wo.wrap = true

o.syntax = 'on'

require'melkey'
