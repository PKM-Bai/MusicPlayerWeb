package com.music.controller;

import com.music.entity.Msg;
import com.music.entity.SongList;
import com.music.entity.Song_list_song;
import com.music.service.SongListService;
import com.music.utils.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@RequestMapping(value = "/songlist")
public class SongListController {
    @Autowired
    private SongListService songListService;

    // 切换歌单列表
    @RequestMapping(value = "/switch_sl")
    @ResponseBody
    public Msg switch_sl(int sl_id) {
        SongList songList = songListService.findSongListByID(sl_id);
        songList.setMusicList(songListService.findMusicBySongListID(sl_id));

        if(songList != null)
            return Msg.success().add("songList", songList);
        else
            return Msg.fail();
    }

    // 在歌单中移除音乐
    @RequestMapping(value = "/removeMusic", method = RequestMethod.POST)
    @ResponseBody
    public Msg fromSLRemoveMusic(int sl_id, String m_id) {
        int rows = songListService.removeMusic(sl_id, m_id);
        if (rows != 0){
            SongList songList = songListService.findSongListByID(sl_id);
            songList.setMusicList(songListService.findMusicBySongListID(sl_id));
            return Msg.success().add("songList", songList);
        }
        else
            return Msg.fail();
    }

    // 添加音乐到收藏单
    @RequestMapping(value = "/addMusic", method = RequestMethod.POST)
    @ResponseBody
    public Msg fromSLAddMusic(int sl_id, String m_id) {
        String id = Tools.getRandomID();
        Date date = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

        Song_list_song sls = new Song_list_song(id, m_id, sl_id, dateFormat.format(date));
        int rows = songListService.addMusic(sls);
        if (rows != 0){
            SongList songList = songListService.findSongListByID(sl_id);
            songList.setMusicList(songListService.findMusicBySongListID(sl_id));
            return Msg.success().add("songList", songList);
        }
        else
            return Msg.fail();
    }

}
