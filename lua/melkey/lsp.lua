local lspconfig = require'lspconfig'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Diagnostics
vim.diagnostic.config {
    --defines error in line via keybinding
    virtual_text = true,
    underline = { severity_limit = "Error" },
    signs = true,
    update_in_insert = false,
}

local signs = { Error = " X", Warn = " ▲", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local function on_attach(client, buf)
  print('Attaching to ' .. client.name)

  vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', { buffer = buf })
  vim.keymap.set('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', { buffer = buf })
  vim.keymap.set('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', { buffer = buf })
  vim.keymap.set('n', 'gw', '<Cmd>lua vim.lsp.buf.document_symbol()<CR>', { buffer = buf })
  vim.keymap.set('n', 'gW', '<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>', { buffer = buf })
  vim.keymap.set('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', { buffer = buf })
  vim.keymap.set('n', 'gt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', { buffer = buf })
  vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', { buffer = buf })
  vim.keymap.set('n', '<c-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', { buffer = buf })
  vim.keymap.set('n', '<leader>af', '<Cmd>lua vim.lsp.buf.code_action()<CR>', { buffer = buf })
  vim.keymap.set('n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', { buffer = buf })
  vim.keymap.set('n', '<leader>f','<Cmd>lua vim.lsp.buf.formatting()<CR>', { buffer = buf })
end

local tools = {
  'eslint_d',
  'prettier',
  'stylua',
  'flake8',
}

local lsp_servers = {
  'pyright',
  'sumneko_lua',
  'tsserver',
  'gopls',
  'bashls',
  'cssls',
  'dockerls',
  'jsonls',
  'tailwindcss',
  'html',
  'yamlls',
}

require('mason').setup()
require('mason-tool-installer').setup { ensure_installed = tools }
require('mason-lspconfig').setup { ensure_installed = lsp_servers }

for _, server in pairs(lsp_servers) do
  if server == 'sumneko_lua' then
    local lua_rtp = vim.split(package.path, ';')
    table.insert(lua_rtp, 'lua/?.lua')
    table.insert(lua_rtp, 'lua/?/init.lua')
    local settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = lua_rtp,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file('', true),
          checkThirdParty = false,
          userThirdParty = { 'OpenResty' },
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = { enable = false },
      }
    }
    require('lspconfig')[server].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = settings,
    }
  else
    require('lspconfig')[server].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end
end

-- Language Servers
-- lspconfig.pylsp.setup(default_config)
-- lspconfig.bashls.setup(default_config)

-- lspconfig.cssls.setup(default_config)
-- lspconfig.dockerls.setup(default_config)
-- lspconfig.html.setup(default_config)
-- lspconfig.jsonls.setup(default_config)
-- lspconfig.tailwindcss.setup(default_config)
-- lspconfig.tsserver.setup({
--     on_attach = function(client, bufnr)
--       local ts_utils = require("nvim-lsp-ts-utils")
--
--       default_on_attach(client)
--
--       -- defaults
--       ts_utils.setup {
--         debug = false,
--         disable_commands = false,
--         enable_import_on_completion = true,
--         import_on_completion_timeout = 5000,
--
--         -- eslint
--         eslint_enable_code_actions = true,
--         eslint_bin = "eslint",
--         eslint_args = {"-f", "json", "--stdin", "--stdin-filename", "$FILENAME"},
--         eslint_enable_disable_comments = true,
--
--         -- experimental settings!
--         -- eslint diagnostics
--         eslint_enable_diagnostics = true,
--         eslint_diagnostics_debounce = 250,
--
--         -- formatting
--         enable_formatting = true,
--         formatter = "prettier",
--         formatter_args = {"--stdin-filepath", "$FILENAME"},
--         format_on_save = true,
--         no_save_after_format = false,
--
--         -- parentheses completion
--         complete_parens = false,
--         signature_help_in_parens = true,
--
--         -- update imports on file move
--         update_imports_on_move = false,
--         require_confirmation_on_move = false,
--         watch_dir = "/src",
--       }
--
--       -- required to enable ESLint code actions and formatting
--       ts_utils.setup_client(client)
--
--       -- no default maps, so you may want to define some here
--       vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", {silent = true})
--       vim.api.nvim_buf_set_keymap(bufnr, "n", "qq", ":TSLspFixCurrent<CR>", {silent = true})
--       vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", {silent = true})
--       vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", {silent = true})
--     end
--   })
-- lspconfig.vimls.setup(default_config)
-- lspconfig.yamlls.setup(default_config)
-- --local gopls_config = vim.tbl_extend('force', default_config, {
--     --settings = {
--       --gopls = {
--         --analyses = {
--           --unusedparams = true,
--         --},
--         --staticcheck = true,
--       --},
--     --},
--   --})
--   --local gopls_config = {
--     --on_attach = default_on_attach;
--     --settings = {
--       --gopls = {
--         --analyses = {
--           --unusedparams = true,
--         --},
--         --staticcheck = true,
--       --},
--     --},
--   --}
-- --lspconfig.gopls.setup(gopls_config)
-- local lsp_installer = require("nvim-lsp-installer")
--
-- -- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- -- or if the server is already installed).
-- local lua_rtp = vim.split(package.path, ';')
-- table.insert(lua_rtp, 'lua/?.lua')
-- table.insert(lua_rtp, 'lua/?/init.lua')
-- lsp_installer.on_server_ready(function(server)
--   local opts = {}
--
--   if server.name == 'gopls' then
--     opts = {
--       capabilities = capabilities;
--       on_attach = default_on_attach;
--       settings = {
--         gopls = {
--           analyses = {
--             unusedparams = true,
--           },
--           staticcheck = true,
--         },
--       }
--     }
--   end
--
--   -- (optional) Customize the options passed to the server
--   if server.name == "sumneko_lua" then
--     opts.settings = {
--       Lua = {
--         runtime = {
--           -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--           version = 'LuaJIT',
--           -- Setup your lua path
--           path = lua_rtp,
--         },
--         diagnostics = {
--           -- Get the language server to recognize the `vim` global
--           globals = { 'vim', 'coq' },
--         },
--         workspace = {
--           -- Make the server aware of Neovim runtime files
--           library = vim.api.nvim_get_runtime_file('', true),
--           checkThirdParty = false,
--           userThirdParty = {
--             'OpenResty',
--           },
--         },
--         -- Do not send telemetry data containing a randomized but unique identifier
--         telemetry = {
--           enable = false,
--         },
--       }
--     }
--   end
--
--   -- This setup() function will take the provided server configuration and decorate it with the necessary properties
--   -- before passing it onwards to lspconfig.
--   -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--   server:setup(opts)
-- end)
