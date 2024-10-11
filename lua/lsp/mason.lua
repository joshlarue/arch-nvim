local servers = {
  "lua_ls",
  "cssls",
  "html",
  "ts_ls",
  "jsonls",
  "yamlls",
  "eslint",
  "tailwindcss",
}

require("mason").setup({
  lazy = false,
})

require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
  lazy = false,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, server in pairs(servers) do
  -- set up global 'vim' so you don't get a bunch of LSP warnings in Lua
  if server == "lua_ls" then
    require("lspconfig")[server].setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          }
        }
      },
      capabilities = capabilities
    }
  else
    require("lspconfig")[server].setup {
      capabilities = capabilities
    }
  end
end
