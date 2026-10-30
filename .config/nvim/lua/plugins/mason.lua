require("mason").setup({})

local registry = require("mason-registry")
local tools = {
  "bash-language-server",
  "efm",
  "eslint-lsp",
  "fish-lsp",
  "fixjson",
  "graphql-language-service-cli",
  "js-debug-adapter",
  "json-lsp",
  "lua-language-server",
  "marksman",
  "oxfmt",
  "oxlint",
  "prettier",
  "shellcheck",
  "shfmt",
  "stylua",
  "tailwindcss-language-server",
  "typescript-language-server",
  "vim-language-server",
}

-- The registry must be downloaded before get_package works on first start.
registry.refresh(function()
  for _, tool in ipairs(tools) do
    local ok, pkg = pcall(registry.get_package, tool)
    if not ok then
      vim.notify("mason: unknown package " .. tool, vim.log.levels.WARN)
    elseif not pkg:is_installed() then
      vim.notify("mason: installing " .. tool)
      pkg:install()
    end
  end
end)
