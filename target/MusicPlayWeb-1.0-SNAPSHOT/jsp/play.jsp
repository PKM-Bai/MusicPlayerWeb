<%@ page import="com.music.entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>音乐播放器-播放页</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/play.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/assist.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/side_menu.css">

</head>

<body id="body">

<textarea name="" id="txt" cols="30" rows="10" style="display: none;">
	<c:if test="${lyric != null}">
		${lyric}
	</c:if>
</textarea>

<!--网页内容区-->
<div id="content">
	<div class="" style="float: none;">
		<!-- Header 顶部导航栏 -->
		<div class="page-header">
			<div class="">
				<div class="header-content">
					<!-- logo图片 -->
					<a class="fl logo-a" href="${pageContext.request.contextPath}/index.jsp">
						<img src="${pageContext.request.contextPath}/resources/image/logo.gif" alt="logo" class="fl" />
					</a>
					<!-- 导航栏 -->
					<ul class="header-nav fl">
						<li class="fl"><a href="${pageContext.request.contextPath}/index.jsp">首页</a></li>
						<c:if test="${user == null}">
							<li class="fl"><a href="javascript: alert('请先登录');">我的歌单</a></li>
						</c:if>
						<c:if test="${user != null}">
							<li class="fl"><a href="${pageContext.request.contextPath}/user/song_list?uid=${user.u_id}&sl_id=0">我的歌单</a></li>
						</c:if>
					</ul>
				</div>
				<!-- 用户状态 头像 -->
				<div class="fr user-status">
					<c:if test="${user == null}">
						<!-- 未登录的状态 -->
						<div id="no-loginStatus">
							请点击 <a href="javascript: showLoginWindow()" id="login">登录</a>
						</div>
					</c:if>
					<c:if test="${user != null}">
						<input type="text" value="${user.u_id}" style="display: none" id="uid">
						<!-- 登录成功的状态 -->
						<div id="loginStatus">
							<div>
								<img class="head" src="${pageContext.request.contextPath}/resources/image/HeadPortrait/${user.head}" alt="" id="head">
								<a href=""></a>
							</div>
							<div class="user-message-box" style="display: none">
								<ul class="user-message">
									<li><a href="javascript: toJumpUser_index()">我的主页</a></li>
									<li><a href="javascript: out_login()">退出</a></li>
								</ul>
							</div>
						</div>
					</c:if>
				</div>
			</div>
		</div>

		<!-- 登录框 -->
		<div class="login-box" style="display: none">
			<div class="login_box">
				<ul class="login_inputs">
					<li><p>用户名：</p><input class="log_input" type="text" placeholder="用户名" id="username"></li>
					<li><p>密&nbsp;&nbsp;&nbsp;码：</p><input class="log_input" type="password" placeholder="密码" id="password"></li>
					<li>
						<input class="log_button" type="button" value="登 录" onclick="login()">
						<input class="initdb_button" type="button" value="初始化数据库" onclick="init_db()">
					</li>

				</ul>
			</div>
		</div>

		<!-- content 中间内容 -->
		<div class="page-main fl">
			<button class="menu-button" id="open-button">Open Menu</button>
			<!-- 播放列表 -->
			<div class="menu-wrap fl">
				<nav class="menu">
					<h3>播放列表</h3>
					<div class="list-title">
						<div class="song-code">#</div>
						<div class="song-name">歌曲</div>
						<div class="singer-name">歌手</div>
						<div class="duration">时长</div>
					</div>
					<hr/>
					<ul class="song-list">
						<c:if test="${playList != null}">
							<c:forEach items="${playList}" var="m" varStatus="item">
								<c:if test="${m.id.equals(music.id)}">
									<li class="song-slot song-listPlayStus">
										<a href="${pageContext.request.contextPath}/play/playMusic?id=${m.id}">
											<div class="song-code">${item.index + 1}</div>
											<div class="song-name" title="${m.musicName}">${m.musicName}</div>
											<div class="singer-name" title="${m.singer}">${m.singer}</div>
											<div class="duration">${m.duration}</div>
										</a>
									</li>
								</c:if>
								<c:if test="${!(m.id.equals(music.id))}">
									<li class="song-slot">
										<a href="${pageContext.request.contextPath}/play/playMusic?id=${m.id}">
											<div class="song-code">${item.index + 1}</div>
											<div class="song-name" title="${m.musicName}">${m.musicName}</div>
											<div class="singer-name" title="${m.singer}">${m.singer}</div>
											<div class="duration">${m.duration}</div>
										</a>
									</li>
								</c:if>
							</c:forEach>
						</c:if>
					</ul>
				</nav>
				<button class="close-button" id="close-button">Close Menu</button>
			</div>
			<!-- 歌词-播放部分 -->
			<div class="play-content fl">
				<article class="lyricBG" style="background: rgba(33, 33, 33, 0.6)">
					<div class="title">${music.musicName}</div>
					<div class="singer">${music.singer}</div>
					<div class="lrc" data-lyric="${pageContext.request.contextPath}/resources/music/lyric/${music.lyricFile}">
						<div class="content"></div>
					</div>
				</article>
				<audio id="myMusic" src="${pageContext.request.contextPath}/resources/music/flac/${music.musicFile}">
					您的浏览器不支持音频播放！！！！
				</audio>
			</div>

			<!-- 设置 -->
			<div class="setting-wrap">
				<nav class="setting">
					<!-- 调整歌词播放颜色 -->
					<div class="set-lyric-color">
						<h4 class="setting-title">歌词颜色</h4>
						<hr>
						<div>
							<p>前景色</p>
							<input id="f-color1" type="color" value="#ff0202">
							<input id="f-color2" type="color" value="#f49595" >
						</div>
						<div>
							<p>背景色</p>
							<input id="b-color1" type="color" value="#0ecbfa">
							<input id="b-color2" type="color" value="#43f91f">
						</div>
					</div>
					<!-- 设置背景图片透明度 -->
					<div class="set-lyric-color">
						<h4 class="setting-title">歌词背景透明度</h4>
						<hr>
						<div>
							<input type="range" min="0" max="1" step="0.01" value="0.6" id="opacityRange">
							<span id="bgOpacityNum">0.6</span>
						</div>
					</div>
				</nav>
				<button class="close-setting" id="close-setting">Close Menu</button>
			</div>
			<button class="setting-button" id="open-setting">设置</button>
		</div>

		<!-- 播放控件 -->
		<div class="play-bar">
			<div class="seekBar">
				<div id="Pikachu"><img src="${pageContext.request.contextPath}/resources/image/PikachuRun.gif" alt=""></div>
				<div class="bar-control u-process" id="seekBar">
					<!-- 鼠标移动到进度条上，显示的时间信息 -->
					<div id="ins-time"></div>
					<!-- 鼠标移动到进度条上，进度条变暗部分 -->
					<div id="s-hover"></div>
					<!-- 表示当前歌曲播放进度的蓝色进度条 -->
					<div class="current-process" id="currentProcess"></div>
				</div>
			</div>
			<div class="play-bar-inside">
				<div class="process-info fl">
					<div class="info flexbox">
						<img src="" alt="">
						<span class="songInfo clearfix">${music.musicName}</span>
						<span class="songInfo clearfix">${music.singer}</span>
						<img src="${pageContext.request.contextPath}/resources/icons/收藏.png" alt="我喜欢" class="icons" onclick="add_live_songlist(154822,'${music.id}')" />
					</div>
				</div>
				<div class="play-control fl">
					<div class="last-song iconfont fl" id="lastSong" data-id="${music.id}">
						<img class="icons" src="${pageContext.request.contextPath}/resources/icons/上一曲.png" alt="" id="previous">
					</div>
					<div class="music-control iconfont fl">
						<img class="play" src="${pageContext.request.contextPath}/resources/icons/播放音乐.png" alt="播放" >
					</div>
					<div class="next-song iconfont fl" id="nextSong" data-id="${music.id}">
						<img class="icons" src="${pageContext.request.contextPath}/resources/icons/下一曲.png" alt="" id="next">
					</div>
				</div>
				<div class="playbar-right">
					<!-- 音量调节 -->
					<div class="voice-box clearfix">
						<span class="voice-icon">
							<img class="icons" src="${pageContext.request.contextPath}/resources/icons/音量.png" alt="" id="volume">
							<input type="range" min="0" max="100" step="1" id="volumeRange" width="100px" value="${playSetting == null ? 100 : playSetting.musicVolume}">
						</span>
						<span id="volumeNum">${playSetting == null ? 100 : playSetting.musicVolume}</span>
					</div>
					<!-- 播放模式 -->
					<div class="type">
						<input type="text" id="playMode_id" value="0" hidden />
						<span><img class="icons" id="playMode" src="${pageContext.request.contextPath}/resources/icons/列表循环.png" alt=""></span>
					</div>
					<span class="times">
						<span id="currentTime">00:00</span>&nbsp;/&nbsp;
						<span id="totalTime">${music.duration}</span>
					</span>
				</div>
			</div>
		</div>
	</div>
</div>

<!--鼠标效果展示区-->
<div id="canvas-main">
	<canvas id="canvas" class="sbxg"></canvas>
<%--	${pageContext.request.contextPath}/resources/image/pageBG/index-bg06.jpg--%>
	<img src="" id="canvas-bg">
</div>
<input type="hidden" id="singerImgList" value='${singerImgList}'>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/playMusic.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/assist.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/playSetting.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/侧菜单/classie.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/侧菜单/sidesetting.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/侧菜单/sidemenu.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquerysession.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/hovertree.js"></script>


<script>
	var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);

	// 更改背景
	var singerName = document.getElementsByClassName("singer")[0].textContent
	var bg_index = 0;
	let random_index = 0;
	var bg_img = document.getElementById("canvas-bg")
	var str = $("#singerImgList").val();
	var bgImgList = [];
	// 判断后台传的路径是否有值，如果路径为空-则使用pageBG文件夹中的背景图片
	if(str == '[]' || str == ''){
		for (let i = 1; i <= 8; i++) {
			bgImgList.push(projectName + "/resources/image/pageBG/index-bg"+i+".jpg");
		}
	}else{ // 不为空-先讲传输过来的字符串分隔拆分成数组，使用歌手写真图片做背景
		var tempList = str.substring(1, str.length-1).split(', ')
		for (let i = 0; i < tempList.length; i++) {
			bgImgList.push(projectName + "/resources/image/Singer/"  + singerName + "/" + tempList[i]);
		}
	}
	// floor(x)对 x 进行下舍入，即向下取整。
	// ceil(x) 对 x 进行上舍入，即向上取整。
	// round(x)四舍五入。
	random_index = Math.floor(Math.random() * bgImgList.length);
	bg_img.setAttribute("src", bgImgList[random_index]);

	function switchBG(){
		// if(bg_index >= bgImgList.length)
		// 	bg_index = 0
		while (random_index == bg_index){
			random_index = Math.floor(Math.random() * bgImgList.length);
			// console.log(random_index)
		}
		bg_index = random_index;
		bg_img.setAttribute("src", bgImgList[bg_index]);
	}

	if (bgImgList.length != 1)
	{
		setInterval(switchBG, 10000);  // 循环调用switchBG()函数，时间间隔为ms
	}


	/**--------    跳转-用户主页   --------**/
	function toJumpUser_index() {
		let uid = document.getElementById("uid").value;
		window.open(projectName + "/user/index?uid=" + uid);   // 在新窗口打开
	}
	/**--------    登录   --------**/
// 获取登录的box标签
	let login_box = document.getElementsByClassName("login-box")[0];
	// 显示登录窗口的方法
	function showLoginWindow() {
		login_box.setAttribute("style", "")
	}
	// 使用jquery的类选择器方法给头部导航栏和主题内容区添加点击事件，点击他们范围的div时触发隐藏登录框
	$(".page-header").click(function () {
		if (login_box.getAttribute("style") == ""){
			login_box.setAttribute("style", "display: none")
		}
	});
	$(".page-main").click(function () {
		if (login_box.getAttribute("style") == ""){
			login_box.setAttribute("style", "display: none")
		}
	});
	function login(){
		let name = $("#username").val();
		let pswd = $("#password").val();
		if(name == "")
		{
			alert("用户名不能为空！");
			return;
		}
		if(pswd == "")
		{
			alert("密码不能为空！");
			return;
		}
		$.ajax({
			url: projectName + "/user/login",
			type: "post",
			data: { "accountNum": name, "password": pswd },
			dataType: "json",
			success: function(data) {
				console.log(data);
				if (data["msg"] == "处理失败")
				{
					alert("用户名或者密码错误！");
				}
				else{
					window.location.reload();
				}

			},
			error: function (){
				console.log("报错");
			}
		});
	}
	/**--------    退出登录   --------**/
	function out_login(){
		$.ajax({
			url: projectName + "/user/out_login",
			type: "get",
			success: function() {
				window.location.reload();
			},
			error: function (){
				console.log("报错");
			}
		});
	};
	function userPage_out_login(){
		location.href = projectName + "/user/userPage_out_login";
	};

	/**--------    数据库初始化  --------**/
	function init_db() {
		$.ajax({
			url: projectName + "/user/init_db",
			type: "get",
			success: function() {
				window.location.reload();
			},
			error: function (){
				window.location.reload();
			}
		});
	};

	/**--------    添加到喜欢的歌单中   --------**/
	function add_live_songlist(sl_id, m_id) {
		$.ajax({
			url: projectName + "/songlist/addMusic",
			type: "post",
			data: { "sl_id": sl_id, "m_id": m_id },
			dataType: "json",
			success: function() {
				alert("添加成功！");
			},
			error: function (){
				alert("添加失败或已存在");
			}
		});
	}

</script>

</body>
</html>
