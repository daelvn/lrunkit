package = "lrunkit"
version = "1.0-1"

source  = {
  url   = "https://github.com/daelvn/lrunkit",
  tag   = "v1.0"
}

description = {
  summary  = "Small library for running commands",
  detailed = [[
    Small library for running and interacting with commands
    using wrappers for os.execute and io.popen.
  ]],
  homepage = "https://github.com/daelvn/lrunkit",
  license  = "MIT/X11"
}

build = {
  type    = "builtin",
  modules = {
    lrunkit = "lrunkit.lua"
  },
}
