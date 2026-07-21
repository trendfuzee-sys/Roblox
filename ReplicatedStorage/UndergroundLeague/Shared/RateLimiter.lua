local RateLimiter = {}; RateLimiter.__index = RateLimiter
function RateLimiter.new(limit, window) return setmetatable({limit=limit, window=window, buckets={}}, RateLimiter) end
function RateLimiter:Allow(key)
	local now=os.clock(); local b=self.buckets[key]
	if not b or now-b.started>self.window then b={count=0, started=now}; self.buckets[key]=b end
	b.count += 1; return b.count <= self.limit
end
return RateLimiter
