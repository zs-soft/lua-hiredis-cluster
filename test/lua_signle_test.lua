local redis_cluster = require('redis_cluster')

local config = {}
--所有集群列表
-- config.iscluster = true
config.serv_list = {
    {ip="127.0.0.1", port="6800"}
}

local rc, err = redis_cluster:new(config)
if not rc then
    print('error!!!')
    return
end

local res, err = rc:get("test2")
if not res then
    print('没有找到test2,err:', err)
else
    print('找到test2:', res)
end


local res, err = rc:del("test2")

if not res then
    print('没有找到test2,err:', err)
end

-- 使用结束一定要释放资源！！！！！
rc:close()

print('res:', res)

