return {
  {
    "nvim-mini/mini.nvim",
    version = false, -- follow trunk
    config = function()
      require("mini.icons").setup()
      require("mini.tabline").setup()
      require("mini.statusline").setup { use_icons = true }
      require("mini.files").setup { windows = { preview = true } }
      require("mini.completion").setup()
      require("mini.pairs").setup()
      require("mini.pick").setup()
      require("mini.trailspace").setup()
      require("mini.starter").setup()

      require("mini.move").setup {
        mappings = {
          left = '<M-Left>',
          right = '<M-Right>',
          down = '<M-Down>',
          up = '<M-Up>',

          line_left = '<M-Left>',
          line_right = '<M-Right>',
          line_down = '<M-Down>',
          line_up = '<M-Up>',
        }
      }

      local hipatterns = require("mini.hipatterns")
      hipatterns.setup {
        highlighters = {
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack  = { pattern = "%f[%w]()HACK()%f[%W]",  group = "MiniHipatternsHack"  },
          todo  = { pattern = "%f[%w]()TODO()%f[%W]",  group = "MiniHipatternsTodo"  },
          note  = { pattern = "%f[%w]()NOTE()%f[%W]",  group = "MiniHipatternsNote"  },
          hex_color = hipatterns.gen_highlighter.hex_color(),
        }
      }
    end,
    init = function()
      -- mini.trailspace
      vim.keymap.set("n", "<leader>tt", function()
        MiniTrailspace.trim()
        MiniTrailspace.trim_last_lines()
      end)

      -- mini.files
      vim.keymap.set("n", "<leader>.", function() MiniFiles.open() end)

      -- mini.pick
      vim.keymap.set("n", "<leader>pf", ":Pick files<CR>")
      vim.keymap.set("n", "<leader>pb", ":Pick buffers<CR>")
      vim.keymap.set("n", "<leader>pg", ":Pick grep_live<CR>")
    end
  }
}
