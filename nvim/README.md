# Neovim config

* Plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager
    that is automatically downloaded at first launch typically in `~/.local/share/nvim/lazy/lazy.nvim`.
    Plugins are automatically downloaded in `~/.local/share/nvim/lazy`

Brief description:
* `~/.config/nvim/init.lua` executed first. Initializes plugin manager, global variables and functions
* `plugin/` contains automatically sourced scripts with no dependencies
* `after/plugin/` contains scripts that are automatically sourced in the last order. Typically they configure plugins and setup stuff that depends on them
* `colors/` contains colorschemes available for `:colorcheme <scheme>`, where file name defines colorscheme name
* `lua/` contains custom scripts that are loaded using `require(...)`
* `lua/custom/plugins/` contains a set of lua tables that lists plugins to (lazy) load

## Telescope
1. Install [ripgrep](https://github.com/BurntSushi/ripgrep) - grep alternative  
  `sudo apt install ripgrep`
1. Install [fd](https://github.com/sharkdp/fd) - find alternative  
  `sudo apt install fd-find`

## Language Server Protocol (LSP) servers
1. Lua: [lua_ls](https://github.com/LuaLS/lua-language-server)
  * Download [binaries](https://github.com/LuaLS/lua-language-server/releases)
    * Or `pacman -Si lua-language-server`
  * Executable does not like being a symlink, so make PATH-visible [script](https://github.com/luals/lua-language-server/wiki/Getting-Started#command-line)
    ```
    #!/bin/bash
    exec "~/libs/lua-language-server-3.7.3-linux-x64/bin/lua-language-server" "$@"
    ```
2. C/C++: [clangd](https://clangd.llvm.org/)
  * `sudo apt install clangd`
3. Python: [pyright](https://github.com/microsoft/pyright)
  * Install [nodejs](https://nodejs.org/en/)
  * Run `npm install --global pyright`

## Debug Adapter Protocol (DAP)
1. Install C/C++ debugger adapter: [vscode-cpptools](https://github.com/microsoft/vscode-cpptools)
  <!-- [Guide](https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(gdb-via--vscode-cpptools)) -->
  * Download [binaries](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
    * See "Download extension" in right menu
  * Unzip and make OpenDebugAD7 PATH-visible:
    ```
    mkdir cpptools-linux && unzip cpptools-linux.vsix -d cpptools-linux
    chmod +x cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7
    ```
## Other
* Install xclip `sudo apt install xclip`

