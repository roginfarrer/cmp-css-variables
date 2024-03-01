# cmp-css-variables

> [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) source for global CSS variables in a project.
 
![Demo gif](https://github.com/roginfarrer/cmp-css-variables/assets/9063669/07cae9b1-4d3c-44bd-8d78-7ad82a556e94)

If `vim.g.css_variables_files` is set, variables in that file will
available globally. Set it to a table of file paths, relative to the current working directory. The working directory will
be searched for a file with that path.

It's expected that this completion source is used with the CSS language server, which provides completion for CSS variables defined within the file. So this completion source only supplies the values defined in `vim.g.css_variables_files`, not those defined in the current file.

This completion source will be active in the following filetypes: `css`, `less`, `scss`, and `sass`.

## Installation & Setup

With [lazy](https://github.com/folke/lazy.nvim):

```lua
{
  'hrsh7th/nvim-cmp',
  dependencies = { 'roginfarrer/cmp-css-variables' },
  config = function()
    require'cmp'.setup {
      sources = {
        { name = 'css-variables' }
      }
    }
  end
}
```

This completion source will pull from files defined in `vim.g.css_variables_files`.

```lua
vim.g.css_variables_files = { "variables.css" }
```

You probably will want to specify the files with global CSS variables on a per-project basis. Using Neovim's `exrc` setting, you can put a `.nvim.lua` file in the root of your project's directory with this defined there.
