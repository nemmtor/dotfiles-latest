local group = vim.api.nvim_create_augroup("UserConfig", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  desc = "Highlight yanked text",
  callback = function()
    vim.hl.hl_op()
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = group,
  desc = "Restore last cursor position",
  callback = function(args)
    if vim.wo.diff then
      return
    end

    local last_pos = vim.api.nvim_buf_get_mark(args.buf, '"')
    local last_line = vim.api.nvim_buf_line_count(args.buf)
    if last_pos[1] < 1 or last_pos[1] > last_line then
      return
    end

    pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "markdown", "text", "gitcommit" },
  desc = "Enable wrapping and spellcheck for prose",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
  end,
})
