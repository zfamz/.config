export EDITOR=nvim
# cargo
export PATH="$HOME/.cargo/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
# pnpm end

# proxy end
proxy () {
  proxyShell() {
    export all_proxy=socks5://127.0.0.1:7890
  }
  proxyGit() {
    git config --global http.proxy socks5://127.0.0.1:7890
    git config --global https.proxy socks5://127.0.0.1:7890
  }
  if [[ '-a' == $1 ]] {
    proxyShell
    proxyGit
  } elif [[ '-g' == $1 ]] {
    proxyGit
  } else {
    proxyShell
  }
}
unproxy () {
  unproxyShell() {
    unset all_proxy
  }
  unproxyGit() {
    git config --global --unset http.proxy
    git config --global --unset https.proxy
  }
  if [[ '-a' == $1 ]] {
    unproxyShell
    unproxyGit
  } elif [[ '-g' == $1 ]] {
    unproxyGit
  } else {
    unproxyShell
  }
}
# proxy
