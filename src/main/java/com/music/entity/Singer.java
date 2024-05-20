package com.music.entity;

import com.music.utils.Tools;

import java.util.ArrayList;

public class Singer {
    private String id;            // 歌手id
    private String singerName;    // 歌手名
    private String singerImg;     // 歌手写真图目录
    private String singerInfo;    // 歌手信息
    private int clout;            // 热度

    public Singer(String id, String singerName, String singerImg, String singerInfo, int clout) {
        this.id = id;
        this.singerName = singerName;
        this.singerImg = singerImg;
        this.singerInfo = singerInfo;
        this.clout = clout;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSingerName() {
        return singerName;
    }

    public void setSingerName(String singerName) {
        this.singerName = singerName;
    }


    public ArrayList<String> getSingerImage() {
        String path = Tools.projectResourcePath + "\\image\\Singer\\"+singerName;
        ArrayList<String> list = new ArrayList<>();
        return Tools.getAllFile(path, list);
    }

    public String getSingerImg() {
        return singerImg;
    }

    public void setSingerImg(String singerImg) {
        this.singerImg = singerImg;
    }

    public String getSingerInfo() {
        return singerInfo;
    }

    public void setSingerInfo(String singerInfo) {
        this.singerInfo = singerInfo;
    }

    public int getClout() {
        return clout;
    }

    public void setClout(int clout) {
        this.clout = clout;
    }
}
