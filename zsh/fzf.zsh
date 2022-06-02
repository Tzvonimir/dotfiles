# Credit to ismirnov: https://github.com/issmirnov/dotfiles/blob/master/zsh/config/fzf.zsh

# does local file search, from current directory, displays file in bat
function showl() {
    local file
    file=$(fzf --query="$*" --select-1 --exit-0)
    [ ! -n "$file" ] && echo "no results found" && return -1
    [ -f "$file" ] && bat "$file"
    [ -d "$file" ] && cd "$file"
}

# global file search -> vim
function vf() {
  local file;
  file="$(locate / | fzf --query="$*" --select-1 --exit-0)";
  [ ! -n "$file" ] && echo "no results found" && return -1
  [ -f "$file" ] && vim "$file"
  [ -d "$file" ] && echo "Result is a directory, running cd" && cd "$file"
}

# Pick file to edit
function vfe() {
  local file
  file=$(fzf --exact --height 40% --reverse --query="$*"  --select-1 --exit-0)
  [ ! -n "$file" ] && echo "no results found" && return -1
  [ -f "$file" ] && vim "$file"
  [ -d "$file" ] && echo "Result is a directory, running cd" && cd "$file"
}

# Search through all files with rg, then open file at location
# Requires Vim to have https://github.com/wsdjeg/vim-fetch
function vaf(){
  if [ !  "$*" ]; then
    echo "Usage: $0 search_term"
    exit 1
  fi
  local file
  file=$(rg -U $* | fzf --select-1 | cut -d':' -f -2)
  [ -n "$file" ] && vim "$file"
}

# Navigation functions from https://github.com/nikitavoloboev/dotfiles/blob/master/zsh/functions/fzf-functions.zsh#L1
# fa <dir> - Search dirs and cd to them
fa() {
  local dir
  dir=$(fd --type directory | fzf --no-multi --query="$*") &&
  cd "$dir"
}

# fah <dir> - Search dirs and cd to them (included hidden dirs)
fah() {
  local dir
  dir=$(fd --type directory --hidden --no-ignore | fzf --no-multi --query="$*") &&
  cd $dir
}

# global:  cd into the directory of the selected file
# similar to 'zz', but this one does a full global file search
fl() {
  local file
  local dir
  file=$(locate / | fzf +m -q "$*") && dir=$(dirname "$file") && cd "$dir"
  ls
}

# cd into the directory of the selected file
fll() {
  local file
  local dir
  file=$(fzf +m -q "$*") && dir=$(dirname "$file") && cd "$dir"
  ls
}


# Search env variables
fenv() {
  local out
  out=$(env | fzf)
  # echo $(echo $out | cut -d= -f2)
  echo $(echo $out)
}


cd..(){
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
  cd "$DIR"
}

# search source code, then pipe files with 10 line buffer into fzf preview using bat.
# requirements:
# - fzf: https://github.com/junegunn/fzf
# - rg: https://blog.burntsushi.net/ripgrep/
# - bat: https://github.com/sharkdp/bat
# Notes:
#  - Same goes for bat, although ccat and others are definitely worse
#  - the $ext extraction uses a ZSH specific text globber
s(){
  local margin=5 # number of lines above and below search result.
  local preview_cmd='search={};file=$(echo $search | cut -d':' -f 1 );'
  preview_cmd+="margin=$margin;" # Inject value into scope.
  preview_cmd+='line=$(echo $search | cut -d':' -f 2 );'
  preview_cmd+='tail -n +$(( $(( $line - $margin )) > 0 ? $(($line-$margin)) : 0)) $file | head -n $(($margin*2+1)) |'
  preview_cmd+='bat --paging=never --color=always --style=full --file-name $file --highlight-line $(($margin+1))'
  local full=$(rg "$*" \
    | fzf --select-1 --exit-0 --preview-window up:$(($margin*2+1)) --height=60%  --preview $preview_cmd)
  local file="$(echo $full | awk -F: '{print $1}')"
  local line="$(echo $full | awk -F: '{print $2}')"
  [ -n "$file" ] && vim "$file" +$line
}