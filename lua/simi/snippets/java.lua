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
  s('out', fmt([[System.out.println({});]], { i(0) })),
}
