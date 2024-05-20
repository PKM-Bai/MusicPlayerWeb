package com.music.service.Impl;

import com.music.dao.MusicDao;
import com.music.dao.SingerDao;
import com.music.entity.Music;
import com.music.entity.PlayList;
import com.music.entity.Singer;
import com.music.service.MusicService;
import com.music.utils.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("musicService")
public class MusicServiceImpl implements MusicService {

    @Autowired
    private MusicDao musicDao;
    @Autowired
    private SingerDao singerDao;

    @Override
    public List<Music> getAllMusic() {
        List<Music> musicList = null;
        if (musicDao.findAllMusic() == null){
            System.out.println("没有音乐");
        }else
            musicList = musicDao.findAllMusic();

        return musicList;
    }

    // 根据id获取歌曲
    @Override
    public Music getIDMusic(String id) {
        Music music = musicDao.findByMusicID(id);
        return music;
    }

    // 获取歌词
    @Override
    public String getMuiscLyric(String path) {
        return Tools.readTxt(path);
    }

    // 播放上一首
    @Override
    public Music nextSong(Music music) {
        List<Music> list = PlayList.getPlayList().getMusicList();
        Music temp = null;
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).getId().equals(music.getId())){
                if (i == list.size()-1)   // 判断当前播放的歌曲是否是列表中最后一个元素
                    temp = list.get(0);     // 播放最后一首歌点击下一首播放列表第一首歌曲
                else
                    temp = list.get(i+1);
            }
        }
        return temp;
    }

    // 播放下一首
    @Override
    public Music lastSong(Music music) {
        List<Music> list = PlayList.getPlayList().getMusicList();
        Music temp = null;
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).getId().equals(music.getId())){
                if (i == 0)   // 判断当前播放的歌曲是否是列表中第一个元素
                    temp = list.get(list.size()-1);     // 播放最后一首歌点击上一首播放列表最后一首歌曲
                else
                    temp = list.get(i-1);
            }
        }
        return temp;
    }

    // 随机播放
    @Override
    public Music randomPlaySong(Music music) {
        List<Music> list = PlayList.getPlayList().getMusicList();
        int randomNum = (int) (Math.random() * (list.size()-1));
        while (list.get(randomNum).getId().equals(music.getId()))
            randomNum = (int) (Math.random() * (list.size()-1));
        System.out.println((list.size()-1) + ", " +randomNum);
        return list.get(randomNum);
    }

    // 获取歌手信息
    @Override
    public Singer getSinger(String singerName) {
        return singerDao.findByMusicSinger(singerName);
    }


}
