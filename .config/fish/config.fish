if test -f ~/.config/fish/local.env.fish
    source ~/.config/fish/local.env.fish
end

# MCP secrets (untracked), read by ~/.claude/mcp.json and opencode.json
if test -f ~/.config/fish/mcp.env.fish
    source ~/.config/fish/mcp.env.fish
end

# Shared skills come from ~/.agents/skills; keeps account-synced Claude skills out of OpenCode
set -gx OPENCODE_DISABLE_CLAUDE_CODE_SKILLS 1

/opt/homebrew/bin/brew shellenv | source

if status is-interactive
    set -lx PATH_DIRECTORIES \
        $HOME/.local/bin \
        /Applications/WezTerm.app/Contents/MacOS \
        /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin

    set -x PATH $PATH_DIRECTORIES $PATH

    set -gx EDITOR nvim

    # git
    alias gaa="git add -A"
    alias gce="git checkout"
    alias gcm="git commit"
    alias gpp="git push"
    alias gfp="git fetch origin --prune"
    alias gpl="git pull"
    alias gss="git status"
    alias gll="git log"
    alias gllo="git log --oneline"
    alias gbb="git branch"
    alias lg="lazygit"
    source ~/.config/fish/custom/git-things.fish

    # bin
    alias ls="eza"
    alias cat="bat"
    alias find="fd"
    alias copy="pbcopy <"
    alias v="nvim"
    alias vim="nvim"
    alias python="python3"

    # development
    alias p="pnpm"

    # directories
    alias pro="cd ~/Projects"

    # config files
    alias nvimrc="vim ~/.config/nvim"
    alias herdrrc="vim ~/.config/herdr"
    alias fishrc="vim ~/.config/fish/config.fish"
    alias weztermrc="vim ~/.config/wezterm/wezterm.lua"

    # utils
    alias work="timer 25m && terminal-notifier -message 'Pomodoro'\
        -title 'Work Timer is up! Take a Break 😊'\
        -sound Crystal"

    alias rest="timer 5m && terminal-notifier -message 'Pomodoro'\
        -title 'Break is over! Get back to work 😬'\
        -sound Crystal"

    # Disable done.fish window detection at startup
    set -g __done_allow_nongraphical 1

    fish_vi_key_bindings
end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
mise activate fish | source

direnv hook fish | source

# TokyoNight Color Palette
set -l foreground c0caf5
set -l selection 2e3c64
set -l comment 565f89
set -l red f7768e
set -l orange ff9e64
set -l yellow e0af68
set -l green 9ece6a
set -l purple 9d7cd8
set -l cyan 7dcfff
set -l pink bb9af7

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_option $pink
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
set -g fish_pager_color_selected_background --background=$selection
