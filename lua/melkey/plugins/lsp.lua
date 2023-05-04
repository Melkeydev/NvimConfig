return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Core
		{
			"williamboman/mason.nvim",
			dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
			build = function()
				pcall(vim.cmd, "MasonUpdate")
			end,
		},
		{
			"VonHeikemen/lsp-zero.nvim",
			branch = "v2.x",
			lazy = false,
		},
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				"roobert/tailwindcss-colorizer-cmp.nvim",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-buffer",
				"onsails/lspkind-nvim",
				"L3MON4D3/LuaSnip",
				"saadparwaiz1/cmp_luasnip",
			},
		},
		{ "jose-elias-alvarez/null-ls.nvim" },
		{ "nvimdev/lspsaga.nvim" },
		{ "j-hui/fidget.nvim" },

		-- Language specific
		{ "folke/neodev.nvim", lazy = false },
		{ "jose-elias-alvarez/typescript.nvim", lazy = false },
		{ "ray-x/go.nvim", lazy = false, dependencies = { "ray-x/guihua.lua" } },
	},
	config = function()
		-- Setup functions and options to be used further down
		local format_group = vim.api.nvim_create_augroup("LspFormatGroup", {})
		local format_opts = { async = false, timeout_ms = 2500 }

		local function register_fmt_keymap(name, bufnr)
			local fmt_keymap = "<leader>f"
			vim.keymap.set("n", fmt_keymap, function()
				vim.lsp.buf.format(vim.tbl_extend("force", format_opts, { name = name, bufnr = bufnr }))
			end, { desc = "Format current buffer [LSP]", buffer = bufnr })
		end

		local function register_fmt_autosave(name, bufnr)
			vim.api.nvim_clear_autocmds({ group = format_group, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = format_group,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format(vim.tbl_extend("force", format_opts, { name = name, bufnr = bufnr }))
				end,
				desc = "Format on save [LSP]",
			})
		end

		require("fidget").setup({})
		require("lspsaga").setup({
			ui = { border = "rounded" },
			symbol_in_winbar = { enable = false },
		})

		local function on_attach(client, bufnr)
			--vim.keymap.set(
			--"n",
			--"gd",
			--"<Cmd>lua vim.lsp.buf.definition()<CR>",
			--{ buffer = bufnr, desc = "LSP go to definition" }
			--)
			vim.keymap.set(
				"n",
				"gd",
				"<Cmd>Lspsaga goto_definition<CR>",
				{ buffer = bufnr, desc = "LSP go to definition" }
			)
			--vim.keymap.set(
			--"n",
			--"gt",
			--"<Cmd>lua vim.lsp.buf.type_definition()<CR>",
			--{ buffer = bufnr, desc = "LSP go to type definition" }
			--)
			vim.keymap.set(
				"n",
				"gt",
				"<Cmd>Lspsaga peek_type_definition<CR>",
				{ buffer = bufnr, desc = "LSP go to type definition" }
			)
			vim.keymap.set(
				"n",
				"gD",
				"<Cmd>lua vim.lsp.buf.declaration()<CR>",
				{ buffer = bufnr, desc = "LSP go to declaration" }
			)
			vim.keymap.set(
				"n",
				"gi",
				"<Cmd>lua vim.lsp.buf.implementation()<CR>",
				{ buffer = bufnr, desc = "LSP go to implementation" }
			)
			--vim.keymap.set(
			--"n",
			--"gw",
			--"<Cmd>lua vim.lsp.buf.document_symbol()<CR>",
			--{ buffer = bufnr, desc = "LSP document symbols" }
			--)
			vim.keymap.set("n", "gw", "<Cmd>Lspsaga lsp_finder<CR>", { buffer = bufnr, desc = "LSP document symbols" })
			vim.keymap.set(
				"n",
				"gW",
				"<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>",
				{ buffer = bufnr, desc = "LSP Workspace symbols" }
			)
			vim.keymap.set(
				"n",
				"gr",
				"<Cmd>lua vim.lsp.buf.references()<CR>",
				{ buffer = bufnr, desc = "LSP show references" }
			)
			--vim.keymap.set(
			--"n",
			--"K",
			--"<Cmd>lua vim.lsp.buf.hover()<CR>",
			--{ buffer = bufnr, desc = "LSP hover documentation" }
			--)
			vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", { buffer = bufnr, desc = "LSP hover documentation" })
			vim.keymap.set(
				"n",
				"<c-k>",
				"<Cmd>lua vim.lsp.buf.signature_help()<CR>",
				{ buffer = bufnr, desc = "LSP signature help" }
			)
			--vim.keymap.set(
			--"n",
			--"<leader>af",
			--"<Cmd>lua vim.lsp.buf.code_action()<CR>",
			--{ buffer = bufnr, desc = "LSP show code actions" }
			--)
			vim.keymap.set(
				"n",
				"<leader>af",
				"<Cmd>Lspsaga code_action<CR>",
				{ buffer = bufnr, desc = "LSP show code actions" }
			)
			--vim.keymap.set(
			--"n",
			--"<leader>rn",
			--"<Cmd>lua vim.lsp.buf.rename()<CR>",
			--{ buffer = bufnr, desc = "LSP rename word" }
			--)
			vim.keymap.set("n", "<leader>rn", "<Cmd>Lspsaga rename<CR>", { buffer = bufnr, desc = "LSP rename word" })
			--vim.keymap.set(
			--"n",
			--"<leader>dn",
			--'<Cmd>lua vim.diagnostic.goto_next({ float = { border = "rounded" } })<CR>',
			--{ buffer = bufnr, desc = "LSP go to next diagnostic" }
			--)
			vim.keymap.set(
				"n",
				"<leader>dn",
				"<Cmd>Lspsaga diagnostic_jump_next<CR>",
				{ buffer = bufnr, desc = "LSP go to next diagnostic" }
			)
			--vim.keymap.set(
			--"n",
			--"<leader>dp",
			--'<Cmd>lua vim.diagnostic.goto_prev({ float = { border = "rounded" } })<CR>',
			--{ buffer = bufnr, desc = "LSP go to previous diagnostic" }
			--)
			vim.keymap.set(
				"n",
				"<leader>dp",
				"<Cmd>Lspsaga diagnostic_jump_prev<CR>",
				{ buffer = bufnr, desc = "LSP go to previous diagnostic" }
			)
			--vim.keymap.set(
			--"n",
			--"<leader>ds",
			--'<Cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>',
			--{ buffer = bufnr, desc = "LSP show diagnostic under cursor" }
			--)
			vim.keymap.set(
				"n",
				"<leader>ds",
				"<Cmd>Lspsaga show_line_diagnostics<CR>",
				{ buffer = bufnr, desc = "LSP show diagnostic under cursor" }
			)

			-- Register formatting and autoformatting
			-- based on lsp server
			if client.name == "gopls" then
				register_fmt_keymap(client.name, bufnr)
				register_fmt_autosave(client.name, bufnr)
			end

			if client.name == "null-ls" then
				register_fmt_keymap(client.name, bufnr)
				register_fmt_autosave(client.name, bufnr)
			end
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		capabilities.textDocument.completion.completionItem.preselectSupport = true
		capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
		capabilities.textDocument.completion.completionItem.resolveSupport = {
			properties = {
				"documentation",
				"detail",
				"additionalTextEdits",
			},
		}

		vim.diagnostic.config({
			virtual_text = {
				severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN },
			},
		})

		-- List out the lsp servers, linters, formatters
		-- for mason
		local tools = {
			"lua-language-server",
			"typescript-language-server",
			"tailwindcss-language-server",
			"html-lsp",
			"css-lsp",
			"json-lsp",
			"gopls",
			"python-lsp-server",
			"black",
			"stylua",
			"prettier",
			"eslint_d",
		}

		require("mason-tool-installer").setup({ ensure_installed = tools })

		-- Register your lsp servers
		-- if they depend on an extra plugin (eg go.nvim)
		-- then call those in this section
		require("neodev").setup({
			-- add any options here, or leave empty to use the default settings
		})

		local lsp = require("lsp-zero").preset("recommended")
		lsp.on_attach(on_attach)
		lsp.set_server_config({
			on_init = function(client)
				client.server_capabilities.semanticTokensProvider = nil
			end,
		})

		local lspconfig = require("lspconfig")
		lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

		lspconfig.jsonls.setup({})
		lspconfig.html.setup({})
		lspconfig.cssls.setup({})
		lspconfig.tailwindcss.setup({})
		require("typescript").setup({
			server = { on_attach = on_attach },
		})

		require("go").setup({
			lsp_cfg = true,
			lsp_on_attach = on_attach,
		})

		lsp.setup()

		-- Linter/Formatter registeration via null-ls
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.diagnostics.eslint_d,
			},
		})

		-- Override autocompletion in this section
		-- for nvim-cmp
		local has_words_before = function()
			if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
				return false
			end
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
		end

		local cmp = require("cmp")
		cmp.setup({
			performance = { debounce = 500 },
			mapping = {
				["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
				["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
				["<C-space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
				["<C-e>"] = cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				}),
				["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
				["<Tab>"] = vim.schedule_wrap(function(fallback)
					if cmp.visible() and has_words_before() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
					else
						fallback()
					end
				end),
				["<S-Tab>"] = vim.schedule_wrap(function(fallback)
					if cmp.visible() and has_words_before() then
						cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
					else
						fallback()
					end
				end),
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			formatting = {
				format = function(entry, item)
					require("lspkind").cmp_format({
						mode = "symbol_text",
						menu = {
							buffer = "[BUF]",
							nvim_lsp = "[LSP]",
							luasnip = "[SNIP]",
							path = "[PATH]",
						},
					})(entry, item)
					return require("tailwindcss-colorizer-cmp").formatter(entry, item)
				end,
			},
		})

		-- For copilot
		cmp.event:on("menu_opened", function()
			vim.b.copilot_suggestion_hidden = true
		end)

		cmp.event:on("menu_closed", function()
			vim.b.copilot_suggestion_hidden = false
		end)
	end,
}
