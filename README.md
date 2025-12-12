# 🧰 Lvim Config File (including simple necessary tools)
This config file for *Lunar Vim*, contains some essenitial features for daily users and developers.
This `.lua` file contains tools such as:
1. Real-Time diagnostics
2. Code formatting and linting on save
3. Hover window to make diagnostics readable

which you can use the whole file as your config or just copying necessary parts.

> **Prerequisits:**
> 
> Make sure that necessary LSPs, formatters, and linters - for your language in question - are installed through `:Mason`, then go for editing the `config.lua`.
>

## ⚙️ Installation
This config file can be used both as whole or just adding necessary lines to your current `config.lua`


> **CAUTION**
> 
> Make sure you have a backup from your current config file to avoid any possible malfunctionality.
> Also, if you wish to add some parts, ensure that your other plugins and command, won't make conflict.
>

> **NOTE**
> 
> This `config.lua` is tested on a $${\color{orange}Linux}$$ system, but same method is applied to other systems.
> 

### For installation as whole
Clone the repository via:
```bash
git clone https://github.com/parsa-nedaei/Lvim-Config-File.git
```
which then followed by to replace your current `config.lua` by this one:
```bash
cp Lvim-Config-File/.config/lvim/config.lua ~/.config/lvim/config.lua
```
> **Or:** you can just download the `config.lua` and replace it manually

## 🔌 Plugins
### 1. OneDark Theme
Actually, this is not a theme at all, but for dark mode lovers, this plugin will cast a bit more contrast to lvim. 
This plugin is installed via following lines within `lvim.plugin = {}` argument:
```lua
  { 
    "navarasu/onedark.nvim",
     priority = 1000, -- make sure to load this before all the other start plugins
     config = function() require('onedark').setup {
      style = 'darker'
      },
  require('onedark').load()
  end
  },
```
Line ``priority = 1000`` ensures that theme loads at highest priority, before others and ``style= 'darker'`` is chosed for *darker* variant (any other variants can be chosed by user).
> Read more at [onedark.nvim](https://github.com/navarasu/onedark.nvim)

### 2. Julia Syntax Highlighting and $${\LaTeX{}}$$ Support
If you work with Julia, having Latex support in addition to syntax highlighting is necessary.
Lines for this purpose:
```lua
  { 
    "JuliaEditorSupport/julia-vim",
  },
```
> Read more at [julia-vim](https://github.com/JuliaEditorSupport/julia-vim)

## 📰 LSP Diagnostics Configuration
### 1. Real-Time Diagnostics Updates
Since I started to use lvim, this was one of my problems, so I searched to see if anyone solved it or not, and I've found the answer!
Following lines are solution to this problem, which wipe out the need for `<leader>lw` command to see diagnostics:
```lua
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- delay update diagnostics
    update_in_insert = true,
  }
)
```
which of course, enables diagnostics even in `:INSERT` mode. But you may come up with the problem of **unreadable diagnositcs** that can be solved by adding floating diagnostics window and disabling *in text diagnostics* for the ones who are using monitors with low resolution.
### 2. Hover Diagnostics Window
By defualt, diagnostics are shown as colored inline texts, that may get out of window and be unreadable. So the following lines are used to make diagnostics show up on floating windows. 
First, inline text should be disabled by following lines:
```lua
vim.diagnostic.config({
  virtual_text = false -- disables inline text
})
```
Now we can turn on floating window diagnostics
```lua
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
```
The line `vim.o.updatetime` sets the delay time before triggering the cursor hold, and the arguments within `vim.cmd[[]]` will be used for:

- `autocmd CursorHold,CursorHoldI`: Triggers when the cursor stays still for the time set in `vim.o.updatetime`.
- `vim.diagnostic.open_float(nil, {focus=false})`: Opens a floating window showing diagnostic details (`focus=false` keeps focus on the editor, allowing you to continue working while viewing diagnostics).

## 🖌️ Code Quality Features
### 1. Automatic Linting
First, you must ensure that proper linters are installed through `:Mason` e.g., *eslint*,*shellcheck*,... Then each time linting happens just by `:w`:
```lua
lvim.lint_on_save = true
```
This will catch code quality issues and style violations immediately.

### 2. Automatic Format
Again, ensure that formatters for your language in question are installed through `:Mason` (I use `prettier`):
```lua
lvim.format_on_save = true
```
This automatically format your code according to configured style rules designed by the formatter.
> **NOTE:** *Sometimes it becomes annoying!* - can be disable, to make manual formatting possible, via replacing `true` with `false`:
>```lua
>lvim.format_on_save = false
>```

## 🖋️ Summary
This `config.lua` is gathered from other repos and issues on github. The lines are used to solve some common problems such as real-time diagnostics, formatting, and linting.I used this config for `Rust` and `C`, and worked for me.
> **My LSPs, Linters, and Formatters:**
>
> `rust-analyzer`, `clangd`, `flake8`, `proselint`, `shellcheck`, `prettier`, `prettierd`, `clang-format`, and `ast-grep`.
>
Of course I'll search for other common problems for `lvim` configuration, and add it to this repo as soon as possible.
