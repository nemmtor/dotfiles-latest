require("blink.cmp").setup({
  keymap = { preset = "enter" },
  appearance = { nerd_font_variant = "mono" },
  enabled = function()
    return vim.bo.buftype ~= "nofile" and vim.bo.buftype ~= "prompt"
  end,
  sources = {
    default = { "lsp", "emoji" },
    providers = {
      emoji = {
        module = "blink-emoji",
        name = "Emoji",
        score_offset = 93,
        opts = { insert = true },
      },
    },
  },
  signature = { enabled = true },
  cmdline = { enabled = true, keymap = { preset = "enter" } },
  completion = {
    menu = { auto_show = false, border = "single" },
    accept = { auto_brackets = { enabled = false } },
  },
  snippets = {
    expand = function(snippet)
      require("luasnip").lsp_expand(snippet)
    end,
  },
  fuzzy = {
    implementation = "prefer_rust",
    prebuilt_binaries = { download = true },
  },
})
