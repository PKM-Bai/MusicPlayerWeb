package com.music.entity;

import java.util.List;

public class SongList {
    private int sl_id;
    private String sl_name;
    private String sl_creatUser;
    private String sl_creatTime;
    private int sl_plays;

    public SongList(int sl_id, String sl_name, String sl_creatUser, String sl_creatTime, int sl_plays) {
        this.sl_id = sl_id;
        this.sl_name = sl_name;
        this.sl_creatUser = sl_creatUser;
        this.sl_creatTime = sl_creatTime;
        this.sl_plays = sl_plays;
    }

    public SongList() { }

    private List<Music> musicList;

    public List<Music> getMusicList() {
        return musicList;
    }

    public void setMusicList(List<Music> musicList) {
        this.musicList = musicList;
    }

    public int getSl_id() {
        return sl_id;
    }

    public void setSl_id(int sl_id) {
        this.sl_id = sl_id;
    }

    public String getSl_name() {
        return sl_name;
    }

    public void setSl_name(String sl_name) {
        this.sl_name = sl_name;
    }

    public String getSl_creatUser() {
        return sl_creatUser;
    }

    public void setSl_creatUser(String sl_creatUser) {
        this.sl_creatUser = sl_creatUser;
    }

    public String getSl_creatTime() {
        return sl_creatTime;
    }

    public void setSl_creatTime(String sl_creatTime) {
        this.sl_creatTime = sl_creatTime;
    }

    public int getSl_plays() {
        return sl_plays;
    }

    public void setSl_plays(int sl_plays) {
        this.sl_plays = sl_plays;
    }
}
