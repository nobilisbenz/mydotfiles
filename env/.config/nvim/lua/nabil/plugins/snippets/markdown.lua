local ls = require("luasnip") --{{{
local s = ls.s --> snippet
local i = ls.i --> insert node
local t = ls.t --> text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("Markdown Snippets", { clear = true })
local file_pattern = "*.md"

local function cs(trigger, nodes, opts) --{{{
  local snippet = s(trigger, nodes)
  local target_table = snippets

  local pattern = file_pattern
  local keymaps = {}

  if opts ~= nil then
    -- check for custom pattern
    if opts.pattern then
      pattern = opts.pattern
    end

    -- if opts is a string
    if type(opts) == "string" then
      if opts == "auto" then
        target_table = autosnippets
      else
        table.insert(keymaps, { "i", opts })
      end
    end

    -- if opts is a table
    if opts ~= nil and type(opts) == "table" then
      for _, keymap in ipairs(opts) do
        if type(keymap) == "string" then
          table.insert(keymaps, { "i", keymap })
        else
          table.insert(keymaps, keymap)
        end
      end
    end

    -- set autocmd for each keymap
    if opts ~= "auto" then
      for _, keymap in ipairs(keymaps) do
        vim.api.nvim_create_autocmd("BufEnter", {
          pattern = pattern,
          group = group,
          callback = function()
            vim.keymap.set(keymap[1], keymap[2], function()
              ls.snip_expand(snippet)
            end, { noremap = true, silent = true, buffer = true })
          end,
        })
      end
    end
  end

  table.insert(target_table, snippet) -- insert snippet into appropriate table
end --}}}

-- Start Refactoring --
----------------------------------
--cs( -- {} snippet{{{
--	"{",
--	fmt(
--		[[
--{{
--	{}
--}}
--]],
--		{
--			i(0, ""),
--		}
--	)
--) --}}}
----------------------------------

cs( -- all snippets snippet{{{
  "snips",
  fmt(
    [[
/*
1
2
3
4
5
col
*/
{}
  ]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs(
  "1",
  fmt(
    [[# <b class="bpurple"></b>
<br><br>
{}
]],
    { i(0, "") }
  )
)
----------------------------------

----------------------------------
cs(
  "2",
  fmt(
    [[
## <b class="red"></b>
<br>

{}

<br><hr><br>

]],
    { i(0, "") }
  )
)
----------------------------------

----------------------------------
cs(
  "3",
  fmt(
    [[### <b class="green"></b>
{}
]],
    { i(0, "") }
  )
)
----------------------------------

----------------------------------
cs(
  "4",
  fmt(
    [[#### <b class="orange"></b>
{}
]],
    { i(0, "") }
  )
)
----------------------------------

----------------------------------
cs(
  "5",
  fmt(
    [[##### <b class="pink"></b>
{}
]],
    { i(0, "") }
  )
)
----------------------------------

----------------------------------
cs(
  "col",
  fmt(
    [[
``````col
`````col-md
flexGrow=1
===

{}

`````
`````col-md
flexGrow=1
===

{}

`````
``````

{}
]],
    { i(1, "left"), i(2, "right"), i(3) }
  )
)
----------------------------------

-- End Refactoring --

return snippets, autosnippets
