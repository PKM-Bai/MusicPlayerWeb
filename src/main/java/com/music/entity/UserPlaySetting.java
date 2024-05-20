package com.music.entity;

public class UserPlaySetting {
    private int uid;
    private String foreground1;
    private String foreground2;
    private String background1;
    private String background2;
    private float lyricBgAlpha;
    private int musicVolume;

    public UserPlaySetting() {}

    public UserPlaySetting(int uid, String foreground1, String foreground2, String background1, String background2, float lyricBgAlpha, int musicVolume) {
        this.uid = uid;
        this.foreground1 = foreground1;
        this.foreground2 = foreground2;
        this.background1 = background1;
        this.background2 = background2;
        this.lyricBgAlpha = lyricBgAlpha;
        this.musicVolume = musicVolume;
    }

    public UserPlaySetting GetDefaultSetting(int uid)
    {
        return new UserPlaySetting(uid, "#ff0202", "#f49595", "#0ecbfa", "#43f91f", 0.6f, 100);
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getForeground1() {
        return foreground1;
    }

    public void setForeground1(String foreground1) {
        this.foreground1 = foreground1;
    }

    public String getForeground2() {
        return foreground2;
    }

    public void setForeground2(String foreground2) {
        this.foreground2 = foreground2;
    }

    public String getBackground1() {
        return background1;
    }

    public void setBackground1(String background1) {
        this.background1 = background1;
    }

    public String getBackground2() {
        return background2;
    }

    public void setBackground2(String background2) {
        this.background2 = background2;
    }

    public float getLyricBgAlpha() {
        return lyricBgAlpha;
    }

    public void setLyricBgAlpha(float lyricBgAlpha) {
        this.lyricBgAlpha = lyricBgAlpha;
    }

    public int getMusicVolume() {
        return musicVolume;
    }

    public void setMusicVolume(int musicVolume) {
        this.musicVolume = musicVolume;
    }

}
