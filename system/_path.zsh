export PATH="./bin:/usr/local/bin:/usr/local/sbin:$DOTFILES/bin:$PATH"
export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"

# Add system ruby bin to path
if which ruby > /dev/null 2>&1 && which gem > /dev/null 2>&1; then
  export PATH="$PATH:$(ruby -rubygems -e 'puts Gem.user_dir')/bin"
fi
