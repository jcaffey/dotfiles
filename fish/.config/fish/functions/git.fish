function gb --description "Checkout git branch with fzf"
  git checkout (git branch -a | fzf | tr -d ' ')
end
