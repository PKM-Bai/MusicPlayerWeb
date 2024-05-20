<%@ page import="com.music.entity.User" %><%--
  Created by IntelliJ IDEA.
  User: Bai shiyu
  Date: 2021/12/1
  Time: 21:27
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>音乐播放器-首页</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/assist.css">
</head>

<body id="body">
	<!--网页内容区-->
	<div id="content">
		<div class="index-box">
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
										<li><a href="javascript: showUserBox()">修改资料</a></li>
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

			<!--  修改个人信息 -->
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

			<!-- content 中间内容 -->
			<div class="page-main">
				<!-- 轮播图 -->
				<div class="swipe" id="swipe">
					<!-- 模糊背景 -->
					<div class="swipe_bg" id="swipe_bg"></div>
					<!-- 图片展示区 -->
					<section>
						<!-- 图片 -->
						<div class="img-box" id="swipe_img_box">
							<a href="#" id="swipe_link">
								<img class="img" id="swipe_img" src="" alt="">
								<div class="textInfo">
									<h2 id="musicName"></h2>
									<h3 id="singleName"></h3>
								</div>
							</a>
						</div>
						<!-- 指示点 -->
						<div class="swipe_select" id="swipe_select"></div>
						<!-- 左侧翻页按钮 -->
						<div class="select_btn left" id="swipe_btn_left">
							<svg t="1652234410499" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="3702" width="128" height="128"><path d="M384 512L731.733333 202.666667c17.066667-14.933333 19.2-42.666667 4.266667-59.733334-14.933333-17.066667-42.666667-19.2-59.733333-4.266666l-384 341.333333c-10.666667 8.533333-14.933333 19.2-14.933334 32s4.266667 23.466667 14.933334 32l384 341.333333c8.533333 6.4 19.2 10.666667 27.733333 10.666667 12.8 0 23.466667-4.266667 32-14.933333 14.933333-17.066667 14.933333-44.8-4.266667-59.733334L384 512z" p-id="3703" fill="#ffffff"></path></svg>
						</div>
						<!-- 右侧翻页按钮 -->
						<div class="select_btn right" id="swipe_btn_right">
							<svg t="1652234450073" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="3952" width="128" height="128"><path d="M731.733333 480l-384-341.333333c-17.066667-14.933333-44.8-14.933333-59.733333 4.266666-14.933333 17.066667-14.933333 44.8 4.266667 59.733334L640 512 292.266667 821.333333c-17.066667 14.933333-19.2 42.666667-4.266667 59.733334 8.533333 8.533333 19.2 14.933333 32 14.933333 10.666667 0 19.2-4.266667 27.733333-10.666667l384-341.333333c8.533333-8.533333 14.933333-19.2 14.933334-32s-4.266667-23.466667-14.933334-32z" p-id="3953" fill="#ffffff"></path></svg>
						</div>
					</section>
				</div>
				<!-- 歌曲列表 -->
				<div class="songListBox">
					<div class="clearfix userPage-title">
						<h2>歌曲列表</h2>
						<h5>所有歌曲</h5>
					</div>
					<ul class="song-list clearfix" id="songList_ul">

					</ul>
				</div>
			</div>

			<!-- footer 底部 -->
			<div class="page-footer">

			</div>
		</div>
	</div>
	</div>

	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/assist.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/index.js"></script>

</body>
</html>
