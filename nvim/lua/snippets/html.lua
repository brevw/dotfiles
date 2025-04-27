local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep

ls.add_snippets("html", {
    -- Basic HTML boilerplate
    s("html5", {
        t({
            "<!DOCTYPE html>",
            "<html lang=\"en\">",
            "<head>",
            "    <meta charset=\"UTF-8\">",
            "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">",
            "    <title>"
        }),
        i(1, "Document"),  -- Title placeholder
        t({
            "</title>",
            "</head>",
            "<body>",
            "    "
        }),
        i(2),  -- Body content placeholder
        t({
            "",
            "</body>",
            "</html>"
        })
    }),

    -- A simple `div` container
    s("div", {
        t("<div class=\""), i(1, "container"), t("\">"),
        t({"", "    "}), i(2),  -- Content inside the div
        t({"", "</div>"})
    }),

    -- Image tag with alt text
    s("img", {
        t("<img src=\""), i(1, "image.jpg"), t("\" alt=\""), i(2, "description"), t("\" />")
    }),

    -- Anchor link
    s("a", {
        t("<a href=\""), i(1, "https://example.com"), t("\">"), i(2, "Click here"), t("</a>")
    }),

    -- Button
    s("btn", {
        t("<button>"), i(1, "Click me"), t("</button>")
    }),

    -- Script tag
    s("script", {
        t("<script>"),
        t({"", "    "}), i(1, "// JavaScript here"),
        t({"", "</script>"})
    }),

    -- Style tag
    s("style", {
        t("<style>"),
        t({"", "    "}), i(1, "/* CSS here */"),
        t({"", "</style>"})
    }),

    -- tags
    s("tag", {
        t("<"), i(1), t(">"), i(2), t("</"), rep(1), t(">")
    }),

    -- comments
    s("comment", {
        t("<!-- "), i(1), t(" -->")
    }),
})
