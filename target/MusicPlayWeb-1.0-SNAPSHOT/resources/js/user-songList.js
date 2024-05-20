// 获取主机地址之后的目录，如： test/test.jsp
let pathName = window.document.location.pathname;
//获取带"/"的项目名，如：/test
let projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);

// 播放音乐
let ply = $(".ply img");
ply.each((function (i, item){
    $(item).click(function () {
        let music_id = $(item).parent().parent('.ply').attr("data-musicID");
        window.open(projectName+"/play/playMusic?id="+music_id);
    }
)}
));

// 编辑区按钮
function del_func() {
    let del_btn = $("[name='del-btn']");
    del_btn.each(function (i, item) {
        $(item).mouseover(function (){
            $(item).attr("src", projectName+"/resources/icons/删除(1).png");
        });
    });
    del_btn.mouseout(function () {
        $("[name='del-btn']").attr("src", projectName+"/resources/icons/删除.png")
    });
};
function down_func() {
    let down_btn = $("[name='down-btn']");
    down_btn.each(function (i, item) {
        $(item).mouseover(function (){
            $(item).attr("src", projectName+"/resources/icons/下载(1).png");
        });
    });
    down_btn.mouseout(function () {
        $("[name='down-btn']").attr("src", projectName+"/resources/icons/下载.png")
    });
};

del_func();
down_func();



























