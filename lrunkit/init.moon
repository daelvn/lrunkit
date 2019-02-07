-- lrunkit | 18.11.2018
-- By daelvn
-- Toolkit for running commands

-- runnable   = execute cmd
-- final      = chain runnable, runnable
-- streamable = interact cmd

execute = (command, options={}) -> setmetatable {
  :command

  status: "unrun"
  code:   false
  signal: false

  error_on_fail:   options and options.error_on_fail   or false
  error_on_signal: options and options.error_on_signal or false
  silent:          options and options.silent          or false
}, {
  __call: =>
    command = if @silent
      @command .. " > /dev/null 2> /dev/null"
    else
      @command
    ok, sig = os.execute command
    switch ok
      when "exit"
        @code = sig
        if (sig != 0) and @error_on_fail then error "#{command} exited with code #{code}"
      when "signal"
        @signal = sig
        if @error_on_signal then error "#{command} terminated with signal #{signal}"
}

immediate = (command, options) -> (execute command, options)!

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
}, {
  __call: (t, ...) ->
    tree = [runnable for runnable in *{...}]
    -> for runnable in *tree do runnable!
}

{ :execute, :interact, :immediate, :chain }
