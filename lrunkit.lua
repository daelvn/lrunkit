local execute
execute = function(command, error_on_fail, error_on_signal)
  if error_on_fail == nil then
    error_on_fail = false
  end
  if error_on_signal == nil then
    error_on_signal = false
  end
  return {
    command = command,
    status = "unrun",
    code = false,
    signal = false,
    error_on_fail = error_on_fail,
    error_on_signal = error_on_signal,
    run = function(self)
      local ok, sig = os.execute(self.command)
      local _exp_0 = ok
      if "exit" == _exp_0 then
        self.code = sig
        if (sig ~= 0) and self.error_on_fail then
          return error(tostring(command) .. " exited with code " .. tostring(code))
        end
      elseif "signal" == _exp_0 then
        self.signal = sig
        if self.error_on_signal then
          return error(tostring(command) .. " terminated with signal " .. tostring(signal))
        end
      end
    end
  }
end
local interact
interact = function(command)
  return {
    command = command,
    handle = false,
    open = function(self, mode)
      self.handle = io.popen(command, mode)
      if self.handle then
        return self.handle
      else
        return false
      end
    end,
    read = function(self, fmt)
      return self.handle:read(fmt)
    end,
    write = function(self, any)
      return self.handle:write(any)
    end,
    close = function(self)
      return self.handle:close()
    end
  }
end
local chain = setmetatable({
  tree = { },
  run = function(self)
    local _list_0 = self.tree
    for _index_0 = 1, #_list_0 do
      local runnable = _list_0[_index_0]
      runnable:run()
    end
  end
}, {
  __call = function(self, ...)
    local _list_0 = {
      ...
    }
    for _index_0 = 1, #_list_0 do
      local runnable = _list_0[_index_0]
      table.insert(self.tree, runnable)
    end
    return self
  end
})
return {
  execute = execute,
  interact = interact,
  chain = chain
}
