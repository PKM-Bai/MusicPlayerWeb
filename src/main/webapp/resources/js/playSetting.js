// 获取主机地址之后的目录，如： test/test.jsp
var pathName = window.document.location.pathname;
//获取带"/"的项目名，如：/test
var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);

/**-------    歌词播放颜色    ----------*/
var title = document.querySelector("#test");
var fcolor1Element = document.querySelector("#f-color1");
var fcolor2Element = document.querySelector("#f-color2");
var bcolor1Element = document.querySelector("#b-color1");
var bcolor2Element = document.querySelector("#b-color2");
var plist = document.querySelectorAll("p.lrc-p");

var fcolor1Value = fcolor1Element.value;
var fcolor2Value = fcolor2Element.value;
var bcolor1Value = bcolor1Element.value;
var bcolor2Value = bcolor2Element.value;

for (var i=0; i < plist.length; i++) {
    plist[i].style.cssText = "background: linear-gradient(-3deg,"+ fcolor1Value + " 0%, " + fcolor2Value + " 100%);\n-webkit-background-clip: text;"
}

function changeFColor() {
    fcolor1Value = fcolor1Element.value
    fcolor2Value = fcolor2Element.value
    for (var i=0; i < plist.length; i++) {
        if (parseInt(plist[i].getAttribute("id")) !== playlyricRow)
        {
            plist[i].style.cssText = "background: linear-gradient(-3deg,"+ fcolor1Value + " 0%, " + fcolor2Value + " 100%);\n-webkit-background-clip: text;"
        }
    }
    SavePlaySetting();
}
function changeBColor(){
    bcolor1Value = bcolor1Element.value
    bcolor2Value = bcolor2Element.value
    for (var i=0; i < plist.length; i++) {
        if (parseInt(plist[i].getAttribute("id")) == playlyricRow)
        {
            plist[i].style.cssText = "background: linear-gradient(-3deg,"+ bcolor1Value + " 0%, " + bcolor2Value + " 100%);\n-webkit-background-clip: text;"
        }
    }
    SavePlaySetting();
}

fcolor1Element.onchange = changeFColor;
fcolor2Element.onchange = changeFColor;
bcolor1Element.onchange = changeBColor;
bcolor2Element.onchange = changeBColor;

/**-------    歌词背景透明度    ----------*/
var opacity_range = document.getElementById("opacityRange");
var bgOpacity_num = document.getElementById("bgOpacityNum");

var lyricBG = document.getElementsByClassName("lyricBG")[0];

// var bg_image = document.getElementById("canvas-bg");
opacity_range.onchange = function () {
    bgOpacity_num.innerText = opacity_range.value;
    lyricBG.setAttribute("style", "background: rgba(33, 33, 33, "+opacity_range.value+");");
    SavePlaySetting();
}

/** --------------- 如果用户登录保存对歌词的设置 ----------------- **/
var uid = $("#uid").val();
function SavePlaySetting()
{
    $.ajax({
        url: projectName+"/play/saveSetting",
        type: "post",
        data: {
            "uid": uid, "foreground1": fcolor1Value, "foreground2": fcolor2Value,
            "background1": bcolor1Value, "background2": bcolor2Value, "lyricBgAlpha": opacity_range.value,
            "musicVolume": volume_range.value
        }
    });
};
// 页面加载后查询当前用户是否存在播放设置并修改设置
window.onload = function (){
    $.ajax({
        url: projectName+"/play/loadSetting",
        type: "post",
        data: { "uid": uid },
        success: function (data)
        {
            var playSetting = data.extend["playSetting"];
            fcolor1Element.value = playSetting.foreground1;
            fcolor2Element.value = playSetting.foreground2;
                changeFColor();

            bcolor1Element.value = playSetting.background1;
            bcolor2Element.value = playSetting.background2;
                changeBColor();

            opacity_range.value = playSetting.lyricBgAlpha;
                bgOpacity_num.innerText = opacity_range.value;
                lyricBG.setAttribute("style", "background: rgba(33, 33, 33, "+opacity_range.value+");");
        }
    });
};















