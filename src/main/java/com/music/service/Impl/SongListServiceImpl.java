package com.music.service.Impl;

import com.music.dao.SongListDao;
import com.music.entity.Music;
import com.music.entity.SongList;
import com.music.entity.Song_list_song;
import com.music.entity.User;
import com.music.service.SongListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SongListServiceImpl implements SongListService {
    @Autowired
    private SongListDao songListDao;

    @Override
    public SongList findSongListByID(int sl_id) {
        return songListDao.findSongListByID(sl_id);
    }

    @Override
    public List<Music> findMusicBySongListID(int sl_id) {
        return songListDao.findMusicBySongListID(sl_id);
    }

    @Override
    public User findUserBySongListID(int sl_id) {
        return songListDao.findUserBySongListID(sl_id);
    }

    @Override
    public int removeMusic(int sl_id, String m_id) {
        return songListDao.removeMusic(sl_id, m_id);
    }

    @Override
    public int addMusic(Song_list_song sls) {
        List<Music> ml = findMusicBySongListID(sls.getSl_id());
        if (ml == null)
            return 0;

        for (Music music : ml) {
            if(music.getId().equals(sls.getM_id()))
            {
                return 0;
            }
        }
        return songListDao.addMusic(sls);
    }
}
