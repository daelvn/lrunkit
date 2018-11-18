# lrunkit
Small library for executing commands faster
## Usage
### `execute = (command, options={}) -> runnable:{}`
Creates a runnable command using os.execute. Run it using `runnable!` (Lua: `runnable()`)
#### Options

- `error_on_fail`: Will exit at error
- `error_on_signal`: Will exit if terminated
- `silent`_: Runs the command silently

### `immediate = (command, options={})`
Same as execute, but runs instantly.
### `interact = (command) -> streamable:{}`
Creates a streamable command using io.popen.

- Open with `streamable\open "r/w"`
- Read with `streamable\read fmt`
- Write with `streamable\write str`
- Close with `streamable\close!`

### `chain = {} -> runchain:->`
Returns a chain of runnable commands. Use it as `ch = chain runnable1, runnable2, runnable3` and run it with `ch!`

