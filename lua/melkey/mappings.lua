local vim = vim
local utils = require'melkey.utils'


local setup_mappings = function()
     -- Python
     vim.cmd[[let g:neomake_python_enabled_makers = 'flake8']]
     vim.cmd[[let g:python3_host_prog='/usr/bin/python3']]
     vim.cmd[[let NERDTreeShowHidden=1]]
     vim.cmd[[let NERDTreeShowLineNumbers=1]]
     vim.cmd[[autocmd FileType nerdtree setlocal relativenumber]]
     vim.cmd[[let g:airline#extensions#tabline#fnamemode=':t']]
     vim.cmd[[let g:airline#extensions#tabline#enabled=1]]

     vim.cmd[[noremap <C-c> "+y]]

      -- Movement
    utils.key_mapper('n', '<leader>ne', ':NERDTreeToggle<CR>')
    utils.key_mapper('n', '<leader>h', ':wincmd h<CR>')
    utils.key_mapper('n', '<leader>j', ':wincmd j<CR>')
    utils.key_mapper('n', '<leader>k', ':wincmd k<CR>')
    utils.key_mapper('n', '<leader>l', ':wincmd l<CR>')
    utils.key_mapper('n', '<leader>+', ':vertical resize +5<CR>')
    utils.key_mapper('n', '<leader>-', ':vertical resize -5<CR>')
    utils.key_mapper('n', '<C-S>', ':w<CR>')

      -- Tabs
    utils.key_mapper('n', '<leader>q', ':bp<CR>')
    utils.key_mapper('n', '<leader>e', ':bn<CR>')
    utils.key_mapper('n', '<leader>w', ':bd<CR>')

      -- Telescope
    --utils.key_mapper('n', '<leader>nw', ':Telescope file_browser<CR>')
    utils.key_mapper('n', '<leader>p', ':lua require"melkey.telescope".find_files()<CR>')
    utils.key_mapper('n', '<leader>fs', ':lua require"melkey.telescope".live_grep()<CR>')
    utils.key_mapper('n', '<leader>fw', ':lua require"melkey.telescope".grep_string(vim.fn.expand("<cword>"))<CR>')
    utils.key_mapper('n', '<leader>fh', ':lua require"melkey.telescope".help_tags()<CR>')
    utils.key_mapper('n', '<leader>fb', ':lua require"melkey.telescope".buffers()<CR>')
    utils.key_mapper('n', '<leader>fq', ':lua require"melkey.telescope".quickfix()<CR>')
    utils.key_mapper('n', '<leader>fd', ':lua require"melkey.telescope".dotfiles()<CR>')

      -- Diagnostics
    utils.key_mapper('n', '<leader>dn', ':lua vim.diagnostic.goto_next({float={border="rounded"}})<CR>')
    utils.key_mapper('n', '<leader>dp', ':lua vim.diagnostic.goto_prev({float={border="rounded"}})<CR>')
    utils.key_mapper('n', '<leader>ds', ':lua vim.diagnostic.open_float({ focusable = false, border="rounded" })<CR>')
end

setup_mappings()

