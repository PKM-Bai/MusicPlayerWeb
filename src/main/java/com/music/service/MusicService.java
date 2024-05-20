package com.music.service;

import com.music.entity.Music;
import com.music.entity.Singer;

import java.io.IOException;
import java.util.List;

public interface MusicService {
    // 展示所有歌曲
    List<Music> getAllMusic();

    // 根据ID查找的歌曲
    Music getIDMusic(String id);

    // 获取歌词
    String getMuiscLyric(String path) throws IOException;

    // 播放下一首
    Music nextSong(Music music);
    // 播放上一首
    Music lastSong(Music music);

    // 随机播放
    Music randomPlaySong(Music music);

    // 获取歌手信息
    Singer getSinger(String singerName);
}
