local redis_cluster = require('redis_cluster')
-- local usertime = require('usertime')

local letters = [[abcdefghijklmnopqrstuvwxyz]]

local function func(rc, key, value)
    local res, err = rc:set(key, value)
    if not res then
        -- print('没有找到key,err:', err)
        return nil, err
    end
    return res
    -- print("key value:", res)
end

local function gen_random_string()
    local str = ''
    for i = 1, 10 do
        local random_num = math.random(1,#letters)
        str = str .. string.sub(letters, random_num, random_num)
    end
    return str
end

local config = {}
--所有集群列表
config.iscluster = true
config.serv_list = {
    {ip="127.0.0.1", port="7000"},
    {ip="127.0.0.1", port="7001"},
    {ip="127.0.0.1", port="7002"},
    {ip="127.0.0.1", port="7003"},
    {ip="127.0.0.1", port="7004"},
    {ip="127.0.0.1", port="7005"},
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

-- local start_timestamp = usertime.getmillisecond()

-- local success_count = 0
-- local failed_Count = 0

-- for i=1, 10000 do
--     local key = tostring(i*1000)
--     local value = "asdfasdfasdfas"
--     local res, err = func(rc, key, value)
--     if not res then
--         failed_Count = failed_Count + 1
--     else
--         success_count = success_count + 1
--     end
-- end

-- print('成功次数：', success_count)
-- print('失败次数：', failed_Count)
-- print('总次数:', success_count + failed_Count)
-- print('开始时间戳:', start_timestamp)
-- print('结束时间戳:', end_timestamp)
-- print('时间差:', end_timestamp - start_timestamp)
