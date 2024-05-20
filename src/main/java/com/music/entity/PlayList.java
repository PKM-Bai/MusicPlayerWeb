package com.music.entity;

import java.util.ArrayList;
import java.util.List;

public class PlayList {
    // 播放列表为单例模式

    private static PlayList playList = new PlayList();
    private List<Music> list = null;

    private PlayList(){
        list = new ArrayList<>();
    }

    // 获取播放列表
    public static PlayList getPlayList() {
        if (playList == null)
            playList = new PlayList();
        return playList;
    }

    public List<Music> getMusicList(){
        return list;
    }

    public void setMusicList(List<Music> list) {
        this.list =  list;
    }

    // 向列表中添加
    public void addMusic(Music music){
        if (playList != null && !findRepeat(music))
            list.add(music);
    }

    // 获取列表长度
    public int length(){
        return list.size();
    }
    // 查询是否重复
    public boolean findRepeat(Music music){
        for (int i = 0; i < list.size();i++){
            if(list.get(i).getId().equals(music.getId())){
                return true;
            }
        }
        return false;
    }
}
