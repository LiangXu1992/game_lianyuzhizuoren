require("TSLib")
local http = require("szocket.http")
-- 封装好的苹果函数
run = {}

local runAppSleepTime = 5000
local sleepTime = 30
local resolution = {
	iphone6 = {750, 1334}
}
local DEBUG = true
local logFile = 'lianyu'
local jobUrl = "http://runyi.ga/"

-- 解锁机器
function run.unlockDevice()
	lockFlag = deviceIsLock()
	if lockFlag ~= 0 then
		unlockDevice() --unlock device
		mSleep(500)
	end
end

function run.move(beginX, beginY, endX, endY)
	touchDown(beginX, beginY)
	mSleep(sleepTime)
	touchMove(endX, endY)
	mSleep(sleepTime)
	touchUp(endX, endY)
end

-- 打开App
function run.runApp(bundleName, sleepTime)
	runResule = runApp(bundleName)
	sleepTime = sleepTime or runAppSleepTime
	if runResule == 0 then
		toast("打开App成功" .. sleepTime)
		return true
	else
		toast("打开App失败" .. sleepTime)
		return false
	end
end

-- 自动适应iphone找图
function run.findImage(imgName, alpha, x1, y1, x2, y2)
	x1 = x1 or 0
	y1 = y1 or 0
	x2 = x2 or resolution["iphone6"][1]
	y2 = y2 or resolution["iphone6"][2]
	alpha = alpha or 40000000
	x,y = findImage(imgName, x1, y1, x2, y2, alpha)
	return x, y
end

-- 检查对话框弹框
function run.checkDialog()
	download_cancel_x, download_cancel_y = findImage("download_cancel", 103,  569, 649,  765, 5000000); 	-- 弹出对话框 取消
	if download_cancel_x ~= -1 and download_cancel_y ~= -1 then
		randomTap(download_cancel_x + 97, download_cancel_y + 37);
		mRndSleep(300, 500);
		return;
	end
end

function run.mRndSleep(min, max)
	mSleep(math.random(min, max))
end

-- 模拟方向盘
function run.sWheel(index, step, ms)
	-- 12个方向
	-- 设置圆心
	local originPoint = {156,  598}
	-- 设置方向123456789101112
	local clockPoint = {
		{214,  498},
		{255,  542},
		{270,  596},
		{254,  651},
		{214,  696},
		{157,  709},
		{100,  694},
		{57,  655},
		{44,  598},
		{58,  541},
		{100,  501},
		{156,  487},
	}
	
	local defaultStep = step or 10
	local defaultMs = ms or 2000
	moveTo(originPoint[1], originPoint[2], clockPoint[index][1], clockPoint[index][2], defaultStep, defaultMs)
	mSleep(350)
end

-- 多点找色
function run.multiColor(array,s)
    s = math.floor(0xff*(100-s)*0.01)
    keepScreen(true)
    for var = 1, #array do
        local lr,lg,lb = getColorRGB(array[var][1],array[var][2])
        local r = math.floor(array[var][3]/0x10000)
        local g = math.floor(array[var][3]%0x10000/0x100)
        local b = math.floor(array[var][3]%0x100)
        if math.abs(lr-r) > s or math.abs(lg-g) > s or math.abs(lb-b) > s then
            keepScreen(false)
            return false
        end
    end
    keepScreen(false)
    return true
end

-- 随机睡眠
function run.mRndSleep(min, max)
	mSleep(math.random(min, max))
end

-- 初始化日志
function run.initLog()
	initLog(logFile, 0)
end

-- 关闭日志
function run.closeLog()
	closeLog(logFile)
end

-- 写日志
function run.xLog(contents)
	--toast(contents)
	if DEBUG == true then
		wLog(logFile, "[DATE] "..contents);
	end
end

-- 点击，防止点击失败
function run.dTap(x, y, tapCount)
	if tapCount ~= nil then
		for idx = 1, tapCount do
			tap(x, y)
			run.mRndSleep(15, 20)
		end
	else
		tap(x, y)
		run.mRndSleep(15, 20)
		tap(x, y)
	end

end

-- vpn
function run.vpn()
::RUN_VPN_LINE::
	setVPNEnable(false)
	mSleep(1500)
	while true do
		flag = getVPNStatus()
		if flag.active == false then
			break
		end
		mSleep(1500)
	end
	setVPNEnable(true)
	mSleep(1500)
	local retryTimes = 1
	while true do
		flag = getVPNStatus()
		if flag.active == true then
			break
		end
		if retryTimes >= 10 then
			goto RUN_VPN_LINE
		end
		mSleep(1500)
		retryTimes = retryTimes + 1
	end
end

--curl
function run.curl(api, data)
	http.TIMEOUT = 5
	local post_data = data
	local response_body = {}
	res, code = http.request{  
		url = jobUrl..api,
		method = "POST",
		headers = 
		{
			["Content-Type"] = "application/x-www-form-urlencoded",
			["Content-Length"] = #post_data,
		},
		source = ltn12.source.string(post_data),
		sink = ltn12.sink.table(response_body)
	}
	if code == 200 and response_body[1] ~= nil and response_body[1] ~= "" then
		--toast(tostring(response_body[1]), 3);
		--mSleep(3000);
		return tostring(table.concat(response_body))
	end
	return nil;
end

-- 点击 sureTap 必定点击中
function run.sTap(x, y, sucSign, sucSignPrecent, delayTime, is_exit)
	local retryTimes = 0
::sTap_LINE::
	-- 点击
	run.dTap(x, y, 1)
	run.xLog(x.. "****" ..y)
	-- 延时判断
	run.mRndSleep(delayTime, delayTime + 500)
	-- 判断是否成功 table
	if sucSignPrecent == 0 then
		-- 直接找色is_color
		
	else
		-- 色对比
		if run.multiColor(sucSign, sucSignPrecent) == false then
			run.xLog(x.. "----" ..y)
			-- 未找到成功标志
			run.mRndSleep(1000, 2000)
			retryTimes = retryTimes + 1
			if retryTimes == 10 then
				if is_exit == 1 then
					run.xLog("click time out")
					lua_exit()
					toast("vvvvvvvv")
					toast("vvvvvvvv")
				else
					return
				end

			end
			goto sTap_LINE
		end
	end
	run.mRndSleep(500, 1000)
	return
end

-- 点击 sureTap 必定点击中
function run.sFunc(func, sucSign, sucSignPrecent, delayTime, beginSign)
	local retryTimes = 0
::sFunc_LINE::
	-- 执行函数
	func()
	-- 延时判断
	run.mRndSleep(delayTime, delayTime + 500)
	-- 判断是否成功 table
	if run.multiColor(sucSign, sucSignPrecent) == false then
		-- 未找到成功标志
		run.mRndSleep(1000, 2000)
		retryTimes = retryTimes + 1
		if retryTimes == 10 then
			run.xLog("sFunc time out")
			lua_exit()
			toast("vvvvvvvv")
			toast("vvvvvvvv")
		end
		goto sFunc_LINE
	end
	return
end

return run