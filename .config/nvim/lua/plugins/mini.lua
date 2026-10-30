require("mini.ai").setup({})
require("mini.comment").setup({})
require("mini.move").setup({})
require("mini.surround").setup({})
require("mini.cursorword").setup({})
require("mini.indentscope").setup({})
require("mini.pairs").setup({})
require("mini.trailspace").setup({})
require("mini.bufremove").setup({})
require("mini.icons").setup({})
require("mini.statusline").setup({ use_icons = true })

require("mini.diff").setup({
  view = {
    style = "sign",
    signs = { add = "▎", change = "▎", delete = "▎" },
  },
})
require("mini.git").setup({})

local hipatterns = require("mini.hipatterns")
hipatterns.setup({
  highlighters = {
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHiPatternsTodo" },
    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHiPatternsFixme" },
    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHiPatternsHack" },
    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHiPatternsNote" },
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

vim.keymap.set("n", "<leader>hb", function()
  require("mini.git").show_at_cursor()
end, { desc = "Git blame/show" })
