package com.music.dao;

import com.music.entity.Singer;

public interface SingerDao {

    // 获取歌手信息
    Singer findByMusicSinger(String singerName);
}
