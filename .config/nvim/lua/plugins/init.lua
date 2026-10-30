-- Register install hooks before the first vim.pack.add().
vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("UserPackages", { clear = true }),
  desc = "Update Tree-sitter parsers when the plugin changes",
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" and (ev.data.kind == "install" or ev.data.kind == "update") then
      vim.schedule(function()
        if not ev.data.active then
          vim.cmd.packadd("nvim-treesitter")
        end
        vim.cmd.TSUpdate()
      end)
    end
  end,
})

vim.pack.add({
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://www.github.com/echasnovski/mini.nvim",
  "https://github.com/folke/snacks.nvim",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://www.github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/creativenull/efmls-configs-nvim",
  "https://github.com/moyiz/blink-emoji.nvim",
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/marilari88/twoslash-queries.nvim",
  "https://github.com/hedyhli/outline.nvim",
  "https://github.com/mbbill/undotree",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/folke/trouble.nvim",
  "https://github.com/windwp/nvim-ts-autotag",
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  "https://github.com/esmuellert/codediff.nvim",
  "https://github.com/kitlangton/navi.nvim",
})

vim.cmd.colorscheme("tokyonight-storm")

require("plugins.treesitter")
require("plugins.mini")
require("plugins.oil")
require("plugins.snacks")
require("plugins.editor")
require("plugins.mason")
require("plugins.completion")
