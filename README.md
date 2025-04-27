# dotfiles
Only works on Mac.


### Requirements
Install `brew` if not installed
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Installation
The scripts use force symlinks which might overwrite your current configuration files. <br>
By default the links will be to the `~/.config/` directory.

```bash
cd ~
git clone git@github.com:brevw/dotfiles.git
cd dotfiles
chmod +x install.sh
./install.sh
```
