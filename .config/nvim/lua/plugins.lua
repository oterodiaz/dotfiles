vim.api.nvim_create_augroup('vim_plug_augroup', {
  clear = false
})

vim.api.nvim_create_autocmd('BufWritePost', {
  desc = 'Source this file when it is updated',
  group = 'vim_plug_augroup',
  pattern = '*/nvim/lua/plugins.lua',
  command = 'source <afile>'
})

local data_dir = vim.fn.stdpath('data') .. '/site'
if vim.fn.empty(vim.fn.glob(data_dir .. '/autoload/plug.vim')) > 0 then
  vim.api.nvim_create_user_command('InstallVimPlug', '!curl -fLo ' .. data_dir .. '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim', {})
  print('VimPlug is not installed, run :InstallVimPlug')
end
local data_dir = vim.fn.stdpath('data') .. '/site'

local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
  Plug('sonph/onehalf', { rtp = 'vim' })
  Plug('catppuccin/nvim', { as  = 'catppuccin' })
  Plug('ap/vim-css-color')
  Plug('KabbAmine/vCoolor.vim')
  Plug('kyazdani42/nvim-web-devicons')
  Plug('kyazdani42/nvim-tree.lua')
  Plug('numToStr/Comment.nvim')
  Plug('nvim-lualine/lualine.nvim')
  Plug('dag/vim-fish')
  Plug('cocopon/iceberg.vim')
  Plug('windwp/nvim-autopairs')
  Plug('ms-jpq/coq_nvim', { branch = 'coq' })
  Plug('ms-jpq/coq.artifacts', { branch = 'artifacts' })
  Plug('ms-jpq/coq.thirdparty', { branch = '3p' })
  Plug('tanvirtin/monokai.nvim')

vim.call('plug#end')

vim.cmd [[ let g:vcoolor_custom_picker = 'kcolorchooser --print --color ' ]]

require('nvim-tree').setup({
  view = {
    side = 'right',
    width = 35
  }
})

require('Comment').setup()

require('lualine').setup({
  options = {
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_z = { 'location' }
  }
})

require('nvim-autopairs').setup()

vim.g.coq_settings = {
    auto_start = 'shut-up',
}

require('monokai').setup({
  palette = {
    base2 = '#242424',
  },
})
