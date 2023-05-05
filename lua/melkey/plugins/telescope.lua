return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<Leader>p", "<Cmd>Telescope find_files<CR>", desc = "Find files" },
			{ "<Leader>fs", "<Cmd>Telescope live_grep<CR>", desc = "Grep inside files" },
			{ "<Leader>fh", "<Cmd>Telescope help_tags<CR>", desc = "Search in vim :help" },
			{ "<Leader>fb", "<Cmd>Telescope buffers<CR>", desc = "List and search buffers" },
			{ "<Leader>fq", "<Cmd>Telescope quickfix<CR>", desc = "List and search quickfix" },
			{
				"<Leader>fd",
				'<Cmd>lua require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })<CR>',
				desc = "Find files in config path",
			},
			{
				"<Leader>fw",
				'<Cmd>lua require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })<CR>',
				desc = "Grep word under cursor",
			},
		},
		config = function()
			local telescope = require("telescope")
			local themes = require("telescope.themes")
			local previewers = require("telescope.previewers")

			local theme_defaults = themes.get_dropdown({
				win_blend = 10,
				results_height = 0.25,
				width = 0.65,
				shorten_path = true,
			})

			telescope.setup({
				defaults = vim.tbl_extend("error", theme_defaults, {
					file_previewer = previewers.vim_buffer_cat.new,
					grep_previewer = previewers.vim_buffer_vimgrep.new,
					qflist_previewer = previewers.vim_buffer_qflist.new,
				}),
			})
		end,
	},
}
