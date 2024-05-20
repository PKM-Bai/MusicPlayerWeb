package com.music.dao;

import com.music.entity.Music;

import java.util.List;

public interface MusicDao {

    // 按ID查找歌曲
    Music findByMusicID(String id);

    // 按名称查找歌曲
//    Music findByMusicName(String musicName);

    // 按歌手查找歌曲
//     Music findByMusicSinger(String singer);

    // 查询所有歌曲
     List<Music> findAllMusic();

    // 添加歌曲
//     int addMusic(Music music);

    // 按ID删除歌曲
//     int delByMusicID(String id);

    // 按名称删除歌曲
//     int delByMusicName(String musicName);

}
