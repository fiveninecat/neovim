-- See https://github.com/wbthomason/packer.nvim for more info.

return require('packer').startup(function(use)

    -- Use Packer to manage itself.
    -- See https://github.com/wbthomason/packer.nvim for more info.
    use 'wbthomason/packer.nvim'

    -- Use plenary.nvim, which is a dependency for other plugins.
    -- See https://github.com/nvim-lua/plenary.nvim for more info.
    use "nvim-lua/plenary.nvim"

    -- Use tokyonight.nvim, which is a colorscheme.
    -- See https://github.com/folke/tokyonight.nvim for more info.
    use 'folke/tokyonight.nvim'

    -- Use nvim-autopairs for autopairs functionality (duh).
    -- See https://github.com/windwp/nvim-autopairs for more info.
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    -- Use nvim-comment for easy comment toggling (duh).
    -- See https://github.com/terrortylor/nvim-comment for more info.
    use "terrortylor/nvim-comment"

    -- Use undotree to expand undo functionality (duh).
    -- See https://github.com/mbbill/undotree for more info.
    use 'mbbill/undotree'

    -- Use telescope.nvim for fuzzy finding.
    -- Requires plenary.nvim plugin.
    -- See https://github.com/nvim-telescope/telescope.nvim for more info.
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Use harpoon for easy file navigation.
    -- Requires plenary.nvim plugin.
    -- See https://github.com/ThePrimeagen/harpoon for more info.
    use {
        'ThePrimeagen/harpoon',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Use nvim-treesitter for cool stuff.
    -- I still don't really understand what this plugin does beyond improving syntax highlighting.
    -- See https://github.com/nvim-treesitter/nvim-treesitter for more info.
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

end)
