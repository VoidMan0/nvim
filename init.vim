" set-commandse
syntax on
set exrc
set guicursor=
set nu
set hls is
set hidden
set noerrorbells
set smartindent
set smartcase
set noswapfile
set nowrap
set incsearch
set scrolloff=8
set signcolumn=yes
hi! link SignColumn Normal
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set undodir=~/.config/nvim/undodir
set autochdir
set undofile
set splitright
autocmd TermOpen * setlocal nonumber norelativenumber

set colorcolumn=80
highlight ColorColumn ctermbg=8

let g:ranger_map_keys = 0

" end of set-commands
"//////////////////////////////////////////////////////////////////////////////
" Plug configuration

call plug#begin('~/.config/nvim/plugins')

Plug 'neovim/nvim-lspconfig'
Plug 'mfussenegger/nvim-dap'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tpope/vim-commentary'
Plug 'windwp/nvim-autopairs'
Plug 'rbgrouleff/bclose.vim'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'

Plug 'preservim/nerdtree' 
Plug 'sheerun/vim-polyglot'
Plug 'nvim-lua/plenary.nvim'

Plug 'williamboman/nvim-lsp-installer'
if has('nvim')
    Plug 'neovim/nvim-lspconfig'
endif
Plug 'skywind3000/asyncrun.vim'
call plug#end()

" end of Plug configuration
"//////////////////////////////////////////////////////////////////////////////
" map-commands
"
nnoremap <C-f> :NERDTreeToggle<CR>
nnoremap <C-t> :NERDTreeFind<CR>
nnoremap <C-c> :cclose<CR>
noremap <F7> :AsyncRun gcc -O3 -Wall -g -fstack-protector -pedantic -ansi -std=c11 % -lm<CR>:copen 6<CR>
nnoremap <F11> :set spell<CR>
nnoremap <silent> <A-k> :wincmd k<CR>
nnoremap <silent> <A-j> :wincmd j<CR>
nnoremap <silent> <A-h> :wincmd h<CR>
nnoremap <silent> <A-l> :wincmd l<CR>
nnoremap <C-e> :vsplit<CR>:vertical resize -6<CR>

inoremap <silent> <F11> <C-O>:set spell!<CR>

nnoremap <M-BS> :let $VIM_DIR=expand('%:p:h')<CR>:tabnew<CR>:terminal<CR>Acd $VIM_DIR<CR>

tnoremap <C-q> <C-\><C-n><CR>

" End of map-commands
"//////////////////////////////////////////////////////////////////////////////
" Lua functions

lua << EOF

require 'nvim-autopairs'.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.hls.setup{}
require'lspconfig'.pylsp.setup{}
require'lspconfig'.jdtls.setup{}
require'lspconfig'.sumneko_lua.setup{}

require 'nvim-treesitter.configs'.setup{
    highlight={
        enable = true,
        disable = {},
    },
    indent = {
            enable = true,
    },
    ensure_installed = {
        "java",
        "make",
        "c",
        "haskell",
        "python",
        "lua"
    }
}

------------------------------------------------------------------------------

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
  local opts = {}
  server:setup(opts)
end)

------------------------------------------------------------------------------
--nvim-cmp


 require("luasnip.loaders.from_vscode").load()
 local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },

     mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      },

    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
  })

  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  require('lspconfig')['clangd'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['hls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['pylsp'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['jdtls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['sumneko_lua'].setup {
    capabilities = capabilities
  }
EOF

" End of Lua functions
