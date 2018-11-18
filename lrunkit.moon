-- lrunkit | 18.11.2018
-- By daelvn
-- Toolkit for running commands

-- runnable   = execute cmd
-- final      = chain runnable, runnable
-- streamable = interact cmd

execute = (command, error_on_fail=false, error_on_signal=false) -> {
  :command

  status: "unrun"
  code:   false
  signal: false

  :error_on_fail
  :error_on_signal

  run: =>
    ok, sig = os.execute @command
    switch ok
      when "exit"
        @code = sig
        if (sig != 0) and @error_on_fail then error "#{command} exited with code #{code}"
      when "signal"
        @signal = sig
        if @error_on_signal then error "#{command} terminated with signal #{signal}"
}

interact = (command) -> {
  :command
  
  handle: false

  open:  (mode) =>
    @handle = io.popen command, mode
    if @handle
      return @handle
    else
      return false
  read:  (fmt)  => @handle\read fmt
  write: (any)  => @handle\write any
  close:        => @handle\close!
}

chain = setmetatable {
  tree: {}

  run: => for runnable in *@tree do runnable\run!
}, {
  __call: (...) =>
    for runnable in *{...}
      table.insert @.tree, runnable
    return @
}

{ :execute, :interact, :chain }
