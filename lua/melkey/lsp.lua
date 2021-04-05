local lspconfig = require'lspconfig'
local completion = require'completion'

-- Diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    --defines error in line via keybinding 
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)

local function default_on_attach(client)
  print('Attaching to ' .. client.name)
  completion.on_attach(client)
end

local default_config = {
  on_attach = default_on_attach,
}

local pid = vim.fn.getpid()
local cache_path = vim.fn.stdpath('cache')
local sumneko_lua_root_path = cache_path .. '/lspconfig/sumneko_lua/lua-language-server'
local sumneko_lua_binary = sumneko_lua_root_path .. '/bin/Linux/lua-language-server'

-- Language Servers
lspconfig.pyls.setup(default_config)
lspconfig.bashls.setup(default_config)
lspconfig.cssls.setup(default_config)
lspconfig.dockerls.setup(default_config)
lspconfig.html.setup(default_config)
lspconfig.jsonls.setup(default_config)
lspconfig.tsserver.setup(default_config)
lspconfig.sumneko_lua.setup({
    cmd = {sumneko_lua_binary, "-E", sumneko_lua_root_path .. '/main.lua'},
    on_attach = default_on_attach,
    settings = {
      Lua ={
        runtime = {
          version = 'LuaJIT',
          path = vim.split(package.path, ';')
        },
        diagnostics = {
          globals = {'vim'}
        },
        workspace = {
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
          }
        }
      }
    }
})
lspconfig.vimls.setup(default_config)
lspconfig.yamlls.setup(default_config)
