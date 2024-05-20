package com.music.entity;

public class Song_list_song {
    private String sl_m_id;
    private String m_id;
    private int sl_id;
    private String addData;

    public String getSl_m_id() {
        return sl_m_id;
    }

    public void setSl_m_id(String sl_m_id) {
        this.sl_m_id = sl_m_id;
    }

    public String getM_id() {
        return m_id;
    }

    public void setM_id(String m_id) {
        this.m_id = m_id;
    }

    public int getSl_id() {
        return sl_id;
    }

    public void setSl_id(int sl_id) {
        this.sl_id = sl_id;
    }

    public String getAddData() {
        return addData;
    }

    public void setAddData(String addData) {
        this.addData = addData;
    }

    public Song_list_song(String sl_m_id, String m_id, int sl_id, String addData) {
        this.sl_m_id = sl_m_id;
        this.m_id = m_id;
        this.sl_id = sl_id;
        this.addData = addData;
    }
}
