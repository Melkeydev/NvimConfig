local group = vim.api.nvim_create_augroup("UserGroup", {})

vim.api.nvim_create_autocmd("ColorScheme", {
	group = group,
	callback = function()
		vim.api.nvim_set_hl(0, "WinSeparator", { bg = "NONE", fg = "#aaaaaa" })
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE", fg = "#aaaaaa" })
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE", fg = "#aaaaaa" })
	end,
	desc = "Brighter window separator",
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = group,
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
	end,
	desc = "Highlight words when a yank (y) is performed",
})
