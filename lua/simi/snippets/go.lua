local ls = require 'luasnip'
local s = ls.snippet
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
-- local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
local fmt = require('luasnip.extras.fmt').fmt

return {
  s(
    'println',
    fmt(
      [[
    fmt.Println({args})
    ]],
      {
        args = i(1, 'args'),
      }
    )
  ),

  s(
    'printf',
    fmt(
      [[
    fmt.Printf({args})
    ]],
      {
        args = i(1, 'args'),
      }
    )
  ),

  s(
    'iferr',
    fmt(
      [[
    if err != nil {{
    	{body}
    }}
    ]],
      {
        body = i(0, 'log.Fatal(err)'),
      }
    )
  ),
}
