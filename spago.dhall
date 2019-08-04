{ name =
    "toml-config"
, dependencies =
    [ "effect"
    , "console"
    , "simple-json"
    , "node-fs-aff"
    , "assert"
    , "psci-support"
    , "debug"
    ]
, packages =
    ./packages.dhall
, sources =
    [ "src/**/*.purs", "test/**/*.purs" ]
}
