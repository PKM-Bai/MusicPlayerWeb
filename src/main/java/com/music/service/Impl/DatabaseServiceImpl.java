package com.music.service.Impl;

import com.music.dao.DatabaseDao;
import com.music.entity.*;
import com.music.service.DatabaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;


@Service
public class DatabaseServiceImpl implements DatabaseService
{
    @Autowired
    private DatabaseDao dbDao;

    List<Music> musics = new ArrayList();
    List<Singer> singers = new ArrayList();
    List<SongList> songList = new ArrayList();
    List<Song_list_song> song_list_songs = new ArrayList();
    List<User> users = new ArrayList();
    List<UserPlaySetting> userPlaySettings = new ArrayList();

    // 初始表数据
    public void Init_table_Data()
    {
        // music表数据
        {
            musics.add(new Music("M100001", "好きだから。", "『ユイカ』", "109951166125448895.jpg", "00:00:04:58", 519, "『ユイカ』 - 好きだから。.mp3", "『ユイカ』 - 好きだから。.txt"));
            musics.add(new Music("M100002", "打上花火", "DAOKO、米津玄師", "2566658895.jpg", "00:00:04:49", 118, "DAOKO、米津玄師 - 打上花火.flac", "打上花火.txt"));
            musics.add(new Music("M100003", "だんご大家族", "茶太、真理絵", "3424978721550752.jpg", "00:00:04:33", 161, "茶太,真理絵 - だんご大家族.flac", "だんご大家族.txt"));
            musics.add(new Music("M100004", "Celestial", "Ed Sheeran", "109951167913263694.jpg", "00:00:03:29", 21, "Ed Sheeran - Celestial.mp3", "Ed Sheeran - Celestial.txt"));
            musics.add(new Music("M100005", "孤勇者", "陈奕迅", "0d338744ebf81a.jpg", "00:00:04:16", 152, "陈奕迅 - 孤勇者.mp3", "孤勇者.txt"));
        }

        // singer表数据
        {
            singers.add(new Singer("G129884", "茶太", null, null, 0));
            singers.add(new Singer("G275513", "真理絵", null, null, 0));
            singers.add(new Singer("G458331", "米津玄師", null, null, 0));
            singers.add(new Singer("G498234", "薛之谦", null, null, 0));
            singers.add(new Singer("G673215", "DAOKO、米津玄師", null, null, 0));
            singers.add(new Singer("G871215", "陈奕迅", "陈奕迅", null, 0));
            singers.add(new Singer("G872699", "DAOKO", null, null, 0));
            singers.add(new Singer("G987213", "茶太、真理絵", null, null, 0));
        }

        // song_list表数据
        {
            songList.add(new SongList(111540, "31w(ﾟДﾟ)w", "184100", "0000-00-00", 0));
            songList.add(new SongList(154822, "我喜欢的音乐", "246634", "2020-02-22", 6));
            songList.add(new SongList(213451, "安静", "246634", "2019-05-19", 0));
        }

        // song_list__song表数据
        {
            song_list_songs.add(new Song_list_song("123566", "M100005", 154822, "2022-03-11 14:12:17"));
            song_list_songs.add(new Song_list_song("211515", "M100004", 154822, "2022-03-11 15:12:28"));
            song_list_songs.add(new Song_list_song("231512", "M100002", 154822, "2022-03-11 15:11:42"));
            song_list_songs.add(new Song_list_song("321541", "M100001", 213451, "2022-03-11 15:12:44"));
            song_list_songs.add(new Song_list_song("341125", "M100003", 154822, "2022-03-12 15:13:19"));
            song_list_songs.add(new Song_list_song("354512", "M100003", 213451, "2022-03-09 15:13:27"));
            song_list_songs.add(new Song_list_song("458001", "M100004", 213451, "2022-03-10 07:13:29"));
            song_list_songs.add(new Song_list_song("535324", "M100001", 154822, "2022-03-11 20:13:38"));
        }

        // user表数据
        {
            users.add(new User(184100, "初始", "2", "2", null, null, null, "女", "2099-02-16", null));
            users.add(new User(246634, "？？？", "admin", "admin", "1242013107@qq.com", "猫奴.jpg", null, "男", "2002-02-16", "河南省 - 开封市"));
        }

        // user_playsetting表数据
        {
            userPlaySettings.add(new UserPlaySetting(246634, "#d1c2c2", "#16d092", "#0c738d", "#c21ce3", 0.76f, 15));
        }
    }


    @Override
    public void InitDatabase() {
        Init_table_Data();    // 生成初始化数据库表数据

        // 如果表已存在，删除表
        dbDao.DropTable("user_playsetting");
        dbDao.DropTable("song_list__song");
        dbDao.DropTable("user");
        dbDao.DropTable("song_list");
        dbDao.DropTable("singer");
        dbDao.DropTable("music");

        // 创建表
        dbDao.CreateMusicTable();
        dbDao.CreateSingerTable();
        dbDao.CreateSongListTable();
        dbDao.CreateSongListSongTable();
        dbDao.CreateUserTable();
        dbDao.CreateUserSettingTable();

        // 插入表数据
        dbDao.Insert_Music(musics);
        dbDao.Insert_Singer(singers);
        dbDao.Insert_SongList(songList);
        dbDao.Insert_Song_list_song(song_list_songs);
        dbDao.Insert_User(users);
        dbDao.Insert_UserPlaySetting(userPlaySettings);
    }
}
