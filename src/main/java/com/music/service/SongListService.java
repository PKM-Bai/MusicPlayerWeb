package com.music.service;

import com.music.entity.Music;
import com.music.entity.SongList;
import com.music.entity.Song_list_song;
import com.music.entity.User;

import java.util.List;

public interface SongListService {
    SongList findSongListByID(int sl_id);

    List<Music> findMusicBySongListID(int sl_id);

    User findUserBySongListID(int sl_id);

    int removeMusic(int sl_id, String m_id);

    int addMusic(Song_list_song sls);

}
