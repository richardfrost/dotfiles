# FNM (Fast Node Manager)
[FNM Github Page](https://github.com/Schniz/fnm)

## Installation
```sh
# Override install directory
# curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "./.fnm" --skip-shell

# Install to default location using $XDG_DATA_HOME/fnm or $HOME/.local/share/fnm
curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
```

### Setup default node
```sh
# List available versions to install
fnm list-remote

# List installed versions
fnm list

# Install node version
fnm install v20

# Set default version
fnm default v20
```
