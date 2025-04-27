local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local rep = require("luasnip.extras").rep
local TAB = "\t"

ls.add_snippets("go", {
    -- Print
    s("Println", {
        t("fmt.Println("), i(1, "\"message\""), t(")")
    }),

    -- Function declaration
    s("func", {
        t("func "), i(1, "name"), t("("), i(2), t(") "), i(3, "{"),
        t({ "", TAB }), i(4, "// code..." ),
        t({ "", "}" }),
    }),

    -- Main function
    s("main", {
        t("func main() {"), t({ "", TAB }),
        i(1, "// code..."),
        t({ "", "}" })
    }),

    -- If statement
    s("if", {
        t("if "), i(1, "condition"), t({ " {", TAB }),
        i(2, "// code"),
        t({ "", "}" }),
    }),

    -- If/else
    s("ife", {
        t("if "), i(1, "condition"), t({ " {", TAB }),
        i(2, "// if code"),
        t({ "", "} else {", TAB }),
        i(3, "// else code"),
        t({ "", "}" }),
    }),

    -- For loop (basic)
    s("for", {
        t("for "), i(1, "i := 0"), t("; "), i(2, "i < 10"), t("; "), i(3, "i++"), t({ " {", TAB }),
        i(4, "// code"),
        t({ "", "}" }),
    }),

    -- Range loop
    s("range", {
        t("for "), i(1, "i"), t(", "), i(2, "v"), t(" := range "), i(3, "collection"), t({ " {", TAB }),
        i(4, "// code"),
        t({ "", "}" }),
    }),

    -- Error handling
    s("err", {
        t("if err != nil {"), t({ "", TAB }),
        i(1, "log.Fatal(err)"),
        t({ "", "}" }),
    }),

    -- Struct definition
    s("struct", {
        t("type "), i(1, "MyStruct"), t(" struct {"), t({ "", TAB }),
        i(2, "Field string"),
        t({ "", "}" }),
    }),

    -- Goroutine
    s("go", {
        t("go func() {"), t({ "", TAB }),
        i(1, "// concurrent code"),
        t({ "", "}()"}),
    }),

    -- Channel declaration
    s("chan", {
        t("ch := make(chan "), i(1, "int"), t(")")
    }),

    -- Import block
    s("imp", {
        t("import ("), t({ "", TAB }),
        i(1, "\"fmt\""),
        t({ "", ")" }),
    }),

    -- Package declaration
    s("pkg", {
        t("package "), i(1, "main")
    }),
})
