return {
  "nvim-lua/plenary.nvim", -- lua functions that many plugins use
  "christoomey/vim-tmux-navigator", -- tmux & split window navigation

  -- folke plugins
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
        library = {
            { path = "${3rd}/plenary.nvim/lua", words = { "plenary" } },
        },
    },
},
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
    -- add any options here
    },
    dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
    },
    config = function()
    require("noice").setup({
    lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
    },
    -- you can enable a preset for easier configuration
    presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
    },
    })
    end,
  },
  {
  --"dasupradyumna/midnight.nvim",
  --priority = 1000,
  --config = function()
  --  vim.cmd.colorscheme("midnight")
  --
  --  vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
  --  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
  --end,

   "folke/tokyonight.nvim",
   config = function()
     local transparent = false -- set to true if you would like to enable transparency
  
     local bg = "#000000"
     -- "#011628"
     local bg_dark = "#000000"
     local bg_highlight = "#143652"
     local bg_search = "#0A64AC"
     local bg_visual = "#275378"
     local fg = "#CBE0F0"
     local fg_dark = "#B4D0E9"
     local fg_gutter = "#627E97"
     local border = "#547998"
  
     require("tokyonight").setup({
       style = "night",
       transparent = transparent,
       styles = {
         sidebars = transparent and "transparent" or "dark",
         floats = transparent and "transparent" or "dark",
       },
       on_colors = function(colors)
         colors.bg = bg
         colors.bg_dark = transparent and colors.none or bg_dark
         colors.bg_float = transparent and colors.none or bg_dark
         colors.bg_highlight = bg_highlight
         colors.bg_popup = bg_dark
         colors.bg_search = bg_search
         colors.bg_sidebar = transparent and colors.none or bg_dark
         colors.bg_statusline = transparent and colors.none or bg_dark
         colors.bg_visual = bg_visual
         colors.border = border
         colors.fg = fg
         colors.fg_dark = fg_dark
         colors.fg_float = fg
         colors.fg_gutter = fg_gutter
         colors.fg_sidebar = fg_dark
       end,
     })
  
     vim.cmd("colorscheme tokyonight")
   end,
  },
  {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
},
{
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  opts = {
    focus = true,
  },
  cmd = "Trouble",
  keys = {
    { "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open trouble workspace diagnostics" },
    { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Open trouble document diagnostics" },
    { "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", desc = "Open trouble quickfix list" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "Open trouble location list" },
    { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "Open todos in trouble" },
  },
},
{
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local todo_comments = require("todo-comments")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "]t", function()
      todo_comments.jump_next()
    end, { desc = "Next todo comment" })

    keymap.set("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "Previous todo comment" })

    todo_comments.setup()
  end,
},
{
  "folke/zen-mode.nvim",
},
{
  "folke/twilight.nvim",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
},

-- Other Plugins
{
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
    })

    local keymap = vim.keymap

    keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
    keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
  end,
},
{
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
    config = function()
        local autopairs = require("nvim-autopairs") -- import nvim-autopairs

        -- setup autopairs
        autopairs.setup({
            check_ts = true, -- treesitter enabled
            ts_config = {
                lua = { "string" }, -- dont add pairs in lua string treesitter nodes
                javascript = { "template_string" }, -- dont add pairs in javscript template_string treesitter nodes
                java = false, -- dont check treesitter on java
            },
        })
        -- import nvim-autopairs completion functionality
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        -- import nvim-cmp plugin (completions plugin)
        local cmp = require("cmp")
        -- make autopairs and completion work together
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
},
{
  "szw/vim-maximizer",
  keys = {
    { "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
  },
},
{
  "crispgm/nvim-tabline",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional
  config = true,
},
{
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local colors = {
            color0 = "#092236",
            color1 = "#ff5874",
            color2 = "#c3ccdc",
			color3 = "#000000",
			color6 = "#a1aab8",
			color7 = "#828697",
			color8 = "#ae81ff",
		}
		local my_lualine_theme = {
			replace = {
				a = { fg = colors.color0, bg = colors.color1, gui = "bold" },
				b = { fg = colors.color2, bg = colors.color3 },
			},
			inactive = {
				a = { fg = colors.color6, bg = colors.color3, gui = "bold" },
				b = { fg = colors.color6, bg = colors.color3 },
				c = { fg = colors.color6, bg = colors.color3 },
			},
			normal = {
				a = { fg = colors.color0, bg = colors.color7, gui = "bold" },
				b = { fg = colors.color2, bg = colors.color3 },
				c = { fg = colors.color2, bg = colors.color3 },
			},
			visual = {
				a = { fg = colors.color0, bg = colors.color8, gui = "bold" },
				b = { fg = colors.color2, bg = colors.color3 },
			},
			insert = {
				a = { fg = colors.color0, bg = colors.color2, gui = "bold" },
				b = { fg = colors.color2, bg = colors.color3 },
			},
		}

        local mode = {
            'mode',
            fmt = function(str)
                -- return ' ' 
                -- displays only the first character of the mode
                return ' ' .. str
            end,
        }

        local diff = {
            'diff',
            colored = true,
            symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
            -- cond = hide_in_width,
        }

        local filename = {
            'filename',
            file_status = true,
            path = 0,
        }

        local branch = {'branch', icon = {'', color={fg='#A6D4DE'}}, '|'}


		lualine.setup({
            icons_enabled = true,
			options = {
				theme = my_lualine_theme,
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "|", right = "" },
			},
			sections = {
                lualine_a = { mode },
                lualine_b = { branch },
                lualine_c = { diff, filename },
				lualine_x = {
					{
                        -- require("noice").api.statusline.mode.get,
                        -- cond = require("noice").api.statusline.mode.has,
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					-- { "encoding",},
					-- { "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
},
{
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = true,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    ---@module 'render-markdown'
    -- ft = { "markdown", "norg", "rmd", "org" },
    init = function()
        -- Define colors
        local color1_bg = "#ff757f"
        local color2_bg = "#4fd6be"
        local color3_bg = "#7dcfff"
        local color4_bg = "#ff9e64"
        local color5_bg = "#7aa2f7"
        local color6_bg = "#c0caf5"
        local color_fg = "#1F2335"
        -- -- Heading background
        vim.cmd(string.format([[highlight Headline1Bg guifg=%s guibg=%s gui=bold]], color_fg, color1_bg))
        vim.cmd(string.format([[highlight Headline2Bg guifg=%s guibg=%s gui=bold]], color_fg, color2_bg))
        vim.cmd(string.format([[highlight Headline3Bg guifg=%s guibg=%s gui=bold]], color_fg, color3_bg))
        vim.cmd(string.format([[highlight Headline4Bg guifg=%s guibg=%s gui=bold]], color_fg, color4_bg))
        vim.cmd(string.format([[highlight Headline5Bg guifg=%s guibg=%s gui=bold]], color_fg, color5_bg))
        vim.cmd(string.format([[highlight Headline6Bg guifg=%s guibg=%s gui=bold]], color_fg, color6_bg))

        -- Heading fg
        -- vim.cmd(string.format([[highlight Headline1Fg guifg=%s gui=bold]], colors.color1_bg))
        -- vim.cmd(string.format([[highlight Headline2Fg guifg=%s gui=bold]], colors.color2_bg))
        -- vim.cmd(string.format([[highlight Headline3Fg guifg=%s gui=bold]], colors.color3_bg))
        -- vim.cmd(string.format([[highlight Headline4Fg guifg=%s gui=bold]], colors.color4_bg))
        -- vim.cmd(string.format([[highlight Headline5Fg guifg=%s gui=bold]], colors.color5_bg))
        -- vim.cmd(string.format([[highlight Headline6Fg guifg=%s gui=bold]], colors.color6_bg))
    end,
    opts = {
        heading = {
            sign = false,
            icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
            backgrounds = {
                "Headline1Bg",
                "Headline2Bg",
                "Headline3Bg",
                "Headline4Bg",
                "Headline5Bg",
                "Headline6Bg",
            },
            foregrounds = {
                "Headline1Fg",
                "Headline2Fg",
                "Headline3Fg",
                "Headline4Fg",
                "Headline5Fg",
                "Headline6Fg",
            },
        },
        code = {
            sign = false,
            width = "block",
            right_pad = 1,
        },
        bullet = {
            -- Turn on / off list bullet rendering
            enabled = true,
        },
        -- checkbox = {
        --     -- Turn on / off checkbox state rendering
        --     enabled = true,
        --     -- Determines how icons fill the available space:
        --     --  inline:  underlying text is concealed resulting in a left aligned icon
        --     --  overlay: result is left padded with spaces to hide any additional text
        --     position = "inline",
        --     unchecked = {
        --         -- Replaces '[ ]' of 'task_list_marker_unchecked'
        --         icon = "   󰄱 ",
        --         -- Highlight for the unchecked icon
        --         highlight = "RenderMarkdownUnchecked",
        --         -- Highlight for item associated with unchecked checkbox
        --         scope_highlight = nil,
        --     },
        --     checked = {
        --         -- Replaces '[x]' of 'task_list_marker_checked'
        --         icon = "   󰱒 ",
        --         -- Highlight for the checked icon
        --         highlight = "RenderMarkdownChecked",
        --         -- Highlight for item associated with checked checkbox
        --         scope_highlight = nil,
        --     },
        -- },
    },
},
{
  "kevinhwang91/nvim-ufo",
  event = "BufRead",
  dependencies = "kevinhwang91/promise-async",
  config = function()
    vim.o.foldcolumn = "0" -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
    vim.keymap.set("n", "zk", function()
      local winid = require("ufo").peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end, { desc = "Peek Fold" })

    require("ufo").setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { "lsp", "indent" }
      end,
    })
  end,
},
{
    "mbbill/undotree",
    config = function()
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end,
},






}
