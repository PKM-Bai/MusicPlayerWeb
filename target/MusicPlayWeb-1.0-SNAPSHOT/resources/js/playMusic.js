
// 获取主机地址之后的目录，如： test/test.jsp
var pathName = window.document.location.pathname;
//获取带"/"的项目名，如：/test
var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);

var body = document.getElementById("content");

/** 功能按钮 **/
var play_btn = document.getElementsByClassName("play")[0];					// 音乐播放<div>
var last_btn = document.getElementById("lastSong");					// 播放上一首<div>
var next_btn = document.getElementById("nextSong");						// 播放下一首<div>
var volume_btn = document.getElementById("volume");						// 音量按钮
var volume_range = document.getElementById("volumeRange");					// 音量调节
var playMode_btn = document.getElementById("playMode");
var playMode_id = document.getElementById("playMode_id");

var myMusic = document.getElementById("myMusic")					// 播放音频<audio>
var txt = document.getElementById("txt");							// 歌词文本<textarea>
var con = document.getElementsByClassName("content")[0];			// 歌词展示<div>
var volume_num = document.getElementById("volumeNum");            // 音量

var buffInterval = null          // 初始化定时器 判断是否需要缓冲

var playStatus = false		// 播放状态 默认播放
var mutedStatus = false;	// 静音状态
var current_Time = document.getElementById("currentTime")
var total_Time = document.getElementById("totalTime")

/** ---------------------------------------         功能区       ------------------------------------- **/
function pauseMusic() {
	myMusic.pause()
	playStatus = true
	play_btn.setAttribute("src", projectName+"/resources/icons/播放音乐.png")
	// 停止计时
	clearInterval(buffInterval);
}
function playMusic() {
	console.log("播放");
	myMusic.play()
	playStatus = false
	play_btn.setAttribute("src", projectName+"/resources/icons/停止播放.png")

	// 开始计时
	checkBuffering();	// 检测音乐缓冲，并创建计时器
}



play_btn.onclick = function(){
	// 开始播放
    if(playStatus)
		playMusic();
	// 停止播放
	else
		pauseMusic();
}


// 上一首
last_btn.onclick = function() {
	window.location = projectName + "/play/lastSong?id="+last_btn.getAttribute("data-id")
}

// 下一首
next_btn.onclick = function() {
	// 当前模式如果是随机播放，则使用随机播放的方式播放下一首
	if (playMode_id.value != "2")
		window.location = projectName + "/play/nextSong?id="+next_btn.getAttribute("data-id")
	else
		window.location = projectName + "/play/randomPlay?id="+next_btn.getAttribute("data-id");
}

// 切换播放模式
playMode_btn.onclick = function () {
	playMode_id.value++;
	if(playMode_id.value > 3)
		playMode_id.value = 0;
	$.session.set("playModeId", playMode_id.value);
	console.log(playMode_id.value)
	switchPlayMode(playMode_id.value)
}
// 切换播放模式
function switchPlayMode(modeId) {
	switch (modeId) {
		case "0":  // 列表循环
			playMode_btn.setAttribute("src", projectName + "/resources/icons/列表循环.png");
			break;
		case "1":  // 单曲循环
			playMode_btn.setAttribute("src", projectName + "/resources/icons/单曲循环.png");
			break;
		case "2":  // 随机播放
			playMode_btn.setAttribute("src", projectName + "/resources/icons/随机播放.png");
			break;
		case "3":  // 顺序播放
			playMode_btn.setAttribute("src", projectName + "/resources/icons/顺序播放.png");
			break;
	}
}
function switchPlay(modeId) {
	switch (modeId) {
		case "0":  // 列表循环
			window.location = projectName + "/play/nextSong?id="+next_btn.getAttribute("data-id");
			break;
		case "1":  // 单曲循环
			window.location = projectName + "/play/singlePlay?id="+next_btn.getAttribute("data-id");
			break;
		case "2":  // 随机播放
			window.location = projectName + "/play/randomPlay?id="+next_btn.getAttribute("data-id");
			break;
		case "3":  // 顺序播放 -->查找当前播放音乐是否为列表中最后一个
			$.ajax({
				url: projectName + "/play/isListPlayOver",
				data: {"id": next_btn.getAttribute("data-id")},
				success: function (data)
				{
					// console.log(data.extend["over"])
					if(data.extend["over"]) // 是最后一个暂停播放
						pauseMusic();
					else // 不是最后一个 播放下一首
						window.location = projectName + "/play/nextSong?id="+next_btn.getAttribute("data-id");
				}
			});
			break;
	}
}


// 静音
volume_btn.onclick = function () {
	if (!mutedStatus){
		myMusic.muted = true;
		volume_btn.setAttribute("src", projectName+"/resources/icons/禁音.png")
	}
	else{
		myMusic.muted = false;
		volume_btn.setAttribute("src",projectName+"/resources/icons/音量.png")
	}
	mutedStatus = myMusic.muted;
};

// 调节音量
volume_range.onchange = function () {
	myMusic.volume = volume_range.value / 100;
	volume_num.innerText = volume_range.value;
	if (parseInt(volume_range.value) == 0){
		myMusic.muted = true;
		volume_btn.setAttribute("src", projectName+"/resources/icons/禁音.png")
	} else {
		myMusic.muted = false;
		volume_btn.setAttribute("src", projectName+"/resources/icons/音量.png")
	}
	SavePlaySetting();
	mutedStatus = myMusic.muted;   // 获取当前音乐是否是禁音状态
}


/** ---------------------------------------         歌词生成和滚动特效       ------------------------------------- **/
var lrc = txt.value;				// 整段歌词
var lrcArr = lrc.split("[");		// 将歌词整段内容通过"["分隔，每个元素内容为 "00:07.43]歌词"
var html = "";
var p_cuTime = [];
// console.log(lrc)
if(lrc == "\t\n"){
	html = "暂无匹配歌词！"
}
else{
	// 歌词拆分，把<textarea>标签中的内容替换成<p>标签显示在页面上
	for(var i=0; i < lrcArr.length ; i++){
		var arr = lrcArr[i].split("]")	// 再根据"]"将每一段的歌词时间和歌词分隔  arr[0]是歌词时间, arr[1]是歌词
		var time = arr[0].split(".")			// 03:19.88  分隔成[03:19, 88]
		var timer = time[0].split(":")			// 03:19     分隔成[03, 19]
		var ms = timer[0] * 60 + timer[1] * 1	// 将分钟和秒数相加 得出播放当前歌词的毫秒
		var text = arr[1]
		// console.log("分：" + time + ", 秒：" + timer + ",毫秒：" + ms)

		// 将每段歌词通过<p>标签添加到页面上，
		if(text){	// 判断text字符串中是否含有内容,不存在内容就为false
			p_cuTime.push(ms);
			// p标签中的id属性通过 毫秒 添加，方便根据id属性调整歌词滚动效果
			html += "<p id=" + ms +" class='lrc-p' data-title="+(i-1)+">" + text + "</p>";
		}
	}
}
con.innerHTML = html;


// --------歌词滚动--------
var lyricIndex = 0;
var playlyricRow = 0;
var isRoll = false;
var isChange = false;
var oP = con.getElementsByTagName("p")		// 所有<p>标签
function lyricRoll(curTime) {
	// 使用播放时间查找与id属性一致的歌词
	if(document.getElementById(curTime))
	{
		playlyricRow = curTime;
		lyricIndex = parseInt(document.getElementById(curTime).getAttribute("data-title"))
		// 遍历所有<p>标签 添加css样式
		for(var i=0; i < oP.length ; i++) {
			oP[i].style.cssText = "background: linear-gradient(-3deg,"+ fcolor1Value + " 0%, " + fcolor2Value + " 100%);\n-webkit-background-clip: text;"
		}
		// 为当前正在播放的歌词添加特殊样式
		document.getElementById(curTime).style.cssText = "background: linear-gradient(-3deg, " + bcolor1Value +" 0%, "+ bcolor2Value+" 100%);-webkit-background-clip: text;color: transparent;font-size: 20px;";
		if (isRoll || isChange)
			con.style.top = -30 * (lyricIndex-4) + "px";	// content样式top 逐渐向上移动20px

		// 播放行大于5时开启滚动
		lyricIndex > 4 ? isRoll = true : isRoll = false;
	}
}


// 为audio音乐添加事件响应
myMusic.addEventListener("timeupdate",function(){
	var curTime = parseInt(this.currentTime)   // 播放开始音乐时的播放时间（秒） 并转换为整型
	lyricRoll(curTime)
})

/** ---------------------------------------         进度条       ------------------------------------- **/
var seekBar = $("#seekBar");					// 进度条部分
var seekBarCurrent = $("#currentProcess");		// 进度条当前播放部分
var insTime = $("#ins-time");					// 鼠标移动到进度条上面，显示的信息部分
var sHover = $("#s-hover");						// 鼠标移动到进度条上面，背景变暗的进度条部分
var seekBarPos, seekT, seekLoc, cM, ctMinutes, ctSeconds, curMinutes, curSeconds, durMinutes, durSeconds, playProgress, bTime, nTime = 0;
var pikachu = document.getElementById("Pikachu")	// 进度条上的皮卡丘
// 1. 鼠标移动到进度条上触发
function showHover(e) {
	seekBarPos = seekBar.offset()	// 获取进度条长度
	seekT = e.clientX - seekBarPos.left;
	seekLoc = myMusic.duration * (seekT / seekBar.outerWidth()); //当前鼠标位置的音频播放秒数 音频长度（s） * (鼠标在进度条的位置 / 进度条的宽度)
	sHover.width(seekT); 	//设置鼠标移动到进度条变暗的部分宽度
	cM = seekLoc / 60;		//计算播放了多少时间：音频播放秒数/60

	ctMinutes = Math.floor(cM);		//向下取整
	ctSeconds = Math.floor(seekLoc - ctMinutes * 60);	// 计算播放秒数

	if ((ctMinutes < 0) || (ctSeconds < 0))
		return;

	if (ctMinutes < 10)
		ctMinutes = "0" + ctMinutes;
	if(ctSeconds < 10)
		ctSeconds = "0" + ctSeconds;

	if (isNaN(ctMinutes) || isNaN(ctSeconds))
		insTime.text("--:--");
	else
		insTime.text(ctMinutes + ":" + ctSeconds);	// 设置鼠标移动到进度条上显示的信息
	insTime.css({'left':seekT, 'top':'-45px','margin-left':'-21px'}).fadeIn(0);	// 淡入效果显示

};

// 鼠标从进度条离开触发
function hideHover() {
	sHover.width(0)		//设置鼠标移动到进度条上变暗的部分宽度 重置为0
	insTime.text('00:00').css({'left':'0px', 'margin-left':'0px'}).fadeOut(0);
}

var resultRow = 0;
// 点击进度条时触发
function playFromClickedPos() {
	myMusic.currentTime = seekLoc;			// 设置音频播放时间，为当期鼠标点击的位置时间
	seekBarCurrent.width(seekT);			// 设置进度条播放长度，为当期鼠标点击的长度

	// 设置歌词滚动到当前音乐进度处
	isChange = true;
	var curTime = parseInt(myMusic.currentTime);
	resultRow = 0;
	for (var tr=curTime-30; tr <= curTime; tr++) {
		if (document.getElementById(tr))
		{
			if (Math.abs(tr-curTime) <= Math.abs(resultRow - curTime))
				resultRow = tr;
		}
	}
	lyricRoll(resultRow);

	pikachu.style.marginLeft = seekBarCurrent.width() - 18 + "px";

	seekBar.onmouseout = function () {
		sHover.width(0)		//设置鼠标移动到进度条上变暗的部分宽度 重置为0
		insTime.text('00:00').css({'left':'0px', 'margin-left':'0px'}).fadeOut(0);
	}
}

// 更新音乐的当前播放时间和总播放时间
function updateCurrTime() {
	nTime = new Date();		// 获取当前时间
	nTime = nTime.getTime()	// 将该时间转化为毫秒数

	// 计算当前音频播放的时间
	curMinutes = Math.floor(myMusic.currentTime / 60);
	curSeconds = Math.floor(myMusic.currentTime - curMinutes * 60);
	// 计算当前音频总时间
	durMinutes = Math.floor(parseInt(myMusic.duration) / 60);
	durSeconds = Math.floor(parseInt(myMusic.duration) - durMinutes * 60);
	// 计算播放进度百分比
	playProgress = (myMusic.currentTime / myMusic.duration) * 100;

	// 如果时间为个位数 设置其格式
	if(curMinutes < 10)
		curMinutes = '0'+curMinutes;
	if(curSeconds < 10)
		curSeconds = '0'+curSeconds;

	if(durMinutes < 10)
		durMinutes = '0'+durMinutes;
	if(durSeconds < 10)
		durSeconds = '0'+durSeconds;

	if( isNaN(curMinutes) || isNaN(curSeconds) )
		current_Time.innerText = '00:00';
	else
		current_Time.innerText = curMinutes+':'+curSeconds;

	if( isNaN(durMinutes) || isNaN(durSeconds) )
		total_Time.innerText = '00:00';
	else
		total_Time.innerText = durMinutes+':'+durSeconds;

	// 设置播放进度条的长度
	seekBarCurrent.width(playProgress+'%');
	// 拖动进度条状态下 图片不跟随进度条走
	isDrag ? null : pikachu.style.marginLeft = seekBarCurrent.width() - 18 + "px";

	// 进度条为100 即歌曲播放完时
	if( playProgress == 100 )
	{
		switchPlay(playMode_id.value);

		pauseMusic(); // 切换播放状态-停止播放
		seekBarCurrent.width(0);         	// 播放进度条重置为0
		pikachu.style.marginLeft = "-18px";
		current_Time.innerText = '00:00';       	// 播放时间重置为 00:00

	}


}
// 定时器检测是否需要缓冲
function checkBuffering(){
	clearInterval(buffInterval);
	buffInterval = setInterval(function()
	{
		bTime = new Date();
		bTime = bTime.getTime();
	},100);
}

// 实现拖动进度条
var isDrag = false;
pikachu.onmousedown = function (e) {
	isDrag = true;
	// 浏览器有一些图片的默认事件,这里要阻止
	e.preventDefault();
	this.style.cursor = 'move';
	var disX = e.clientX - pikachu.offsetLeft;	// 鼠标相对于图片的位置
	// 跟随移动
	body.onmousemove = function (e) {
		// 鼠标位置
		var x = e.clientX - disX;
		pikachu.style.marginLeft = x + "px";
		showHover(e);
	}
	// 鼠标弹起后停止移动
	body.onmouseup = function () {
		isDrag = false;
		body.onmousemove = null;
		body.onmouseup = null;
		pikachu.style.cursor = 'default';

		playFromClickedPos();
		hideHover();
	}
}

// 初始化
function initPlayer() {
	// selectTrack(0);       // 初始化第一首歌曲的相关信息
	myMusic.loop = false;   // 取消歌曲的循环播放功能

	// 进度条 移入/移出/点击 动作触发相应函数
	seekBar.mousemove(function(event){ showHover(event); });
	seekBar.mouseout(hideHover);
	seekBar.on('click', playFromClickedPos);

	// 实时更新播放时间
	$(myMusic).on('timeupdate', updateCurrTime);

}

initPlayer();


/******* 加载页面后时执行 ********/
// $(document).ready() 简写：$()
$(function ()
{
	// 每次跳转或者刷新页面更新音量控制
	myMusic.volume = volume_range.value / 100;


	// 页面更新播放模式
	if ($.session.get("playModeId"))
		playMode_id.value = $.session.get("playModeId");
	switchPlayMode(playMode_id.value);

	// 加载页面时调用播放音乐---自动播放
	playMusic();
})





