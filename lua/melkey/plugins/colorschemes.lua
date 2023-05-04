return {
	{ "gruvbox-community/gruvbox" },
	{
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").setup({ style = "darker" })
			pcall(vim.cmd, "colorscheme onedark")
		end,
	},
	{ "KeitaNakamura/neodark.vim" },
	{ "folke/tokyonight.nvim" },
	{ "EdenEast/nightfox.nvim" },
	{ "catppuccin/nvim", name = "catppuccin" },
}
