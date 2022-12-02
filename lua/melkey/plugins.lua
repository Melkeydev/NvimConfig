local vim = vim

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd('packadd packer.nvim')

local packer = require'packer'
local util = require'packer.util'

packer.init({
    compile_path = vim.fn.stdpath('data') .. '/plugin/packer_compiled.lua'
})

return packer.startup(function(use)
    use {'wbthomason/packer.nvim', opt = true}

    use 'jaredgorski/fogbell.vim'
    use 'gruvbox-community/gruvbox'

    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/telescope.nvim'
    use 'Xuyuanp/nerdtree-git-plugin'
    use 'preservim/NERDTree'

    use 'tpope/vim-sensible'
    use 'tpope/vim-surround'
    use 'jistr/vim-nerdtree-tabs'
    use 'majutsushi/tagbar'
    use 'vim-scripts/indentpython.vim'
    use 'lepture/vim-jinja'
    use 'joshdick/onedark.vim'
    use 'tiagofumo/vim-nerdtree-syntax-highlight'
    use 'sheerun/vim-polyglot'
    use 'tpope/vim-fugitive'
    use 'jiangmiao/auto-pairs'
    use 'vim-airline/vim-airline'
    use 'ryanoasis/vim-devicons'
    use 'jremmen/vim-ripgrep'

    use 'preservim/nerdcommenter'

    use 'sbdchd/neoformat'

    use 'tmhedberg/SimpylFold'

    use 'neovim/nvim-lspconfig'
    use {'williamboman/nvim-lsp-installer'}
    use 'nvim-lua/lsp-status.nvim'

    use {'prettier/vim-prettier', run = 'npm install' }

    use {'jose-elias-alvarez/nvim-lsp-ts-utils'}

    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'alvan/vim-closetag'

    use 'zbirenbaum/copilot.lua'

    if packer_bootstrap then
        packer.sync()
    end
end)

