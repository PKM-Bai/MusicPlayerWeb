package com.music.dao;

import com.music.entity.*;

import java.util.List;

public interface DatabaseDao {
    void DropTable(String tableNmae);

    // 创建初始数据库表
    void CreateMusicTable();
    void CreateSingerTable();
    void CreateSongListTable();
    void CreateSongListSongTable();
    void CreateUserTable();
    void CreateUserSettingTable();

    void Insert_Music(List<Music> list);
    void Insert_Singer(List<Singer> list);
    void Insert_SongList(List<SongList> list);
    void Insert_Song_list_song(List<Song_list_song> list);
    void Insert_User(List<User> list);
    void Insert_UserPlaySetting(List<UserPlaySetting> list);
}
