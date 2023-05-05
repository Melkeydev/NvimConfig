return {
	"tpope/vim-surround",
	"jiangmiao/auto-pairs",
	"preservim/nerdcommenter",
	{
		"folke/which-key.nvim",
		config = function()
			vim.opt.timeout = true
			vim.opt.timeoutlen = 300
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			vim.g.indentLine_fileTypeExclude = { "help", "telescope" }
			vim.g.indentLine_char = "│"
			vim.g.indent_blankline_show_first_indent_level = false

			require("indent_blankline").setup()
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
}
