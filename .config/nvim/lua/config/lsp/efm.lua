local stylua = require("efmls-configs.formatters.stylua")
local fish_indent = require("efmls-configs.formatters.fish_indent")
local prettier = require("efmls-configs.formatters.prettier")
local fixjson = require("efmls-configs.formatters.fixjson")
local shellcheck = require("efmls-configs.linters.shellcheck")
local shfmt = require("efmls-configs.formatters.shfmt")

local languages = {
  css = { prettier },
  fish = { fish_indent },
  html = { prettier },
  javascript = { prettier },
  javascriptreact = { prettier },
  json = { fixjson },
  jsonc = { fixjson },
  lua = { stylua },
  markdown = { prettier },
  sh = { shellcheck, shfmt },
  typescript = { prettier },
  typescriptreact = { prettier },
}

vim.lsp.config("efm", {
  filetypes = vim.tbl_keys(languages),
  init_options = { documentFormatting = true },
  settings = { languages = languages },
})
