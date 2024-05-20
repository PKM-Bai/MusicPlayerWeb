package com.music.entity;

import java.util.List;

public class Music {
    private String id;
    private String musicName;
    private String singer;
    private String musicImg;
    private String duration;
    private int plays;
    private String musicFile;
    private String lyricFile;

    private Singer singerObj;        // 关联歌手表
    private List<SongList> songLists;// 这首歌存在于哪些歌单中

    public List<SongList> getSongLists() {
        return songLists;
    }

    public void setSongLists(List<SongList> songLists) {
        this.songLists = songLists;
    }

    public Singer getSingerObj() {
        return singerObj;
    }

    public void setSingerObj(Singer singerObj) {
        this.singerObj = singerObj;
    }

    public Music(){};

    public Music(String id, String musicName, String singer, String musicImg, String duration, int plays, String musicFile, String lyricFile) {
        this.id = id;
        this.musicName = musicName;
        this.singer = singer;
        this.musicImg = musicImg;
        this.duration = duration;
        this.plays = plays;
        this.musicFile = musicFile;
        this.lyricFile = lyricFile;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMusicName() {
        return musicName;
    }

    public void setMusicName(String musicName) {
        this.musicName = musicName;
    }

    public String getSinger() {
        return singer;
    }

    public void setSinger(String singer) {
        this.singer = singer;
    }

    public String getMusicImg() {
        return musicImg;
    }

    public void setMusicImg(String musicImg) {
        this.musicImg = musicImg;
    }

    public String getDuration() {
        return duration.substring(3);
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public int getPlays() {
        return plays;
    }

    public void setPlays(int plays) {
        this.plays = plays;
    }

    public String getMusicFile() {
        return musicFile;
    }

    public void setMusicFile(String musicFile) {
        this.musicFile = musicFile;
    }

    public String getLyricFile() {
        return lyricFile;
    }

    public void setLyricFile(String lyricFile) {
        this.lyricFile = lyricFile;
    }
}
