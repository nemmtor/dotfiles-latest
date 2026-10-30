require("codediff").setup({})
vim.keymap.set("n", "<leader>lg", "<cmd>CodeDiff<CR>", { desc = "CodeDiff git status" })

vim.keymap.set("n", "]n", "<cmd>NaviNext<CR>", { desc = "Next Navi stop" })
vim.keymap.set("n", "[n", "<cmd>NaviPrev<CR>", { desc = "Previous Navi stop" })
vim.keymap.set("n", "<leader>np", "<cmd>NaviPick<CR>", { desc = "Pick Navi stop" })
vim.keymap.set("n", "<leader>nc", "<cmd>NaviClear<CR>", { desc = "Clear Navi tour" })

require("which-key").setup({})
require("trouble").setup({})
require("outline").setup({
  outline_window = { position = "left", width = 40 },
})
vim.keymap.set("n", "<F2>", function()
  require("outline").toggle()
end, { desc = "Toggle outline" })

vim.keymap.set("n", "<F3>", function()
  vim.cmd.UndotreeToggle()
  vim.cmd.UndotreeFocus()
end, { desc = "Toggle undo tree" })

require("twoslash-queries").setup({ is_enabled = true, multi_line = true })
vim.keymap.set("n", "ti", "<cmd>TwoslashQueriesInspect<CR>", { desc = "[T]ypescript [I]nspect" })
