local Signal = {}
Signal.__index = Signal
function Signal.new() return setmetatable({_handlers={}}, Signal) end
function Signal:Connect(fn) table.insert(self._handlers, fn); return {Disconnect=function() table.remove(self._handlers, table.find(self._handlers, fn)) end} end
function Signal:Fire(...) for _, fn in ipairs(table.clone(self._handlers)) do task.spawn(fn, ...) end end
return Signal
