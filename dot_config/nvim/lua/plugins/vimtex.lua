return {
  "lervag/vimtex",
  enabled = false,
  init = function()
    vim.g.vimtex_view_method = "skim"
    vim.g.vimtex_quickfix_mode = 0
    vim.g.vimtex_view_automatic = 1
    vim.g.vimtex_compiler_latexmk = { out_dir = "build" }
  end
}
