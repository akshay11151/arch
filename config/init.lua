-- Disable compatibility with older versions of Vim
vim.opt.compatible = false

-- Show matching brackets
vim.opt.showmatch = true

-- Highlight search results
vim.opt.hlsearch = true

-- Incremental search that shows results as you type
vim.opt.incsearch = true

-- Set tab width to 4 spaces
vim.opt.tabstop = 4

-- Enable automatic indentation
vim.opt.autoindent = true

-- Show line numbers
vim.opt.number = true

-- Command-line completion mode
vim.opt.wildmode = {'longest', 'list'}

-- Enable syntax highlighting
vim.cmd('syntax on')

-- Enable mouse support
vim.opt.mouse = 'a'

-- Use the system clipboard
vim.opt.clipboard = 'unnamedplus'

-- Enable filetype plugins and indenting
vim.cmd('filetype plugin indent on')

-- Highlight the current line
vim.opt.cursorline = true

-- Faster redrawing on screen updates
vim.opt.ttyfast = true

-- Customize background transparency for Normal and NonText groups
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NonText', { bg = 'none' })

-- Plugin setup using vim-plug
vim.cmd([[
  call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
  Plug 'glepnir/dashboard-nvim'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}  
  Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'} 
  Plug 'nvim-tree/nvim-web-devicons' 
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'nvim-orgmode/orgmode'
  Plug 'backdround/global-note.nvim'
  Plug 'folke/twilight.nvim'
  call plug#end()
]])

-- Telescope configuration
require('telescope').setup{}

-- Dashboard configuration
local db = require('dashboard')

require'nvim-treesitter.configs'.setup {
  -- Ensure installed parsers (choose those you want)
  ensure_installed = { "c", "cpp", "lua", "python", "javascript", "html", "css" }, -- specify the languages you want support for
  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- Enable highlighting with Treesitter
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,  -- Disable standard Vim syntax highlighting
  },
}

-- COQ.nvim Setup
vim.g.coq_settings = {
  auto_start = 'shut-up', -- Automatically start COQ.nvim without asking
}

require('coq') -- Initialize COQ.nvim

-- Setup nvim-tree
require'nvim-tree'.setup {
  -- disables netrw completely
  disable_netrw       = true,
  -- hijack netrw window on startup
  hijack_netrw        = true,
  -- update the cursor when navigating the tree
  update_cwd          = true,
  -- show git status icons in the tree
  git                 = {
    enable = true,
  },
  view = {
    width = 30,
    side = 'left',
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
  },
}

-- Keybinding to toggle nvim-tree
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- init.lua

require('orgmode').setup({
  org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
  org_default_notes_file = '~/Dropbox/org/refile.org',
})

-- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
-- add ~org~ to ignore_install
-- require('nvim-treesitter.configs').setup({
--   ensure_installed = 'all',
--   ignore_install = { 'org' },
-- })

local global_note = require("global-note")
global_note.setup()

vim.keymap.set("n", "<leader>n", global_note.toggle_note, {
  desc = "Toggle global note",
})

db.setup({
  theme = 'doom',
  config = {
    header = {
      '',
      '███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
      '████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║',
      '██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║',
      '██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
      '██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
      '╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
      '',
      '          Welcome to Neovim - Happy coding!          ',
      '',
    },
    center = {
      {
        icon = ' ',
        icon_hl = 'Title',
        desc = 'Find File',
        desc_hl = 'String',
        key = 'f',
        keymap = 'SPC f f',
        key_hl = 'Number',
        action = 'lua require("telescope.builtin").find_files()'
      },
      {
        icon = ' ',
        desc = 'New File',
        key = 'n',
        keymap = 'SPC f n',
        action = 'enew'
      },
      {
        icon = ' ',
        desc = 'Recent Files',
        key = 'r',
        keymap = 'SPC f r',
        action = 'lua require("telescope.builtin").oldfiles()'
      },
      {
        icon = ' ',
        desc = 'Config',
        key = 'c',
        keymap = 'SPC f c',
        action = function()
        vim.cmd('edit ~/.config/nvim/init.lua')
		end
      },
    },
    footer = {"", "Neovim loaded "}
  }
})

-- Set dashboard as the default buffer when Neovim starts
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 and vim.fn.line2byte('$') == -1 then
      vim.cmd('Dashboard')
    end
  end,
})

