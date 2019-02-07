-- lrunkit | 07.02.2019
-- By daelvn
-- Toolkit for running commands

command = (cmd) ->
  error "lrunkit $ `cmd` is not a string" if (type cmd) != "string"
  (...) ->
    argl = {...}
    for arg in *argl
      cmd ..= " #{arg}"
    --
    mode, signal = os.execute cmd
    return signal

capture = (cmd) ->
  error "lrunkit $ `cmd` is not a string" if (type cmd) != "string"
  (...) ->
    argl = {...}
    for arg in *argl
      cmd ..= " #{arg}"
    --
    local result
    with io.popen cmd, "r"
      result = handle\read "*a"
      \close!
    result

interact = (cmd) ->
  error "lrunkit $ `cmd` is not a string" if (type cmd) != "string"
  (...) ->
    argl = {...}
    for arg in *argl
      cmd ..= " #{arg}"
    --
    {
      command: cmd
      handle:  {}

      open: (mode) =>
        @handle = io.popen @command, mode
        @handle or false
      read: (frmt) =>
        @handle\read frmt
      write: (any) =>
        @handle\write any
      close: =>
        @handle\close!
    }

{ :command, :capture, :interact }
