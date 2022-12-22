### BREW + FZF
# install multiple packages at once
# mnemonic [B]rew [I]nstall [P]lugin

bip() {
  local inst=$(brew formulae | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[brew:install]'")

  if [[ $inst ]]; then
    for prog in $(echo $inst)
    do brew install $prog
    done
  fi
}


### BREW + FZF
# update multiple packages at once
# mnemonic [B]rew [U]pdate [P]lugin
bup() {
  local upd=$(brew leaves | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[brew:update]'")

  if [[ $upd ]]; then
    for prog in $(echo $upd)
    do brew upgrade $prog
    done
  fi
}

### BREW + FZF
# uninstall multiple packages at once, async
# mnemonic [B]rew [C]lean [P]lugin (e.g. uninstall)
bcp() {
  local uninst=$(brew leaves | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[brew:clean]'")

  if [[ $uninst ]]; then
    for prog in $(echo $uninst)
    do brew uninstall $prog
    done
  fi
}

### PATH
# mnemonic: [F]ind [P]ath
# list directories in $PATH, press [enter] on an entry to list the executables inside.
# press [escape] to go back to directory listing, [escape] twice to exit completely
fp(){
  local loc=$(echo $PATH | sed -e $'s/:/\\\n/g' | eval "fzf ${FZF_DEFAULT_OPTS} --header='[find:path]'")

  if [[ -d $loc ]]; then
    echo "$(rg --files $loc | rev | cut -d"/" -f1 | rev)" | eval "fzf ${FZF_DEFAULT_OPTS} --header='[find:exe] => ${loc}' >/dev/null"
    fp
  fi
}
