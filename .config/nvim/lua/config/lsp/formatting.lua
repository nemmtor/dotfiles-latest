local M = {}

-- oxfmt only attaches in projects that opt into it; prefer it over efm/prettier.
function M.format(bufnr)
  local formatter
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    if client.name == "oxfmt" then
      formatter = "oxfmt"
      break
    elseif client.name == "efm" then
      formatter = "efm"
    end
  end
  if not formatter then
    return
  end

  vim.lsp.buf.format({
    bufnr = bufnr,
    timeout_ms = 2000,
    filter = function(client)
      return client.name == formatter
    end,
  })
end

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("UserFormatting", { clear = true }),
  desc = "Format real file buffers with oxfmt or efm",
  callback = function(args)
    if vim.bo[args.buf].buftype ~= "" or not vim.bo[args.buf].modifiable then
      return
    end
    if vim.api.nvim_buf_get_name(args.buf) == "" then
      return
    end
    pcall(M.format, args.buf)
  end,
})

return M
