local snacks = require("snacks")
snacks.setup({
  bigfile = { enabled = true },
  image = {
    enabled = true,
    -- Herdr supports Kitty graphics but is not detected by Snacks yet.
    force = vim.env.TERM_PROGRAM == "herdr",
    doc = { inline = vim.env.TERM_PROGRAM ~= "herdr" },
  },
  input = { enabled = true },
  notifier = { enabled = true },
  picker = { enabled = true, ui_select = true, layout = { preset = "telescope" } },
})

vim.keymap.set("n", "<leader>sf", function()
  snacks.picker.files()
end, { desc = "Search Files" })
vim.keymap.set("n", "<leader>sg", function()
  snacks.picker.grep()
end, { desc = "Search Grep" })
vim.keymap.set("n", "<leader>?", function()
  snacks.picker.recent({ filter = { cwd = true } })
end, { desc = "Search Recent Files" })
