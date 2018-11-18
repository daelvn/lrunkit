# lrunkit
Small library for executing commands faster
## Usage
### `execute = (command, error_on_fail=false, error_on_signal=false) -> runnable:{}`
Creates a runnable command using os.execute. Run it using `runnable\run!` (Lua: `runnable:run()`)
### `interact = (command) -> streamable:{}`
Creates a streamable command using io.popen.

- Open with `streamable\open "r/w"`
- Read with `streamable\read fmt`
- Write with `streamable\write str`
- Close with `streamable\close!`

### `chain = {} -> chain:{}`
Returns a chain of runnable commands. Use it as `ch = chain runnable1, runnable2, runnable3` and run it with `ch\run!`

