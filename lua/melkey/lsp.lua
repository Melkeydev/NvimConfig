vim.api.nvim_create_augroup('LspFormattingOnSave', {})

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
  'diagnosticls',
}

local allowed_to_format = {
  'gopls',
  'bashls',
  'pyright',
  'dockerls',
  'html',
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Diagnostics
vim.diagnostic.config {
  --defines error in line via keybinding
  virtual_text = true,
  underline = { severity_limit = 'Error' },
  signs = true,
  update_in_insert = false,
}

local signs = { Error = ' X', Warn = ' ▲', Hint = ' ', Info = ' ' }

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

local function set_formatting_keymap(client, buf)
  vim.keymap.set('n', '<Leader>f', function()
    local params = vim.lsp.util.make_formatting_params {}
    client.request('textDocument/formatting', params, nil, buf)
  end, { buffer = buf })
end

local function lsp_format_sync(client, buf, params, timeout)
  timeout = timeout or 1000

  local response = client.request_sync('textDocument/formatting', params, timeout, buf)
  if response.err then
    return
  end
  if #response.result == 0 then
    return
  end

  vim.lsp.util.apply_text_edits(response.result, buf, client.offset_encoding)
end

local function set_formatting_on_save(client, buf)
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = 'LspFormattingOnSave',
    buffer = buf,
    callback = function()
      local params = vim.lsp.util.make_formatting_params {}
      lsp_format_sync(client, buf, params)
    end,
  })
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

  -- Only autoformat code (or <leader>f manually) if the lsp server can
  -- or is allowed by `allowed_to_format` variable
  if client.supports_method 'textDocument/formatting' and vim.tbl_contains(allowed_to_format, client.name) then
    set_formatting_keymap(client, buf)
    set_formatting_on_save(client, buf)
  end
end

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
      },
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

require('diagnosticls-configs').init {
  capabilities = capabilities,
  on_attach = function(client, buf)
    if client.supports_method 'textDocument/formatting' and client.name == 'diagnosticls' then
      set_formatting_keymap(client, buf)
      set_formatting_on_save(client, buf)
    end
  end,
}

local eslint_d = require 'diagnosticls-configs.linters.eslint_d'
local flake8 = require 'diagnosticls-configs.linters.flake8'
local prettier = require 'diagnosticls-configs.formatters.prettier'
local stylua = require 'diagnosticls-configs.formatters.stylua'
require('diagnosticls-configs').setup {
  javascript = { linter = eslint_d, formatter = prettier },
  javascriptreact = { linter = eslint_d, formatter = prettier },
  typescript = { linter = eslint_d, formatter = prettier },
  typescriptreact = { linter = eslint_d, formatter = prettier },
  lua = { formatter = stylua },
  python = { linter = flake8 },
}
