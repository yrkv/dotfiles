
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    --use 'sickill/vim-monokai'
    use 'crusoexia/vim-monokai'

    use 'feline-nvim/feline.nvim'

    use 'lewis6991/gitsigns.nvim'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }

    use 'williamboman/mason.nvim'

    use 'neovim/nvim-lspconfig'

    use 'folke/which-key.nvim'

    use 'norcalli/nvim-colorizer.lua'

    use 'lukas-reineke/indent-blankline.nvim'

    use 'lewis6991/impatient.nvim'

    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    use { 'ellisonleao/gruvbox.nvim' }

    --use 'dense-analysis/ale'
end)

