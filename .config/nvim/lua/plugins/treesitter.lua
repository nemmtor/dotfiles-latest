local treesitter = require("nvim-treesitter")
treesitter.setup({})

local ensure_installed = {
  "vim",
  "vimdoc",
  "toml",
  "html",
  "css",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline", -- required by render-markdown
  "typescript",
  "tsx",
  "yaml",
  "regex",
  "bash",
  "rust",
}

local config = require("nvim-treesitter.config")
local installed = config.get_installed()
local missing = {}
for _, parser in ipairs(ensure_installed) do
  if not vim.list_contains(installed, parser) then
    table.insert(missing, parser)
  end
end
if #missing > 0 then
  treesitter.install(missing)
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true }),
  desc = "Enable Tree-sitter highlighting and indentation for installed parsers",
  callback = function(args)
    if vim.list_contains(config.get_installed(), vim.treesitter.language.get_lang(args.match)) then
      vim.treesitter.start(args.buf)
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

require("nvim-ts-autotag").setup({
  opts = {
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = false,
  },
  per_filetype = {
    html = { enable_close = false },
  },
})
require("treesitter-context").setup({})
require("render-markdown").setup({
  latex = { enabled = false }, -- no latex tools installed
})
