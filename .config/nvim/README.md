# Neovim config

`init.lua` loads modules in order: options → keymaps → autocmds → plugins → LSP.
Uses native `vim.pack` and `vim.lsp.config` on the installed Neovim development build.

- `lua/config/options.lua`: editor options, leaders, provider settings.
- `lua/config/keymaps.lua`: general editor mappings.
- `lua/config/autocmds.lua`: yank highlighting, cursor restore, prose settings.
- `lua/plugins/init.lua`: plugin sources, install/update hooks, setup order.
- `lua/plugins/*.lua`: plugin setup and related mappings; small integrations share `editor.lua`.
- `lua/config/lsp/init.lua`: shared capabilities, server settings, enabled servers.
- `lua/config/lsp/`: attach mappings, diagnostics, hover workaround, formatting, efm, TypeScript selection.

Add plugins in `lua/plugins/init.lua`, then require their config there.
Add Mason tools in `lua/plugins/mason.lua`; installation alone doesn't enable an LSP server.
Configure and enable servers in `lua/config/lsp/init.lua`.
For efm, add a language in `lua/config/lsp/efm.lua`; filetypes are derived automatically.

Restart Neovim after edits: `require()` caches modules, so sourcing `init.lua` won't reload them.
Keep `nvim-pack-lock.json` tracked to preserve plugin versions.
