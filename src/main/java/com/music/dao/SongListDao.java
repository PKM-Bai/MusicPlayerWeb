package com.music.dao;

import com.music.entity.Music;
import com.music.entity.SongList;
import com.music.entity.Song_list_song;
import com.music.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SongListDao {

    SongList findSongListByID(int sl_id);

    // 根据歌单id查询歌单中的所有音乐
    List<Music> findMusicBySongListID(int sl_id);

    // 使用歌单id查找歌单用户
    User findUserBySongListID(int sl_id);

    // 根据歌曲id和歌单id，把歌曲从歌单中移除
    int removeMusic(@Param("sl_id") int sl_id, @Param("m_id") String m_id);

    // 根据歌曲id和歌单id，把歌曲添加到对应的歌单中
    int addMusic(Song_list_song sls);

}
