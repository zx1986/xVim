### macOS Usage

    make init
    make update

### Ubuntu 22.04 Offline Installation

This repository now includes a complete offline installation solution for Ubuntu 22.04 systems without internet access.

#### Prerequisites (One-time, with Internet)

1. **Download all packages** (on a machine with internet):
   ```bash
   cd ubuntu/offline/scripts
   ./download.sh
   ```

2. **Create offline archive**:
   ```bash
   cd ubuntu
   tar -czf nvim-offline-ubuntu.tar.gz offline/ config/
   ```

3. **Transfer archive** to your offline Ubuntu 22.04 system

#### Installation (Offline System)

1. **Extract archive**:
   ```bash
   tar -xzf nvim-offline-ubuntu.tar.gz
   cd ubuntu/offline/scripts
   ```

2. **Run offline installer**:
   ```bash
   sudo ./install-offline.sh
   # Or for user-only installation (no sudo):
   ./install-offline.sh --user-only
   ```

3. **Verify installation**:
   ```bash
   ./verify.sh
   nvim --headless '+checkhealth' +qa
   ```

#### Testing with Docker

```bash
cd ubuntu/docker
./test-install.sh
```

See [ubuntu/README.md](ubuntu/README.md) for detailed documentation.

### Terminology

- ftdetect: file type detect
- ftplugin: file type plugin
- bundle: Vimbundle a.k.a vundle

    echo $VIMRUNTIME

### References

- https://github.com/amix/vimrc
- https://github.com/vgod/vimrc
- https://github.com/spf13/spf13-vim
- https://github.com/SpaceVim
- https://github.com/neovim
