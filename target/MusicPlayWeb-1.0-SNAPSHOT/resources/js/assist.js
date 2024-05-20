$(document).ready(function(){

    $("html").css("width", $(window).width());

});

// 判断pc浏览器是否缩放，若返回1则为默认无缩放，如果大于1则是放大，否则缩小
const ratio = window.devicePixelRatio
// 这个计算公式是我得出比较合理的结果
if (ratio != 1) {
    document.body.style.zoom = -0.6 * ratio + 1.55
}

let pathName = window.document.location.pathname;
let projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);

// 显示/隐藏用户操作菜单
let head = document.getElementById("loginStatus")
let user_box = document.getElementsByClassName("user-message-box")[0]
if (user_box != null) {
    head.onmouseover = function () { user_box.setAttribute("style", ""); }
    head.onmouseout = function () {user_box.setAttribute("style", "display:none");}
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


let user_update_box = document.getElementsByClassName("user_update_box")[0]
let pic = document.getElementById("pic");
let u_head = document.getElementById("u_head");

$(".page-header").click(function () {
    if (user_update_box.getAttribute("style") == ""){
        user_update_box.setAttribute("style", "display: none")
    }
});
$(".page-main").click(function () {
    if (user_update_box.getAttribute("style") == ""){
        user_update_box.setAttribute("style", "display: none")
    }
});

// 显示登录窗口的方法
function showUserBox() {
    user_update_box.setAttribute("style", "")
}

function update_pic() {
    my_data = pic.files[0];
    // 获取上传图片信息
    var reader = new FileReader();
    // 监听reader对象的onload事件，当图片加载完成时，把base64编码赋值给预览图片
    reader.addEventListener("load", function () {
        u_head.src = reader.result;
    }, false);
    // 调用reader.readAsDataURL()方法，把图片转成base64
    reader.readAsDataURL(my_data);
}

function submit_userInfo()
{
    let u_id = $("#uid").val()
    let u_name = $("input[name='uname']").val();
    let u_sex = $("input[name='usex']:checked").val();
    var formdata = new FormData();
    formdata.append("u_id", u_id);
    formdata.append("u_name", u_name);
    formdata.append("u_sex", u_sex);
    formdata.append("pic", pic.files[0]);

    $.ajax({
        url: projectName + "/user/update_user",
        type: "POST",
        data: formdata,
        processData: false,
        contentType: false,
        cache: false,
        success: function() {
            alert("修改成功");
            window.location.reload();
        },
        error: function () {
            console.log("报错");
        },
    })
}








