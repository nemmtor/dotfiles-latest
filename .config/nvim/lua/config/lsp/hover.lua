-- jsonls markdown-escapes hover text. Undo escaping only when its &nbsp;
-- signature is present so other servers' hovers stay untouched.
local orig_to_markdown = vim.lsp.util.convert_input_to_markdown_lines
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.util.convert_input_to_markdown_lines = function(input, contents)
  local lines = orig_to_markdown(input, contents)
  local escaped = false
  for _, line in ipairs(lines) do
    if line:find("&nbsp;", 1, true) then
      escaped = true
      break
    end
  end
  if escaped then
    for i, line in ipairs(lines) do
      lines[i] = line:gsub("&nbsp;", " "):gsub("\\([\\`*_{}%[%]%(%)#+%-%.!])", "%1")
    end
  end
  return lines
end
