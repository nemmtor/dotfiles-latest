-- Native TypeScript 7 LSP; show all parameter-name inlay hints.
vim.lsp.config("tsc", {
  settings = {
    ["js/ts"] = {
      inlayHints = { parameterNames = { enabled = "all" } },
    },
  },
})

-- Reuse lspconfig's workspace/monorepo discovery and Deno exclusions.
local typescript_root = vim.lsp.config.ts_ls.root_dir
---@type table<string, string|false>
local native_binaries = {}

local function native_binary(root)
  if native_binaries[root] == nil then
    native_binaries[root] = false
    for _, name in ipairs({ "tsc", "tsgo" }) do
      local binary = vim.fs.joinpath(root, "node_modules", ".bin", name)
      if vim.fn.executable(binary) == 1 then
        local result = vim.system({ binary, "--version" }, { text = true }):wait(2000)
        local version = vim.version.parse(result.stdout or "")
        if result.code == 0 and version and version.major >= 7 then
          native_binaries[root] = binary
          break
        end
      end
    end
  end
  return native_binaries[root]
end

vim.lsp.config("tsc", {
  root_dir = function(bufnr, on_dir)
    typescript_root(bufnr, function(root)
      if native_binary(root) then
        on_dir(root)
      end
    end)
  end,
  cmd = function(dispatchers, config)
    local binary = native_binary(config.root_dir)
    if not binary then
      error("Project-local TypeScript 7+ binary unavailable")
    end
    return vim.lsp.rpc.start({ binary, "--lsp", "--stdio" }, dispatchers)
  end,
})

vim.lsp.config("ts_ls", {
  root_dir = function(bufnr, on_dir)
    typescript_root(bufnr, function(root)
      if not native_binary(root) then
        on_dir(root)
      end
    end)
  end,
})
