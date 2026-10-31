require("config.lsp.diagnostics")
require("config.lsp.hover")
require("config.lsp.attach")

vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      hint = { enable = true },
      telemetry = { enable = false },
    },
  },
})
-- Hover/completion/validation from $schema; formatting stays with efm/fixjson.
vim.lsp.config("jsonls", {
  init_options = { provideFormatter = false },
})

-- rust-analyzer is a rustup component (installed by mise), not a Mason package, so it matches the toolchain.
vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      check = { command = "clippy" },
    },
  },
})

require("config.lsp.typescript")
require("config.lsp.efm")

vim.lsp.enable({
  "lua_ls",
  "bashls",
  "jsonls",
  "tsc",
  "ts_ls",
  "eslint",
  -- oxlint/oxfmt require project config markers, coexisting with eslint/prettier elsewhere.
  "oxlint",
  "oxfmt",
  "rust_analyzer",
  "efm",
})
