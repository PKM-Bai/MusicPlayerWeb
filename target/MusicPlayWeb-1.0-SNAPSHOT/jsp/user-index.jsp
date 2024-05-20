<%@ page import="com.music.entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>用户主页</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user_page.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/assist.css">

</head>

<body id="body">
<%
	User user = null;
	try{
		user = (User) session.getAttribute("user");
	} catch (Exception e){ e.printStackTrace(); };
%>
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
							<li><a href="javascript: showUserBox()">修改资料</a></li>
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

	<!--  修改个人信息  style="display: none"-->
	<div class="user_update_box" style="display: none" id="user_update_box">
		<h2 style="margin: 10px 200px;">修改个人资料</h2>
		<hr>
		<form id="userInfo" enctype="multipart/form-data">
			<ul>
				<li><span>用户名：</span><input name="uname" type="text" value="${user.name}" /></li>
				<li><span>性别：</span>
					<c:if test="${user.sex == '男'}">
						<input name="usex" type="radio" value="男" checked /> 男
						<input name="usex" type="radio" value="女" /> 女
					</c:if>
					<c:if test="${user.sex == '女'}">
						<input name="usex" type="radio" value="男" /> 男
						<input name="usex" type="radio" value="女" checked /> 女
					</c:if>
				</li>
				<li>
						<span>更换头像：<img id="u_head" style="width: 100px;height: 100px;" src="${pageContext.request.contextPath}/resources/image/HeadPortrait/${user.head}" />
						<input type="file" name="pic" id="pic" accept="image/*" onchange="update_pic()"/></span>
				</li>
				<li>
					<input type="button" class="submitInput" value="修 改" onclick="submit_userInfo()">
				</li>
			</ul>
		</form>
	</div>

	<!-- 内容 -->
	<div class="page-main">
	<div class="user-content">
		<!-- 个人信息展示 -->
		<dl class="user-dataBox">
			<!-- 头像展示 -->
			<dt class="fl">
				<img style="width: 200px" height="200px" src="${pageContext.request.contextPath}/resources/image/HeadPortrait/${user.head}">
			</dt>
			<!-- 个人资料展示 -->
			<dd class="fl">
				<div class="name-sex">
					<span id="name">${user.name}</span>&nbsp;&nbsp;&nbsp;
					<c:if test="${user.sex == '男'}">
						<span id="sex"><img src="${pageContext.request.contextPath}/resources/icons/男.png" alt=""></span>
					</c:if>
					<c:if test="${user.sex == '女'}">
						<span id="sex"><img src="${pageContext.request.contextPath}/resources/icons/女.png" alt=""></span>
					</c:if>
				</div>
				<ul class="user-data clearfix">
					<li class="fl fst"><a href=""> <p>0</p> <span>动态</span> </a></li>
					<li class="fl"><a href=""> <p>0</p> <span>关注</span> </a></li>
					<li class="fl"><a href=""> <p>0</p> <span>粉丝</span> </a></li>
				</ul>
				<div class="user-info clearfix">
					<span>所在地区：${user.address}</span> &nbsp;&nbsp;&nbsp; <span>年龄：${user.age}</span>
				</div>
			</dd>
		</dl>
		<!-- 听歌排行 -->
		<div class="clearfix userPage-title">
			<h2>听歌排行</h2>
			<h5>累计听歌**首</h5>
		</div>
		<ul class="song-rankList clearfix">
			<li>
				<div class="hd">
					<span class="num">1.</span>
					<a href="" class="song-rankList-play"><img src="${pageContext.request.contextPath}/resources/icons/播放.png" alt=""></a>
				</div>
				<div class="song">
					<span>歌名</span>
					<span><em>-</em>歌手</span>
				</div>
				<div class="tops">
					<span>5次</span>
				</div>
			</li>
			<li class="even">
				<div class="hd">
					<span class="num">2.</span>
					<a href="" class="song-rankList-play"><img src="${pageContext.request.contextPath}/resources/icons/播放.png" alt=""></a>
				</div>
				<div class="song">
					<span>歌名</span>
					<span><em>-</em>歌手</span>
				</div>
				<div class="tops">
					<span>5次</span>
				</div>
			</li>
			<li>
				<div class="hd">
					<span class="num">3.</span>
					<a href="" class="song-rankList-play"><img src="${pageContext.request.contextPath}/resources/icons/播放.png" alt=""></a>
				</div>
				<div class="song">
					<span>歌名</span>
					<span><em>-</em>歌手</span>
				</div>
				<div class="tops">
					<span>5次</span>
				</div>
			</li>
			<li class="even">
				<div class="hd">
					<span class="num">4.</span>
					<a href="" class="song-rankList-play"><img src="${pageContext.request.contextPath}/resources/icons/播放.png" alt=""></a>
				</div>
				<div class="song">
					<span>歌名</span>
					<span><em>-</em>歌手</span>
				</div>
				<div class="tops">
					<span>5次</span>
				</div>
			</li>
		</ul>

		<!-- 我创建的歌单 -->
		<div class="userPage-title">
			<h2>我创建的歌单 </h2>
			<h5>（${creatSongList.size()}）</h5>
		</div>
		<ul class="playlist-ul clearfix">
			<c:forEach items="${creatSongList}" var="sl">
				<li>
					<div class="u-cover">
						<a href="${pageContext.request.contextPath}/user/song_list?uid=${user.u_id}&sl_id=${sl.sl_id}">
						<c:if test="${sl.musicList.size() != 0}">
							<img src="${pageContext.request.contextPath}/resources/image/MusicImg/${sl.musicList.get(0).musicImg}" alt="">
						</c:if>
						</a>
						<div class="bottom">
							<span class="fl plays">播放量：${sl.sl_plays}</span>
						</div>
					</div>
					<p> <a href="${pageContext.request.contextPath}/user/song_list?uid=${user.u_id}&sl_id=${sl.sl_id}">${sl.sl_name}</a> </p>
				</li>
			</c:forEach>
		</ul>

	</div>
	</div>

</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/assist.js"></script>


</body>
</html>
