return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  init = function()
    local langs = {
      "lua",
      "swift",
      "kotlin",
      "zig",
      "go",
      "ruby",
      "python",
      "c",
      "cpp",
      "vim",
      "vimdoc",
      "markdown",
      "markdown_inline",
      "query",
      "javascript",
      "typescript",
      "svelte",
      "sql",
      "json",
      "bash",
      "fish",
      "zsh",
      "terraform",
      "html",
      "css",
      "yaml",
      "toml",
      "diff"
    }

    require("nvim-treesitter").install(langs)

    -- custom file:language mappings
    vim.filetype.add({
      filename = {
        ["Fastfile"] = "ruby",
      }
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = langs,
      callback = function(args)
        -- syntax highlighting, provided by Neovim
        vim.treesitter.start()

        -- folds, provided by Neovim
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldmethod = "expr"

        -- indentation, provided by nvim-treesitter (experimental)
        -- enabled only if there is an indents.scm query for that language
        -- falls back to default Neovim indentation otherwise
        local filetype = args.match
        local lang = vim.treesitter.language.get_lang(filetype) or filetype
        local has_indent_query = vim.treesitter.query.get(lang, "indents")
        if has_indent_query then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end
}
