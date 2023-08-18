-- Archivo: ~/.config/nvim/init.lua

-- Inicializa Packer (gestor de plugins)
require('packer').startup(function()
    use 'nvim-tree/nvim-web-devicons'
    -- Plugin para manejar el statusline
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-web-devicons', 'kyazdani42/nvim-tree.lua' }
    }
    
    -- Otros plugins aquí
    -- Plugin para plenary
    use "nvim-lua/plenary.nvim"
    use "nvim-lua/popup.nvim"
    use "nvim-telescope/telescope-media-files.nvim"
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        -- or                            , branch = '0.1.x',
       requires = { {'nvim-lua/plenary.nvim'} }
   }
   
   -- Plugin Buftablin pestanas
   use "ap/vim-buftabline"

   -- Añadir plugin nvim-treesitter con do: ':TSUpdate'
   use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

   -- Instalar plugin coc.nvim desde la rama release
   use { 'neoclide/coc.nvim', branch = 'release' }

   -- Inatalar Comment
   use "terrortylor/nvim-comment"

   -- Instalar NERDTree
   use 'preservim/nerdtree'
   
   -- Instalar Vim Sneak
   use 'justinmk/vim-sneak'
end)



-- Configuración para lualine.nvim
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'horizon',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {}, 
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}


-- Configuracion de nvim-web-devicons
require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  sh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable different highlight colors per icon (default to true)
 -- if set to false all icons will have the default icon's color
 color_icons = true;
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
 -- globally enable "strict" selection of icons - icon will be looked up in
 -- different tables, first by filename, and if not found by extension; this
 -- prevents cases when file doesn't have any extension but still gets some icon
 -- because its name happened to match some extension (default to false)
 strict = true;
 -- same as `override` but specifically for overrides by filename
 -- takes effect when `strict` is true
 override_by_filename = {
  [".gitignore"] = {
    icon = "",
    color = "#f1502f",
    name = "Gitignore"
  }
 };
 -- same as `override` but specifically for overrides by extension
 -- takes effect when `strict` is true
 override_by_extension = {
  ["log"] = {
    icon = "",
    color = "#81e043",
    name = "Log"
  }
 };
}

-- Configuracion de Planary
local async = require "plenary.async"


require('telescope').load_extension('media_files')

-- Configuracion de telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
-- Configuracion de Telescope
require('telescope').setup {
   defaults = {
      vimgrep_arguments = {
         "rg",
         "--color=never",
         "--no-heading",
         "--with-filename",
         "--line-number",
         "--column",
         "--smart-case",
      },
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
         horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
         },
         vertical = {
            mirror = false,
         },
         width = 0.87,
         height = 0.80,
         preview_cutoff = 120,
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = {},
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = { "absolute" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
   },
   extensions = {
      fzf = {
         fuzzy = true, -- false will only do exact matching
         override_generic_sorter = false, -- override the generic sorter
         override_file_sorter = true, -- override the file sorter
         case_mode = "smart_case", -- or "ignore_case" or "respect_case"
         -- the default case_mode is "smart_case"
      },
      media_files = {
         filetypes = { "png", "webp", "jpg", "jpeg" },
         find_cmd = "rg", -- find command (defaults to `fd`)
      },
   },
}
-- Mapeo para abrir Telescope para buscar archivos
vim.api.nvim_set_keymap('n', '<Leader>ff', [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], { noremap = true, silent = true })

-- Mapeo para entrar en la vista previa del archivo
vim.api.nvim_set_keymap('n', '<CR>', [[<Cmd>lua require('telescope.actions').select_default()<CR>]], { noremap = true, silent = true })

-- Configuracion de Buftabline
-- Mapeo para cambiar a la siguiente pestaña
vim.api.nvim_set_keymap('n', '<C-N>', ':bnext<CR>', { noremap = true, silent = true })

-- Mapeo para cambiar a la pestaña anterior
vim.api.nvim_set_keymap('n', '<C-P>', ':bprev<CR>', { noremap = true, silent = true })

-- Configurar Treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "html", "css", "javascript", "lua", "query" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  -- ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- Mapeo visual para formatear la selección usando coc.nvim
vim.api.nvim_set_keymap('x', '<leader>f', '<Plug>(coc-format-selected)', { noremap = true, silent = true })

-- Mapeo normal para formatear la selección usando coc.nvim
vim.api.nvim_set_keymap('n', '<leader>f', '<Plug>(coc-format-selected)', { noremap = true, silent = true })

-- Configuracion de Comment
require('nvim_comment').setup()

-- Configuracion de Commetn
-- Mapeo normal para alternar comentarios usando CommentToggle
vim.api.nvim_set_keymap('n', '<Leader>t', ':CommentToggle<CR>', { noremap = true, silent = true })

-- Mapeo visual para alternar comentarios usando CommentToggle
vim.api.nvim_set_keymap('x', '<Leader>t', ':CommentToggle<CR>', { noremap = true, silent = true })

-- Abrir NERDTree por defecto al inicio de Neovim
vim.api.nvim_command('autocmd StdinReadPre * let s:std_in=1')
vim.api.nvim_command('autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif')

-- Mapeo para abrir o cerrar NERDTree
vim.api.nvim_set_keymap('n', '<Leader>n', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

-- Configuración para Vim Sneak
vim.g['sneak#label'] = 1

-- Mapeo para usar Vim Sneak con 'f'
vim.api.nvim_set_keymap('n', 'f', '<Plug>Sneak_f', {})

-- Mapeo para usar Vim Sneak con 'F'
vim.api.nvim_set_keymap('n', 'F', '<Plug>Sneak_F', {})

