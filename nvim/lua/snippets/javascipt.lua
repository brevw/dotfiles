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

ls.add_snippets("javascript", {
    -- Console log
    s("log", {
        t("console.log("), i(1, "msg"), t(");")
    }),

    -- coalescing assignment
    s("??=", {
        t("const "), i(1, "varName"), t(" = "), i(2, "value"), t(" ?? "), rep(1), t(";")
    }),

    -- Arrow function
    s("afn", {
        i(1, "const"), t(" "), i(2, "fnName"), t(" = ("), i(3), t(") => {"),
        t({ "", TAB }), i(4, "// code..."),
        t({ "", "};" })
    }),

    -- Function declaration
    s("fn", {
        t("function "), i(1, "name"), t("("), i(2), t({ ") {", TAB }),
        i(3),
        t({ "", "}" })
    }),

    -- Fetch template
    s("fetch", {
        t("fetch("), i(1, "'/api/endpoint'"), t({ ")",
        "  .then((response) => {" }),
        t({ "    return response.json();", "  })", "  .then((data) => {" }),
        t({ "    " }), i(2, "console.log(data)"),
        t({ "", "  })", "  .catch((error) => {" }),
        t({ "    console.error(error);", "  });" }),
    }),

    -- for loop
    s("for", {
        t("for (let "), i(1, "i"), t(" = 0; "), rep(1), t(" < "), i(2, "array.length"), t("; "), rep(1), t({ "++) {", TAB }),
        i(3, "// code"),
        t({ "", "}" }),
    }),

    -- while loop
    s("while", {
        t("while ("), i(1, "condition"), t({ ") {", TAB }),
        i(2, "// code"),
        t({ "", "}" }),
    }),

    -- do while loop
    s("dowhile", {
        t("do {"), t({ "", TAB }),
        i(1, "// code"),
        t({ "", "} while ("}), i(2, "condition"), t({ ");" }),
    }),

    -- if/else
    s("if", {
        t("if ("), i(1, "condition"), t({ ") {", TAB }),
        i(2, "// code"),
        t({ "", "}" }),
    }),
    s("ifelse", {
        t("if ("), i(1, "condition"), t({ ") {", TAB }),
        i(2, "// code"),
        t({ "", "} else {", TAB }),
        i(3, "// else code"),
        t({ "", "}" }),
    }),

    -- try/catch
    s("try", {
        t({ "try {", TAB }), i(1, "// code"),
        t({ "", "} catch (" }), i(2, "err"), t({ ") {", TAB }),
        i(3, "console.error("), rep(2), t(");"),
        t({ "", "}" }),
    }),

    -- import
    s("import", {
        t("import "), i(1, "module"), t(" from '"), i(2, "module-name"), t("';")
    }),

    -- export
    s("export", {
        t("export "), c(1, {
            t("default "),
            t("")
        }), i(2, "value"), t(";")
    }),

    -- class
    s("class", {
        t("class "), i(1, "MyClass"), t(" {"),
        t({ "", "  constructor(" }), i(2), t({ ") {", "    " }),
        i(3, "// constructor body"),
        t({ "", "  }", "}" })
    }),
})
