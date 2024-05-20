<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>我的歌单</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/assist.css">
<%--	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/play.css">--%>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user-songList.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/button-style.css">

</head>

<body id="body">

<!--网页内容区-->
<div id="content" class="user-contentBox">
	<!-- Header 顶部导航栏 -->
	<div class="page-header">
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
							<li><a href="javascript: userPage_out_login()">退出</a></li>
						</ul>
					</div>
				</div>
			</c:if>
		</div>
    </div>
	<!-- 登录框 -->
	<div class="login-box" style="display: none">
		<div class="login_box">
			<h1 class="title">欢 迎 登 录</h1>
			<ul class="login_inputs">
				<li><p>用户名：</p><input class="log_input" type="text" placeholder="用户名" id="username"></li>
				<li><p>密&nbsp;&nbsp;&nbsp;码：</p><input class="log_input" type="password" placeholder="密码" id="password"></li>
				<li><input class="log_button" type="button" value="登 录" onclick="login()"></li>
			</ul>
		</div>
	</div>

	<!-- 内容 -->
	<div class="page-main">
	<div class="user-content">
		<!-- 左侧菜单导航栏 -->
		<div class="sl-menu" style="height: 728px">
			<details class="menu" open>
				<summary>
					<h3>
						我创建的歌单（${creatSongList.size()}）
						<a href="" class="addsl-button fr">新建</a>
					</h3>
				</summary>
				<ul class="songLists">
					<c:if test="${creatSongList.size() != 0}">
					<c:forEach items="${creatSongList}" var="creatSL" varStatus="item">
						<c:if test="${creatSL.sl_id == songList.sl_id}">
							<li class="select" data-index="${item.index}" data-sl_id="${creatSL.sl_id}" name="creat_sl">
								<a href="#">
									<div class="fl">
										<c:if test="${creatSL.musicList.size() != 0}">
											<img src="${pageContext.request.contextPath}/resources/image/MusicImg/${creatSL.musicList.get(0).musicImg}" alt="">
										</c:if>
									</div>
									<div class="">
										<p class="over-hien" title="">${creatSL.sl_name}</p>
										<p>${creatSL.musicList.size()}首</p>
									</div>
								</a>
							</li>
						</c:if>
						<c:if test="${creatSL.sl_id != songList.sl_id}">
							<li class="" data-index="${item.index}" data-sl_id="${creatSL.sl_id}" name="creat_sl">
								<a href="#">
									<div class="fl">
										<c:if test="${creatSL.musicList.size() != 0}">
											<img src="${pageContext.request.contextPath}/resources/image/MusicImg/${creatSL.musicList.get(0).musicImg}" alt="">
										</c:if>
									</div>
									<div class="">
										<p class="over-hien" title="">${creatSL.sl_name}</p>
										<p>${creatSL.musicList.size()}首</p>
									</div>
								</a>
							</li>
						</c:if>
					</c:forEach>
					</c:if>
					<c:if test="${creatSongList.size() == 0}">
						<li class="">
							暂无歌单
						</li>
					</c:if>
				</ul>
			</details>
		</div>
		<!-- 右侧内容显示区 -->
		<div class="sl-content">
			<!-- 歌单信息 -->
			<div class="sl-info clearfix">
				<div class="slImg">
					<c:if test="${songList.musicList.size() != 0}">
					<img src="${pageContext.request.contextPath}/resources/image/MusicImg/${songList.musicList.get(0).musicImg}" alt="">
					</c:if>
				</div>
				<div class="sl-infoDiv">
					<div style="margin-left: 230px;">
						<div class="slName">
							<img src="${pageContext.request.contextPath}/resources/icons/歌单icon.png" class="fl" title="歌单">
							<h2>${songList.sl_name}</h2>
						</div>
						<div class="slInfo">
							<a href=""><img src="${pageContext.request.contextPath}/resources/image/HeadPortrait/${user.head}" alt=""></a>
							<span> <a href="">${user.name}</a> </span>
							<span>${songList.sl_creatTime} 创建</span>
						</div>
						<div class="slFunc">
							<a href="${pageContext.request.contextPath}/play/playSongList?sl_id=${songList.sl_id}&uid=${user.u_id}" id="play-btn" data-playlist="${songList.sl_id}" class="btn-two red small">播放歌单</a>
							<a href="" class="btn-two white mini slFunc-btn">收藏</a>
							<a href="" class="btn-two white mini slFunc-btn">分享</a>
							<a href="" class="btn-two white mini slFunc-btn">下载</a>
							<a href="" class="btn-two white mini slFunc-btn">评论</a>
						</div>
					</div>
				</div>
			</div>
			<!-- 歌曲列表 -->
			<div class="sl-title clearfix">
				<h3>歌曲列表</h3>
				<span class="song-num">${songList.musicList.size()}首歌</span>
				<div class="sl-plays">
					播放：<strong>${songList.sl_plays}</strong> 次
				</div>
			</div>
			<div>
				<table class="m-table">
					<thread>
						<tr>
							<th class="w1"> <div class="wp"> </div> </th>
							<th> <div class="wp">歌曲标题</div> </th>
							<th> <div class="wp">时长</div> </th>
							<th> <div class="wp">歌手</div> </th>
							<th> <div class="wp">专辑</div> </th>
							<th class="bj"> <div class="wp">编辑</div> </th>
						</tr>
					</thread>
					<%-- 歌单中的歌曲列表 --%>
					<tbody id="song_table">
					<c:forEach items="${songList.musicList}" var="music" varStatus="item">
						<tr>
							<td>
								<div class="ply" data-musicID="${music.id}">
									<a href="${pageContext.request.contextPath}/play/playMusic?id=${music.id}" class="fr"><img src="${pageContext.request.contextPath}/resources/icons/歌单-播放.png" alt=""></a>
									<span class="num">${item.index +1}</span>
								</div>
							</td>
							<td><div class="tt"> <a href="">${music.musicName}</a> </div></td>
							<td>${music.duration}</td>
							<td><div class="tt"> <a href="">${music.singer}</a> </div></td>
							<td><div class="tt"> <a href="">专辑${item.index +1}</a> </div></td>
							<td><div class="tt edit">
								<a href="javascript: fromSLRemoveMusic('${songList.sl_id}', '${music.id}')"><img name="del-btn" src="${pageContext.request.contextPath}/resources/icons/删除.png" class="icon" title="删除"></a>
								<a href="${pageContext.request.contextPath}/downMusic?filename=${music.musicFile}"><img name="down-btn" src="${pageContext.request.contextPath}/resources/icons/下载.png" class="icon" title="下载"></a>
							</div></td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	</div>

</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/assist.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/user-songList.js"></script>
<script type="text/javascript">
	// 左侧创建歌单的事件
	var creat_sl = document.getElementsByName("creat_sl");
	for (let i = 0; i < creat_sl.length; i++) {
		creat_sl[i].onclick = function () {      // 点击歌单标签事件
			creat_sl[i].setAttribute("class", "select");   // 那个歌单被点击了添加选中样式
			// 将其他歌单的选中样式取消
			for (let j = 0; j < creat_sl.length; j++) {
				if (j != i) { creat_sl[j].setAttribute("class", ""); }
			}

			// 歌单内容变化
			$.ajax({
				url: "${pageContext.request.contextPath}/songlist/switch_sl",
				type: "get",
				data: {"sl_id" : creat_sl[i].getAttribute("data-sl_id")},
				dataType: "json",
				success: function (data) {
					var songList = data.extend.songList;
					var musicList = songList.musicList;
					// console.log(songList);

					$(".slImg img").remove();
					$(".slName h2").remove();
					$(".slInfo span").remove();
					$(".sl-title>*").remove();
					$(".slFunc>*").remove();

					$("#song_table tr").remove();

					if(musicList.length != 0)
						$(".slImg").append('<img src="${pageContext.request.contextPath}/resources/image/MusicImg/'+ musicList[0].musicImg +'" alt="">');
					$(".slName").append('<h2>'+ songList.sl_name+'</h2>');
					$(".slInfo").append('<span> <a href="">${user.name}</a> </span>').append('<span>'+songList.sl_creatTime+' 创建</span>');
					$(".sl-title")
							.append('<h3>歌曲列表</h3>')
							.append('<span class="song-num">'+ musicList.length +'首歌</span>')
							.append('<div class="sl-plays">播放：<strong>'+songList.sl_plays+'</strong> 次</div>')
					$(".slFunc").append('<a href="${pageContext.request.contextPath}/play/playSongList?sl_id='+ songList.sl_id +'" id="play-btn" data-playlist="'+songList.sl_id+'" class="btn-two red small">播放歌单</a>')
							.append('<a href="" class="btn-two white mini slFunc-btn">收藏</a>')
							.append('<a href="" class="btn-two white mini slFunc-btn">分享</a>')
							.append('<a href="" class="btn-two white mini slFunc-btn">下载</a>')
							.append('<a href="" class="btn-two white mini slFunc-btn">评论</a>');
					for (let i = 0; i < musicList.length; i++) {
						var tr = '';

						var img = '<img src="${pageContext.request.contextPath}/resources/icons/歌单-播放.png" alt="">';
						var span1 = '<a href="'+ projectName + '/play/playMusic?id='+musicList[i].id +'" class="fr">'+ img +'</a>';
						var span2 = '<span class="num">'+ (i+1) +'</span>';

						var div1 = '<div class="ply">'+ span1 + span2 +'</div>';
						var div2 = '<div class="tt"> <a href="">'+ musicList[i].musicName +'</a> </div>';
						var div4 = '<div class="tt"> <a href="">'+ musicList[i].singer + '</a> </div>';
						var div5 = '<div class="tt"> <a href="">专辑'+ (i+1) +'</a> </div>';

						var del_img = '<img name="del-btn" src="${pageContext.request.contextPath}/resources/icons/删除.png" class="icon" title="删除">';
						var a1 = '<a href="javascript: fromSLRemoveMusic(\''+songList.sl_id+'\',\''+ musicList[i].id +'\')">'+ del_img +'</a>';
						var a2 = '<a href="${pageContext.request.contextPath}/downMusic?filename='+ musicList[i].musicFile +'"><img name="down-btn" src="${pageContext.request.contextPath}/resources/icons/下载.png" class="icon" title="下载"></a>';
						var div6 = '<div class="tt edit">'+a1+a2+'</div>';

						var td1 = '<td>'+ div1 +'</td>';
						var td2 = '<td>'+ div2 +'</td>';
						var td3 = '<td>'+ musicList[i].duration +'</td>';
						var td4 = '<td>'+ div4 +'</td>';
						var td5 = '<td>'+ div5 +'</td>';
						var td6 = '<td>'+ div6 +'</td>';

						tr = '<tr>'+ td1+td2+td3+td4+td5+td6 +'</tr>';
						$("#song_table").append(tr);
					};
					del_func();
					down_func();
				},
				error: function (){
					console.log("出错了");
				}
			});
		}
	}

	// 删除歌单
	function fromSLRemoveMusic(sl_id, m_id) {
		sl_id = sl_id.trim();m_id = m_id.trim();
		var re = confirm("是否确定将这首歌从本歌单删除？");
		if(re == true) {
			$.ajax({
				url: "${pageContext.request.contextPath}/songlist/removeMusic",
				type: "post",
				data: {"sl_id": sl_id, "m_id": m_id},
				dataType: "json",
				success: function (data) {
					var songList = data.extend.songList;
					var musicList = songList.musicList;


					$("#song_table tr").remove();
					for (let i = 0; i < musicList.length; i++) {
						var tr = '';

						var img = '<img src="${pageContext.request.contextPath}/resources/icons/歌单-播放.png" alt="">';
						var span1 = '<span class="fr">'+ img +'</span>';
						var span2 = '<span class="num">'+ (i+1) +'</span>';

						var div1 = '<div class="ply">'+ span1 + span2 +'</div>';
						var div2 = '<div class="tt"> <a href="">'+ musicList[i].musicName +'</a> </div>';
						var div4 = '<div class="tt"> <a href="">'+ musicList[i].singer + '</a> </div>';
						var div5 = '<div class="tt"> <a href="">专辑'+ (i+1) +'</a> </div>';

						var del_img = '<img name="del-btn" src="${pageContext.request.contextPath}/resources/icons/删除.png" class="icon" title="删除">';
						var a1 = '<a href="javascript: fromSLRemoveMusic(\''+songList.sl_id+'\',\''+ musicList[i].id +'\')">'+ del_img +'</a>';
						var a2 = '<a href="${pageContext.request.contextPath}/downMusic?filename='+ musicList[i].musicFile +'"><img name="down-btn" src="${pageContext.request.contextPath}/resources/icons/下载.png" class="icon" title="下载"></a>';
						var div6 = '<div class="tt edit">'+a1+a2+'</div>'

						var td1 = '<td>'+ div1 +'</td>';
						var td2 = '<td>'+ div2 +'</td>';
						var td3 = '<td>'+ musicList[i].duration +'</td>';
						var td4 = '<td>'+ div4 +'</td>';
						var td5 = '<td>'+ div5 +'</td>';
						var td6 = '<td>'+ div6 +'</td>';

						tr = '<tr>'+ td1+td2+td3+td4+td5+td6 +'</tr>';
						$("#song_table").append(tr);
					};
					alert("删除成功！");
					del_func();
					down_func();
				},
				error: function () {
					console.log("删除错误");
				}
			});
		}else {
			alert("已取消");
		}

	}

</script>
</body>
</html>
