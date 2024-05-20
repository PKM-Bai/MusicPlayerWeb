
/********************* 轮播图 ****************************/
let current_index = -1;  // 当前轮播图的编号 =>下标
let swipe_timer = null;  // 自动轮播定时器
// 轮播图的图片地址与跳转链接
let links = [
    { 'image': projectName + '/resources/image/MusicImg/0d338744ebf81a.jpg', 'target': "#1" },
    { 'image': projectName + '/resources/image/MusicImg/2566658895.jpg', 'target': "#2" },
    { 'image': projectName + '/resources/image/MusicImg/3424978721550752.jpg', 'target': "#3" },
    { 'image': projectName + '/resources/image/MusicImg/109951163934251326.jpg', 'target': "#4" },
    { 'image': projectName + '/resources/image/MusicImg/null-1769bb1bc2d8126e.jpg', 'target': "#5" }
];
let swipe = document.getElementById("swipe");
let swipe_bg = document.getElementById("swipe_bg");
let swipe_img_box = document.getElementById("swipe_img_box");
let swipe_link = document.getElementById("swipe_link");
let swipe_img = document.getElementById("swipe_img");
let musicName = document.getElementById("musicName");
let singleName = document.getElementById("singleName");
let swipe_select = document.getElementById("swipe_select");
let swipe_btn_left = document.getElementById("swipe_btn_left");
let swipe_btn_right = document.getElementById("swipe_btn_right");

/********* 事件 ********/
// 切换图片
let select=(index)=>{
    stop();        // 停止播放
    index = Number(index);    // 转为数字

    // 下标超过图片最大数量，直接返回
    if(index >= links.length){
        return;
    }
    // 选中当前已选中的图片，直接返回
    if(current_index == links.length){
        return;
    }
    // 取消当前指示点的选中状态
    if(current_index > -1){
        swipe_select.children[current_index].classList.remove('checked');
    }
    current_index = index;   // 变更当前轮播图的编号
    let current_link = links[current_index];    // 找到当前轮播图的元素数据
    swipe_bg.style.backgroundImage='url(' + current_link.image + ')';   // 改变背景
    swipe_img.setAttribute("src", current_link.image);     // 改变歌曲图片
    musicName.innerText = current_link.musicName;                       // 改变歌名
    singleName.innerText = "演唱者："+current_link.singleName;           // 改变歌手名
    swipe_link.setAttribute('href', current_link.target);  // 改变跳转链接
    swipe_select.children[current_index].classList.add('checked');      // 指示器添加选中效果
};
// 自动切换图片
let autoSelect=(index)=>{
    index = Number(index);    // 转为数字

    // 下标超过图片最大数量，直接返回
    if(index >= links.length){
        return;
    }
    // 选中当前已选中的图片，直接返回
    if(current_index == links.length){
        return;
    }
    swipe_select.children[current_index].classList.remove('checked');  // 取消当前指示点的选中状态
    current_index = index;   // 变更当前轮播图的编号
    let current_link = links[current_index];    // 找到当前轮播图的元素数据
    // 调整过渡时间
    swipe_img.style.transition = "opacity 0.5s ease-in 0s";
    // 调整不透明度为0.2
    swipe_img.style.opacity = "0.2";
    // 延迟变化img图片，并重新定义透明度以及过渡时间和过渡方式
    setTimeout(()=>{
        swipe_bg.style.backgroundImage='url(' + current_link.image + ')';   // 改变背景
        swipe_img.setAttribute("src", current_link.image);     // 改变歌曲图片
        musicName.innerText = current_link.musicName;                                       // 改变歌名
        singleName.innerText = "演唱者："+current_link.singleName;                              // 改变歌手名
        swipe_link.setAttribute('href', current_link.target);  // 改变跳转链接
        // swipe_select.children[current_index].classList.add('checked');      // 指示器添加选中效果
        // 不透明度变化
        swipe_img.style.transition = 'opacity 0.7s ease-out 0s';
        swipe_img.style.opacity = "1";
        // 添加指示点选中效果 如果已经通过手动点击激活了，选中则此这里不再执行
        if(!document.querySelector('.swipe .checked'))
        {
            swipe_select.children[current_index].style.transition='background-color 0.5s';
            swipe_select.children[current_index].classList.add("checked");
        }
    }, 500);

};
// 播放
let play=()=>{
    // 3秒切换一次
    swipe_timer = setInterval(() => {
        // 设置新的index
        let index = current_index +1;
        // 右翻越界，切到第一张图片
        if(index >= links.length){
            index = 0;
        }
        // 加载新图片（这里选中自动，增加切换效果）
        autoSelect(index);
    }, 3000);
};
// 停止
let stop=()=>{
    if(swipe_timer){
        clearInterval(swipe_timer);
        swipe_timer = null;
    }
};
// 绑定
let bind=()=>{
    // 添加左翻按钮点击事件监听
    swipe_btn_left.addEventListener("click", ()=>{
        // 设置index
        let index = current_index -1;
        // 左翻越界切换到最后一张
        if(index < 0)
            index = links.length-1;
        // 加载新图片
        select(index);
    });

    // 添加右翻按钮点击事件监听
    swipe_btn_right.addEventListener("click", ()=>{
        // 设置index
        let index = current_index +1;
        // 右翻越界切换到第一张
        if(index > links.length -1)
            index = 0;
        // 加载新图片
        select(index);
    });

    // 给轮播图div添加点击事件
    swipe_img_box.addEventListener("click", ()=>{
        // 跳转当前播放到的轮播图的播放链接
       window.location = links[current_index].target;
    });

    // 循环绑定指示器点击事件
    for (const key in swipe_select.children) {
        if(swipe_select.children.hasOwnProperty(key)){
            const element = swipe_select.children[key];
            element.addEventListener("click", (e)=> {
                e.preventDefault();    // 取消默认点击跳转
                select(e.target.dataset.index);  // 跳转到当前指示点中data-index所指定的图片
            })
        }
    }

    // 添加绑定鼠标移入轮播图事件
    swipe.addEventListener("mouseover", (e)=>{
        // 防止鼠标从子元素移出时触发
        if(e.relatedTarget && swipe.compareDocumentPosition(e.relatedTarget) == 10){
            stop();
        }
    });
    // 添加绑定鼠标移出轮播图事件
    swipe.addEventListener("mouseout", (e)=>{
        // 防止鼠标从子元素移出时触发
        if(e.relatedTarget && swipe.compareDocumentPosition(e.relatedTarget) == 10){
            play();
        }
    });
    // 添加绑定鼠标移动轮播图事件
    swipe.addEventListener("mousemove", (e)=>{
        stop();
    });
};

// 初始化
let init=()=>{
    console.log(links)
    for (let i = 0; i < links.length; i++) {
        let item = document.createElement('a');
        item.setAttribute("class", "item");
        item.setAttribute("href", "#");
        item.setAttribute("data-index", i);
        // 追加元素
        swipe_select.appendChild(item);
    }
    // 默认从第一张开始
    select(0);
    // 绑定各个时间并开始轮播
    bind();
    play();
};



// 页面加载完毕，执行初始化
window.addEventListener('load', ()=>{
    links = [];   // 清空轮播图存放的图片和链接
    $.ajax({
        url: projectName + "/music/getAllMusic",
        success: function (data){
            console.log(data);
            // 获得所有音乐列表
            let musicList = data["extend"]["musicList"];
            for (let i = 0; i < musicList.length; i++) {
                // 只向轮播图列表添加前五首歌，第五首之后直接跳过执行
                if(i < 5) {
                    let m = {"image":projectName + '/resources/image/MusicImg/' +musicList[i].musicImg,
                             "musicName": musicList[i].musicName,
                             "singleName": musicList[i].singer,
                             "target":projectName + '/play/playMusic?id='+musicList[i].id}
                    links.push(m);   // 添加到轮播图存储列表中
                }

                /*  初始化歌曲列表 */
                let song_id = "<span class='num'>"+ (i+1) +".</span>";
                let a = "<a href='" + projectName + '/play/playMusic?id='+musicList[i].id+ "' class='song-list-play'><img src='resources/icons/播放-white.png'></a>";
                let id_div = "<div class='hd'>" + song_id + a +"</div>"

                let song_div = "<div class='song'>" +
                                   "<span>"+ musicList[i].musicName +"</span>" +
                                   "<span><em>--</em>"+ musicList[i].singer +"</span>" +
                               "</div>";
                let playNum_div = "<div class='tops'>" +
                                    "<span>时长："+ musicList[i].duration +"</span>"+
                                  "</div>"
                let li = "<li>"+ id_div + song_div + playNum_div +"</li>"

                /* 通过js向页面添加标签元素
                $("#songList_ul")是jquery查找页面中id为"songList_ul"的标签元素
                和document.getElementById("songList_ul")使用效果一样，相当于用jquery简写了 */
                $("#songList_ul").append(li);
            }
            /* 初始化轮播图 */
            init();
        }
    });
});




