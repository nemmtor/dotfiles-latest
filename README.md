Instructions:

1. Backup existing config:

```bash
cp -R ~/.config ~/.config.bak
```

2. Homebrew + packages:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew trust --formula caarlos0/tap/timer anomalyco/tap/opencode-v2 asmvik/formulae/yabai felixkratz/formulae/sketchybar felixkratz/formulae/borders
brew install fish herdr git gh fd ripgrep bat eza fzf jq tree lazygit cmake mise direnv pnpm yarn gitleaks tree-sitter-cli aws-vault awscli act terminal-notifier caarlos0/tap/timer anomalyco/tap/opencode-v2 asmvik/formulae/yabai felixkratz/formulae/sketchybar felixkratz/formulae/borders fastfetch
brew install --HEAD neovim
brew install imagemagick ghostscript tectonic
brew install --cask wezterm@nightly orbstack 1password alfred google-chrome slack tableplus openvpn-connect visual-studio-code font-hack-nerd-font font-sketchybar-app-font handy
```

3. GitHub SSH access (choose SSH, upload a new key), then make `~` the repo:

```bash
gh auth login
cd ~ && git init -b main && git remote add origin git@github.com:nemmtor/dotfiles-latest.git && git fetch origin && git reset --hard origin/main && git branch -u origin/main
```

4. Fish as login shell + plugins:

```bash
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells && chsh -s /opt/homebrew/bin/fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update
```

5. Nix + direnv (repos with `flake.nix`), mise for the rest:

```bash
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
nix profile install nixpkgs#nix-direnv
mise install
```

mise supplies Node.

Neovim uses the workspace's `node_modules/.bin/tsc` (or `tsgo`) for TypeScript 7+ native LSP. Older projects use Mason's `typescript-language-server` (`ts_ls`); global TypeScript binaries are ignored. Restart Neovim after installing or changing a project's TypeScript version. To opt a project into native LSP, upgrade its TypeScript dev dependency to 7+ using that project's package manager.

6. AI skills: shared by Claude Code, Codex and OpenCode. They live in `~/.agents/skills`, and Claude reaches them through symlinks in `~/.claude/skills`. Add new ones with:

```bash
npx skills add <owner/repo> -g -a claude-code -a codex -a opencode -s <skill>
```

For a local skill, put it in `~/.agents/skills/<name>` and run `ln -s ../../.agents/skills/<name> ~/.claude/skills/<name>`.

Modularity review/design follow this shared layout. OpenCode slash commands live in `~/.config/opencode/commands`. Their upstream workflows and HTML template are vendored under `~/.agents/skills/modularity-review/references/upstream`, so a fresh checkout needs no extra download.

Global agent rules live in `~/.agents/AGENTS.md`, symlinked as `~/.claude/CLAUDE.md`, `~/.codex/AGENTS.md` and `~/.config/opencode/AGENTS.md`.

7. AI agents and MCP servers:

```bash
curl -fsSL https://claude.ai/install.sh | bash
brew install --cask codex
```

MCP servers are defined in `~/.claude/mcp.json` (Claude) and `~/.config/opencode/opencode.json` (OpenCode); add new servers to both. Secrets stay in the untracked `~/.config/fish/mcp.env.fish`, as `set -gx` lines for `CONTEXT7_API_KEY`, `GITHUB_MCP_TOKEN` and `CIRCLECI_TOKEN`. Claude only reads servers from `~/.claude.json`, so register them there, then log in to the OAuth servers:

```fish
for e in (jq -c '.mcpServers | to_entries[]' ~/.claude/mcp.json); claude mcp add-json -s user (echo $e | jq -r .key) (echo $e | jq -c .value); end
opencode mcp auth linear-server; and opencode mcp auth betterstack
```

8. yabai (tiling, config in `~/.config/yabai/yabairc`). In System Settings > Desktop & Dock > Mission Control, turn on "Displays have separate Spaces" and turn off "Automatically rearrange Spaces based on most recent use". Then run `yabai --start-service` and allow yabai under Privacy & Security > Accessibility.

To upgrade, run `yabai --stop-service && yabai --uninstall-service && brew upgrade yabai`, then `yabai --start-service`.

Optional scripting addition (creating/moving spaces, focusing spaces from yabai, transparency, animations). It is off in `yabairc`: on macOS 27 with yabai 7.1.25 it crash-loops the Dock. Once a release supports your macOS, partly disable SIP: boot to Recovery (hold power, then Options), open Utilities > Terminal and run:

```bash
csrutil enable --without fs --without debug --without nvram
```

Reboot, then allow the scripting addition to load and run as root without a password:

```bash
sudo nvram boot-args=-arm64e_preview_abi
echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai
```

Reboot again, uncomment the `--load-sa` lines in `yabairc` and run `yabai --restart-service`. Rerun the sudoers line after every upgrade (the binary hash changes).

9. SketchyBar (top bar, `~/.config/sketchybar`) and JankyBorders (focused window border, `~/.config/borders/bordersrc`), themed to match WezTerm:

```bash
brew services start felixkratz/formulae/sketchybar
brew services start felixkratz/formulae/borders
```

Hide the native menu bar: System Settings > Menu Bar > "Automatically hide and show the menu bar" > Always, and turn on "Show menu bar background" so the revealed native bar doesn't blend into SketchyBar. The bar height in `sketchybarrc` must match `external_bar` in `yabairc`.

Clicking a space presses ctrl+N, so turn on System Settings > Keyboard > Keyboard Shortcuts > Mission Control > "Switch to Desktop 1..N" and allow sketchybar under Privacy & Security > Accessibility.

Space app icons come from `~/.config/sketchybar/icon_map.json`; refresh it when you upgrade `font-sketchybar-app-font`:

```bash
gh release download -R kvndrsslr/sketchybar-app-font -p icon_map.json -D ~/.config/sketchybar --clobber
```
