if status is-interactive
    # Commands to run in interactive sessions can go here
    pyenv init - fish | source
end

# Neovim TUI uses COLORTERM=truecolor as a 24-bit color hint.
set -gx COLORTERM truecolor

# opencode
if command -q opencode
    fish_add_path /home/allen/.opencode/bin
end

if command -q go
    fish_add_path (go env GOPATH)/bin
end

alias zed='flatpak run dev.zed.Zed'

# uv
fish_add_path "/home/allen/.local/bin"
fish_add_path /home/allen/AppImages
