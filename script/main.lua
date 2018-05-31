-- 设置屏幕 0:竖屏，1:横屏（HOME键在右）
init(0)

local thread = require('thread')
local run = require("run")
local json = require("json")
local accountTable = {}
local gameStartTimeStamp = os.time()

-- 常规地图检测
function skipMoive()
	local res = false

	while true do
::SKIP_MOIVE_LINE::
		run.mRndSleep(300, 500)
		
		--p1.PNG 回顾按钮
		if (isColor( 702,   52, 0xfbfbf8, 99) and isColor( 696,   53, 0xffffff, 99) and isColor( 688,   53, 0xfffefe, 99) and isColor( 682,   57, 0xfefaf6, 99) and isColor( 647,   50, 0xfefcfa, 99)) then
			run.dTap(347, 1245)
			goto SKIP_MOIVE_LINE
		end
		
		
	end
end

-- 超时定时器
function scriptTimeOut()
	local startTimeStamp = os.time()
	while (os.time() - startTimeStamp < 60 * 15) do
		-- 休眠30秒
		mSleep(30000)
	end
	run.xLog("超时退出")
	run.xLog(accountTable["email"])
	lua_exit()
	toast("lua_exit")
        mSleep(5000)
	toast("lua_exit")
end

--章节前的操作
function startGame()
	while true do
::START_GAME_LINE::
		run.mRndSleep(500, 1000)
		--选择答案 2个答案 P2.PNG
		if (isColor( 558,  452, 0xf0748e, 99) and isColor( 546,  485, 0xf0748d, 99) and isColor( 504,  574, 0xf0748e, 99) and isColor( 494,  612, 0xf0748e, 99)) then
			run.xLog("startGame qi ming zi")
			run.dTap(370,  470)
			goto START_GAME_LINE
		end
		
		-- 起名字 P3
		if (isColor( 697,  586, 0x64b3d4, 99) and isColor( 676,  585, 0x64b5d5, 99) and isColor( 558,  620, 0xfcffff, 99) and isColor( 556,  618, 0xfdffff, 99)) then
			run.xLog("startGame qi ming zi")
			-- 点击随便签一个名字
			run.dTap(582,  605)
			--点击确定
			mSleep(1000)
			run.dTap(334,  763)
			goto START_GAME_LINE
		end
		
		--点击获得奖励P5
		if (isColor( 626,  120, 0xf64f74, 99) and isColor( 644,  121, 0xf55071, 99) and isColor( 573,  129, 0xffffff, 99) and isColor( 569,  122, 0xffebf2, 99)) then
			run.xLog("startGame huo de jiang li")
			--点击最下方
			run.dTap(375, 1258)
			mSleep(1000)
			return
		end
		--随机乱点
		run.xLog("startGame luan dian")
		run.dTap(393,  965)
	end
end

--开始章节
function startChapter()
	local oneTwoChapterFlag = {["x"]=-1,["y"]=-1}
	local oneThreeChapterFlag = {["x"]=-1,["y"]=-1}
	local oneFourChapterFlag = {["x"]=-1,["y"]=-1}
	local oneFiveChapterFlag = {["x"]=-1,["y"]=-1}
	local oneSixChapterFlag = {["x"]=-1,["y"]=-1}
	local oneSevenChapterFlag = {["x"]=-1,["y"]=-1}
	while true do
::START_CHAPTER_LINE::
		local tmpSign = {}
		local tmpFunc = function() return 'a' end
		run.mRndSleep(1000, 1500)

		-- 1-6 P41
		if oneSixChapterFlag.x ~= -1 then
			run.xLog("startChapter 1-6")
			--P41点击进入1-6 P42判断依据
			tmpSign = {
				{  141,  773, 0x8fe1fe},
				{  129,  788, 0x90e2ff},
				{  145,  784, 0x90e2ff},
				{  102,  801, 0xfbf8f6},
			}
			run.sTap(oneSixChapterFlag.x + 10, oneSixChapterFlag.y + 10, tmpSign, 99, 1500)
			--P42点击开始制作 P43判断依据
			tmpSign = {
				{   79, 1138, 0x3d4365},
				{   80, 1138, 0x37375e},
				{   81, 1138, 0x5e5484},
				{   83, 1136, 0x56497c},
			}
			run.sTap(581,  965, tmpSign, 99, 1500)
			--P43点击开始制作 P44判断依据
			tmpSign = {
				{  249,   68, 0xd7a792},
				{  265,   68, 0xd7a791},
				{  232,   82, 0xffffff},
				{  232,   76, 0xffffff},
			}
			tmpFunc = function()
				-- 点击泰森娜 P43
				tap(89, 1220)
				mSleep(1000)
				-- 点击事件确定按钮 P43-1
				tap(380,  810)
				mSleep(2500)
				-- 点击时间反馈确定 P43-2
				tap(389,  814)
				mSleep(2500)
				-- 点击召唤羁绊 P43-3
				tap(377,  810)
				mSleep(2500)
				-- 选择羁绊伙伴 P43-4
				tap(106,  917) --第一个
				mSleep(1000)
				tap(286,  922) --第二个
				mSleep(1000)
				tap(380,  630) --点击确定
				mSleep(1000)
				tap(380,  630) -- 点击退出人物头像
				mSleep(1000)
				tap(380,  630) -- 点击退出人物头像
				mSleep(1000)
				-- 点击发布 P43-5
				tap(370,  784)
				mSleep(1000)
				tap(370,  784) -- 点击跳过颁奖过程
				mSleep(1000)
				-- 点击结束拍摄 P43-6
				tap(542, 1021)
				mSleep(1000)
			end
			run.sFunc(tmpFunc, tmpSign, 99, 1500)
			goto START_CHAPTER_LINE
		end
		
		-- 1-5 P32
		if oneFiveChapterFlag.x ~= -1 then
			run.xLog("startChapter 1-5")
			--P32点击进入1-5,对话较多 P33判断依据
			tmpSign = {
				{  636,  633, 0xc3686d},
				{  637,  633, 0xdcb3b6},
				{  621,  658, 0xbf5a5f},
				{  620,  658, 0xe6c5c6},
			}
			run.sTap(oneFiveChapterFlag.x + 30, oneFiveChapterFlag.y + 20, tmpSign, 98, 1500)
			--P33点击手机 P34判断依据
			tmpSign = {
				{  131, 1302, 0x9580ac},
				{  132, 1301, 0xbeaeca},
				{  129, 1320, 0x9780af},
				{  129, 1321, 0xc1b5d0},
			}
			run.sTap(83,  898, tmpSign, 99, 500)
			--P34点击周棋洛发来的短信 P35判断依据
			tmpSign = {
				{  318,  651, 0xd89da1},
				{  317,  652, 0xbf5a5f},
				{  316,  653, 0xe2b6b9},
				{  315,  654, 0xfbf8f9},
			}
			run.sTap(362,  221, tmpSign, 99, 500)
			--P35点击回复短信 P36判断依据
			tmpSign = {
				{  304, 1076, 0x6c676e},
				{  304, 1075, 0x9d999e},
				{  305, 1075, 0xb8b5b9},
				{  306, 1074, 0xfbfafb},
			}
			run.sTap(336, 1269, tmpSign, 99, 500)
			--P36点击回复短信第一个回复 谁让你喜欢呢 P37判断依据
			tmpSign = {
				{  111,  931, 0x6c676e},
				{  110,  930, 0x97949b},
				{  110,  932, 0xc8c7cf},
				{  113,  922, 0x6e6970},
			}
			run.sTap(369, 1062, tmpSign, 99, 500)
			--P37点击发送 P38判断依据
			tmpSign = {
				{  226,  523, 0x6c676e},
				{  226,  522, 0x938f95},
				{  225,  522, 0xdbdadf},
				{  224,  522, 0xf5f5f9},
			}
			run.sTap(685,  924, tmpSign, 99, 3500)
			--P38再次点击发送 P39判断依据
			tmpSign = {
				{  479, 1092, 0xc56b6f},
				{  479, 1091, 0xd6979a},
				{  480, 1091, 0xe5c0c3},
				{  488, 1089, 0x77727b},
			}
			tmpFunc = function()
				-- 点击发送短信的栏目 P38
				tap(330, 1268)
				mSleep(1000)
				-- 点击选择短信内容 P38-1
				tap(387, 1064)
				mSleep(1500)
				-- 点击发送短信 P38-1
				tap(693,  931)
				mSleep(1000)
			end
			run.sFunc(tmpFunc, tmpSign, 99, 4500)
			--P39点击退出 P40判断依据
			tmpSign = {
				{  242,  633, 0x76717b},
				{  242,  632, 0xc0bec2},
				{  243,  632, 0xdddcde},
				{  253,  636, 0x6b6670},
			}
			run.sTap(50,   51, tmpSign, 99, 500)
			--P40点击右上角好感度 P41判断依据
			tmpSign = {
				{  224,   77, 0xfaf2ef},
				{  227,   76, 0xd8a993},
				{  227,   82, 0xfaf4f1},
				{  237,   82, 0xdaaf9a},
			}
			tmpFunc = function()
				-- 点击右上角好感度 P40
				run.dTap(696,   59)
				mSleep(1500)
				-- 点击周棋洛 P40-1
				run.dTap(542,  157)
				mSleep(1500)
				-- 再次点击后退 P40-2
				run.dTap(50,   51)
				mSleep(1000)
			end
			run.sFunc(tmpFunc, tmpSign, 99, 2000)
			goto START_CHAPTER_LINE
		end
		
		-- 1-4 P29
		if (isColor( 374,  992, 0xf0dfe0, 99) and isColor( 375,  992, 0xc76f74, 99) and isColor( 391, 1035, 0xcd8286, 99) and isColor( 391, 1034, 0xead6d8, 99)) or oneFourChapterFlag.x ~= -1 then
			run.xLog("startChapter 1-4")
			--P29点击进入左下角影视公司 P29-1判断依据
			tmpSign = {
				{  147,  672, 0x382e62},
				{  148,  671, 0x3c3566},
				{  148,  670, 0x958d93},
				{  150,  669, 0xaa999b},
			}
			run.sTap(91, 1220, tmpSign, 98, 1000)
			mSleep(1500)
			run.dTap(44,   46)
			mSleep(1500)
			--P29-2 进入1-4， P29-3判断依据
			run.dTap(303,  854)
			mSleep(1500)
			--P30点击问题喜欢周棋洛 P31判断依据
			tmpSign = {
				{  614,  726, 0xb3a5de},
				{  615,  726, 0xe0dcee},
				{  616,  726, 0xf5f4f5},
				{  506,  726, 0x94b5e5},
			}
			run.sTap(374,  470, tmpSign, 100, 2500)
			--P31点击获得赵小烦 P32判断依据
			tmpSign = {
				{  241,   86, 0xd7a891},
				{  253,   88, 0xd5a590},
				{  384,   77, 0xfefefe},
				{  384,   81, 0xfefefe},
			}
			run.sTap(691,  464, tmpSign, 99, 1000)
			goto START_CHAPTER_LINE
		end
		
		-- 1-3 P18
		if (isColor( 585, 1151, 0x6b6670, 99) and isColor( 604, 1151, 0x827e86, 99) and isColor( 603, 1176, 0x6f6a73, 99) and isColor( 586, 1176, 0x7f7b84, 99)) or oneThreeChapterFlag.x ~= -1 then
			run.xLog("startChapter 1-3")
			oneThreeChapterFlag = false
			run.mRndSleep(500, 1000)
			--P18点击进入1-3 P19判断依据
			tmpSign = {
				{  296, 1135, 0xbf5a5f},
				{  294, 1145, 0xbf5a5f},
				{  295, 1159, 0xd29093},
				{  295, 1158, 0xbf5a5f},
			}
			run.sTap(352,  943, tmpSign, 100, 500)
			--P19点击开始制作 P20判断依据
			tmpSign = {
				{  283, 1182, 0xc05d62},
				{  287, 1176, 0xc4686d},
				{  287, 1175, 0xe2c1c3},
				{  285, 1170, 0xc16166},
			}
			run.sTap(590,  963, tmpSign, 100, 500)
			--P20点击更多专家 P21判断依据
			tmpSign = {
				{  633,  876, 0xcc7c80},
				{  619,  876, 0xd18b8f},
				{  614,  873, 0xc3656a},
				{  613,  873, 0xdca5a8},
			}
			run.sTap(101,  919, tmpSign, 100, 500)
			--P21点击专家泰森娜 P22判断依据
			tmpSign = {
				{  468,  457, 0xffb279},
				{  468,  458, 0xfed5bc},
				{  484,  457, 0xff9184},
				{  483,  457, 0xfeb2a8},
			}
			run.sTap(215, 1209, tmpSign, 98, 500)
			--P22点击特聘 P23判断依据
			tmpSign = {
				{  374,  867, 0xc66e72},
				{  366,  873, 0xc36469},
				{  357,  878, 0xca767a},
				{  357,  877, 0xeed2d4},
			}
			run.sTap(374, 1070, tmpSign, 99, 500)
			--P23点击后退按钮 P24判断依据
			tmpSign = {
				{  236,  633, 0xbf5a5f},
				{  236,  658, 0xbf5a5f},
				{  254,  658, 0xc4686d},
				{  255,  658, 0xcd7f83},
			}
			run.sTap(53,   52, tmpSign, 99, 500)
			--P24长长长按后退泰森娜左下角图片 P25判断依据
			tmpSign = {
				{  343,  381, 0x474865},
				{  345,  380, 0x343362},
				{  347,  379, 0x403f71},
				{  348,  377, 0x392860},
			}
			tmpFunc = function()
				-- 点击泰森娜头像
				tap(94, 1222)
				mSleep(1000)
				-- 长按泰森娜头像
				tap(94, 1222, 1500)
				mSleep(1500)
			end
			run.sFunc(tmpFunc, tmpSign, 99, 500)
			--P25点击泰森娜下面的确定，P26判断依据
			tmpSign = {
				{  624,  788, 0x93bd94},
				{  710,  803, 0x8dba8d},
				{  690,  787, 0xfafdfa},
				{  699,  790, 0xfffeff},
			}
			run.sTap(381,  819, tmpSign, 99, 500)
			--P26点击召唤羁绊确定，P27判断依据
			tmpSign = {
				{  168,  790, 0xfe809b},
				{  193,  792, 0xfe809c},
				{   92,  776, 0xf3e9f4},
				{  417,  782, 0xffffff},
			}
			mpFunc = function()
				-- 点击A小姐头像
				tap(108,  910)
				mSleep(1000)
				-- 点击B小姐头像
				tap(282,  917)
				mSleep(1000)
				run.dTap(380,  639)
			end
			run.sFunc(mpFunc, tmpSign, 99, 500)
			--P27点击节目发布，P28判断依据
			tmpSign = {
				{   82, 1013, 0xa0bdcf},
				{  292, 1022, 0x9bbad1},
				{  430, 1001, 0xfe9893},
				{  613, 1040, 0xfc9991},
			}
			run.sTap(361,  773, tmpSign, 99, 500)
			--P28点击结束拍摄，P29判断依据
			tmpSign = {
				{  407, 1059, 0xbf5a5f},
				{  406, 1059, 0xcd8488},
				{  393, 1054, 0xbf5a5f},
				{  392, 1055, 0xddb5b8},
			}
			run.sTap(540, 1022, tmpSign, 99, 500)
			goto START_CHAPTER_LINE
		end
		
		-- 1-2 P6
		if (isColor( 567,  873, 0xc05e63, 95) and isColor( 562,  856, 0xbf5a5f, 95) and isColor( 596,  859, 0xbf5c61, 95) and isColor( 607,  873, 0xbf5a5f, 95)) or oneTwoChapterFlag.x ~= -1 then
			run.xLog("startChapter 1-2")
			run.mRndSleep(500, 1000)
			--P6点击进入1-2 P7判断依据
			tmpSign = {
				{  310,  281, 0xfffefe},
				{  321,  279, 0xfffdfd},
				{  378,  274, 0xe5847f},
				{  378,  307, 0xe4857f},
			}
			run.sTap(360, 1134, tmpSign, 100, 750)
			--P7点击制作 P8判断依据
			tmpSign = {
				{  233,  957, 0xbf5a5f},
				{  230,  946, 0xbf5a5f},
				{  489,  959, 0x6b6670},
				{  489,  934, 0x6b6670},
			}
			run.sTap(588,  970, tmpSign, 100, 1000, 0)
			--P8点击退出, P9判断依据
			tmpSign = {
				{  368, 1052, 0x6b6670},
				{  375, 1052, 0x6b6670},
				{  365, 1047, 0x6b6670},
				{  358, 1036, 0x6c6771},
			}
			run.sTap(357, 1161, tmpSign, 100, 1500)
			--P9点击问题， P10-1判断依据
			tmpSign = {
				{  353,  336, 0xafc8e8},
				{  359,  336, 0xc5d6ed},
				{  357,  336, 0xffffff},
				{  357,  335, 0xfefeff},
			}
			run.sTap(369,  451, tmpSign, 100, 500)
			--P10点击确定， P11-1判断依据
			tmpSign = {
				{  648,  265, 0xdeb7b9},
				{  649,  265, 0xc4696d},
				{  650,  265, 0xc05e62},
				{  651,  265, 0xe0bdc0},
			}
			run.sTap(381,  813, tmpSign, 100, 500)
			--P11点击召唤羁绊， P12-1判断依据
			tmpSign = {
				{  624,  791, 0xfafbfa},
				{  624,  790, 0xd5e3d7},
				{  624,  789, 0x9abe9d},
				{  624,  788, 0x8ab48c},
			}
			run.sTap(382,  814, tmpSign, 100, 500)
			--P12点击召唤的羁绊， P13判断依据
			tmpSign = {
				{   80,  280, 0xaaa8ce},
				{   80,  288, 0xe5eff9},
				{   93,  340, 0x51353f},
				{   93,  356, 0x4c343f},
			}
			run.sTap(114,  914, tmpSign, 100, 500)
			--P13点击下一个召唤的羁绊， P14判断依据
			tmpSign = {
				{  319,  281, 0xaaa7ce},
				{  329,  281, 0xc3c4d5},
				{  344,  292, 0x5c464a},
				{  347,  294, 0x493131},
			}
			run.sTap(291,  915, tmpSign, 100, 500)
			--P14点击确定继续拍摄， P15判断依据
			tmpSign = {
				{  405,  336, 0xbfa1a0},
				{  402,  345, 0xfff7ef},
				{  393,  325, 0x5b3f45},
				{  414,  320, 0x4d343c},
			}
			run.sTap(374,  642, tmpSign, 100, 500)
			--P15点击确定继续拍摄， P16判断依据
			tmpSign = {
				{  186,  754, 0xfe849e},
				{   92,  810, 0xfc7e99},
				{  185,  333, 0x9d9ddb},
				{  197,  368, 0x999cdb},
			}
			run.sTap(373, 1181, tmpSign, 95, 500)
			--P16点击发布， P17判断依据
			tmpSign = {
				{  149,  273, 0x8b84be},
				{  160,  274, 0x8e86bf},
				{  217,  277, 0xeae4f3},
				{  218,  277, 0xe9e5f2},
			}
			run.sTap(361,  780, tmpSign, 98, 500)
			--P17点击发布， P18判断依据
			tmpSign = {
				{  219,   64, 0xd9aa93},
				{  220,   64, 0xd9aa93},
				{  225,   64, 0xfffefe},
				{  226,   64, 0xfbf6f4},
			}
			run.sTap(539, 1030, tmpSign, 95, 500)
			goto START_CHAPTER_LINE
		end
		
		-- 1-1 P4
		if (isColor( 340,  774, 0xc4696d, 95) and isColor( 311,  774, 0xc05e63, 95) and isColor( 306,  774, 0xc4696e, 95) and isColor( 311,  790, 0xc05e63, 95)) then
			run.xLog("startChapter 1-1")
			run.mRndSleep(500, 1000)
			--点击进入1-1
			run.dTap(357,  997)
			--等待出现获得人物
			local getFlag = false
			while getFlag do
				if (isColor( 560,  173, 0xfb577e, 85) and isColor( 573,  173, 0xfb587e, 85) and isColor( 570,  123, 0xfffafc, 85) and isColor( 572,  123, 0xffffff, 85)) then
					-- 出现获得人物
					getFlag = true
					--点击退出界面
					run.dTap(390, 1248)
				end
				run.mRndSleep(1000, 1500)
			end
			goto START_CHAPTER_LINE
		end
		
		
		--特殊事件
		-- 我的羁绊 P44
		if (isColor( 627,  815, 0xe8ccce, 99) and isColor( 628,  816, 0xc4676c, 99) and isColor( 629,  815, 0xeededf, 99) and isColor( 637,  820, 0xc05d62, 99) and isColor( 622,  815, 0xdeb1b3, 99) and isColor( 622,  816, 0xbf5a5f, 99) and isColor( 613,  828, 0xca7a7e, 99) and isColor( 614,  828, 0xc4676c, 99)) then
			--P44 主页点击我的羁绊
			run.dTap(78, 1046)
			run.mRnd(500, 1000)
			--P44-1 点击强化的羁绊
			run.dTap(149,  340)
			run.mRnd(500, 1000)
			--P44-2 提升羁绊等级
			run.dTap(150, 1209)
			run.mRnd(500, 1000)
			--P44-3 点击后退
			run.dTap(41,   48)
			run.mRnd(500, 1000)
			--P44-4缺失 再次点击后退
			run.dTap(41,   48)
			run.mRnd(500, 1000)
			goto START_CHAPTER_LINE
		end
		
		
		-- 特殊情况
		--1-7 P45
		oneSevenChapterFlag.x, oneSevenChapterFlag.y = run.findImage("1-7.png", 20000000, 189,  492, 544,  906)
		--1-6 P41
		oneSixChapterFlag.x, oneSixChapterFlag.y = run.findImage("1-6.png", 20000000, 100,  548,521,  881)
		--1-5 P32
		oneFiveChapterFlag.x, oneFiveChapterFlag.y = run.findImage("1-5.png", 20000000, 2,  491,744,  782)
		--1-4 P29-2
		oneFourChapterFlag.x, oneFourChapterFlag.y = run.findImage("1-4.png", 20000000, 201,  772, 481, 1042)
		--1-3 P18-1
		oneThreeChapterFlag.x, oneThreeChapterFlag.y = run.findImage("1-3.png", 20000000, 209,  854, 744, 1116)
		--1-2 P
		oneTwoChapterFlag.x, oneTwoChapterFlag.y = run.findImage("1-2.png", 20000000, 209,  980,485, 1269)
	end

end

-- 主函数
function main()
    --关闭app
    --closeApp("com.papegames.evol")
	--mSleep(500)
	
	-- 初始化日志
	run.initLog()
	run.xLog("begin")
	--打开app
	run.runApp("com.papegames.evol")
	
	--开始定义固定位置点击
	local threadId = thread.create(skipMoive, {})

	-- 定时器
	local threadIdScriptTimeOut = thread.create(scriptTimeOut, {})
	
	--章节前
	--startGame()
	
	--开始章节
	startChapter()
	
	--记录帐号信息
	--run.curl("account_feedback.php", "id="..accountTable.id.."&status=2&oubo="..accountTable.oubo)
	
	-- 关闭日志
	run.closeLog()
	
	-- end
	toast("脚本准备结束")
	while true do
		mSleep(3000)
		toast("1")
	end
end
--toast("bbb123")
main()
--x,y = run.findImage("1-4.png", 20000000, 201,  772, 481, 1042)
--toast(x)
--toast(x..y)
--tap(352, 943)
--x,y = run.findImage("1-3.png", 40, 6,  677)
--toast(x)
--local threadId = thread.create(skipMoive, {})
--run.dTap(50,   51)
--run.dTap(41,   48)
--while false do
--	mSleep(1000)
--end