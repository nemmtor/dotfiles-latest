local signs = {
  Error = "\u{f057} ",
  Warn = "\u{f071} ",
  Hint = "\u{ea61}",
  Info = "\u{f05a}",
}

vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 4 },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = signs.Error,
      [vim.diagnostic.severity.WARN] = signs.Warn,
      [vim.diagnostic.severity.INFO] = signs.Info,
      [vim.diagnostic.severity.HINT] = signs.Hint,
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float(bufnr, { scope = "cursor", focus = false })
    end,
  },
  float = {
    source = true,
    header = "",
    prefix = "",
    focusable = false,
    style = "minimal",
  },
})
