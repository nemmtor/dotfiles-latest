local formatting = require("config.lsp.formatting")

vim.keymap.set("n", "<leader>th", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code Action" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
  desc = "Set buffer-local LSP mappings and attach TypeScript queries",
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    local bufnr = ev.buf
    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { silent = true, buffer = bufnr, desc = desc })
    end

    if client.name == "tsc" or client.name == "ts_ls" then
      require("twoslash-queries").attach(client, bufnr)
    end

    map("<leader>]d", function()
      vim.diagnostic.jump({ count = 1 })
    end, "Next diagnostic")
    map("<leader>[d", function()
      vim.diagnostic.jump({ count = -1 })
    end, "Previous diagnostic")
    map("K", vim.lsp.buf.hover, "Hover documentation")
    map("gr", function()
      require("snacks").picker.lsp_references()
    end, "LSP references")
    map("gd", function()
      require("snacks").picker.lsp_definitions()
    end, "LSP definitions")
    map("gi", function()
      require("snacks").picker.lsp_implementations()
    end, "LSP implementations")
    map("gt", function()
      require("snacks").picker.lsp_type_definitions()
    end, "LSP type definitions")

    if client:supports_method("textDocument/codeAction", bufnr) then
      map("<leader>oi", function()
        vim.lsp.buf.code_action({
          context = { only = { "source.organizeImports" }, diagnostics = {} },
          apply = true,
          bufnr = bufnr,
        })
        vim.defer_fn(function()
          formatting.format(bufnr)
        end, 50)
      end, "Organize imports")
    end
  end,
})
