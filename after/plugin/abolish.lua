local wk = require("which-key")
wk.register({
    cr = {
        name = "abolish",
        s = { "snake_case" },
        c = { "camelCase" },
        p = { "PascalCase" },
        u = { "SNAKE_UPPERCASE" },
        ["-"] = { "dash-case" },
        ["."] = { "dot.case" },
    },
}, { prefix = "<leader>" })
