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
			{ "<Leader>fd", '<Cmd>Telescope find_files cwd=stdpath("config")<CR>', desc = "Find files in config path" },
			{ "<Leader>fw", '<Cmd>Telescope find_files search=expand("<cword>")<CR>', desc = "Grep word under cursor" },
		},
		config = function()
			local telescope = require("telescope")
			local themes = require("telescope.themes")
			local actions = require("telescope.actions")
			local previewers = require("telescope.previewers")

			local custom_actions = {}

			custom_actions.add_selection_to_quickfix = function(prompt_bufnr)
				local entry = actions.get_selected_entry(prompt_bufnr)

				local qf_list = {
					{
						bufnr = entry.bufnr,
						filename = entry.filename,
						lnum = entry.lnum,
						col = entry.col,
						text = entry.value,
					},
				}

				local current_qf = vim.fn.getqflist()

				for _, v in pairs(current_qf) do
					table.insert(qf_list, v)
				end

				vim.fn.setqflist(qf_list)
				print("Added " .. entry.filename .. " to quickfix")
			end

			custom_actions.remove_selection_from_quickfix = function(prompt_bufnr)
				local entry = actions.get_selected_entry(prompt_bufnr)
				local selected_qf_entry = {
					bufnr = entry.bufnr,
					filename = entry.filename,
					lnum = entry.lnum,
					col = entry.col,
					text = entry.value,
				}

				local qf_list = {}

				local current_qf = vim.fn.getqflist()
				for _, qf_entry in pairs(current_qf) do
					local should_keep = true
					for k, v in pairs(selected_qf_entry) do
						if qf_entry[k] ~= v then
							should_keep = false
							break
						end
					end
					if should_keep then
						table.insert(qf_list, qf_entry)
					end
				end

				vim.fn.setqflist(qf_list)
				actions.close(prompt_bufnr)
			end

			local defaults = {
				mappings = {
					i = {
						["<C-a>"] = custom_actions.add_selection_to_quickfix,
						["<C-q>"] = custom_actions.remove_selection_from_quickfix,
					},
				},
			}

			local theme_defaults =
				themes.get_dropdown({ win_blend = 10, results_height = 0.25, width = 0.65, shorten_path = true })

			telescope.setup({
				defaults = vim.tbl_extend("error", theme_defaults, defaults, {
					file_previewer = previewers.vim_buffer_cat.new,
					grep_previewer = previewers.vim_buffer_vimgrep.new,
					qflist_previewer = previewers.vim_buffer_qflist.new,
				}),
			})
		end,
	},
}
