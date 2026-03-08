return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.enable({
      "basedpyright",
      "sourcekit",
      "lua_ls",
      "kotlin_lsp"
    })

    -- Configure lua lsp for Neovim
    vim.lsp.config('lua_ls', {
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if
            path ~= vim.fn.stdpath('config')
            and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
          then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            version = 'LuaJIT',
            path = {
              'lua/?.lua',
              'lua/?/init.lua',
            },
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
            },
          },
        })
      end,
      settings = {
        Lua = {},
      },
    })
  end,
  init = function()
    vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end)
    vim.keymap.set("n", "<C-K>", function() vim.lsp.buf.hover() end)
  -- Disable lsp-semantic-highlight to prevent
  -- colors from changing when the lsp starts.
  -- for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  --   vim.api.nvim_set_hl(0, group, {})
  -- end
  end
}
