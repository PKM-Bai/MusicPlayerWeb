package com.music.controller;

import com.music.entity.Msg;
import com.music.entity.Music;
import com.music.entity.PlayList;
import com.music.entity.UserPlaySetting;
import com.music.service.MusicService;
import com.music.service.SongListService;
import com.music.service.UserPlaySettingService;
import com.music.service.UserService;
import com.music.utils.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@RequestMapping(value = "/play")
@Controller
public class PlayController {
    @Autowired
    private UserService userService;
    @Autowired
    private MusicService musicService;
    @Autowired
    private SongListService songListService;
    @Autowired
    private UserPlaySettingService playSettingService;

    @RequestMapping(value = "/queryAllCurPlay")
    public String queryAllCurPlay(Model model) {
        List<Music> musicList = musicService.getAllMusic();
        return switchSongList(model, musicList);
    }
    @RequestMapping(value = "/playSongList")
    public String playSongList(int sl_id, Model model) {
        List<Music> musicList = songListService.findMusicBySongListID(sl_id);
        return switchSongList(model, musicList);
    }

    @RequestMapping(value = "/playMusic")
    public String playMusic(String id, Model model) {
        Music music = musicService.getIDMusic(id);
        PlayList.getPlayList().addMusic(music);
        model.addAttribute("playList", PlayList.getPlayList().getMusicList());

        if(music != null)
        {
            String lyric = "";
            String path = Tools.projectResourcePath + "\\music\\lyric\\" + music.getLyricFile();
            try {
                lyric = musicService.getMuiscLyric(path);
                model.addAttribute("lyric", lyric);
                ArrayList<String> singerImgList = musicService.getSinger(music.getSinger()).getSingerImage();
                if (singerImgList != null) {
                    model.addAttribute("singerImgList", singerImgList);
                }
            }
            catch (Exception e) { e.printStackTrace(); }
            finally {
                model.addAttribute("music", music);
            }

        }
        return "play";
    }

    @RequestMapping(value = "/nextSong")
    public String nextSong(String id, Model model) {
        Music music = musicService.nextSong(musicService.getIDMusic(id));
        return switchPlay(model, music);
    }
    @RequestMapping(value = "/lastSong")
    public String lastSong(String id, Model model) {
        Music music = musicService.lastSong(musicService.getIDMusic(id));
        return switchPlay(model, music);
    }

    @RequestMapping(value = "/singlePlay")
    public String singlePlay(String id, Model model)
    {
        Music music = musicService.getIDMusic(id);
        return switchPlay(model, music);
    }

    @RequestMapping(value = "/randomPlay")
    public String randomPlay(String id, Model model)
    {
        Music music = musicService.randomPlaySong(musicService.getIDMusic(id));
        return switchPlay(model, music);
    }

    // 列表是否播放完毕
    @RequestMapping(value = "/isListPlayOver")
    @ResponseBody
    public Msg isListPlayOver(String id)
    {
        List<Music> list = PlayList.getPlayList().getMusicList();
        if(list.get(list.size()-1).getId().equals(musicService.getIDMusic(id).getId()))
            return Msg.success().add("over", true);
        else
            return Msg.success().add("over", false);
    }

    // 切换歌单播放
    private String switchSongList(Model model, List<Music> musicList) {
        String lyric = "";
        if (musicList != null){
            PlayList.getPlayList().setMusicList(musicList);
            try {
                // 默认将列表中第一首歌曲传送到前端
                String path = Tools.projectResourcePath + "\\music\\lyric\\" + musicList.get(0).getLyricFile();
                lyric = musicService.getMuiscLyric(path);
                ArrayList<String> singerImgList = musicService.getSinger(musicList.get(0).getSinger()).getSingerImage();
                if (singerImgList != null)
                    model.addAttribute("singerImgList", singerImgList);
            }catch (Exception e){ e.printStackTrace(); }
            model.addAttribute("lyric", lyric);
            model.addAttribute("music", musicList.get(0));
            model.addAttribute("playList", musicList);
        }
        else
            System.out.println("无");

        return "play";
    }
    // 切换音乐播放
    private String switchPlay(Model model, Music music) {
        String lyric = "";
        try {
            String path = Tools.projectResourcePath + "\\music\\lyric\\" + music.getLyricFile();
            lyric = musicService.getMuiscLyric(path);
        }catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("lyric", lyric);
        model.addAttribute("music", music);
        model.addAttribute("playList", PlayList.getPlayList().getMusicList());
        return "play";
    }

    @RequestMapping(value = "/loadSetting")
    @ResponseBody
    private Msg LoadPlaySetting(int uid, HttpSession session) {
        UserPlaySetting playSetting = playSettingService.GetPlaySettingByUid(uid);
        if(playSetting == null)
        {
            playSetting = new UserPlaySetting();
            // 当前用户没有播放设置时，向数据库添加默认设置
            playSetting = playSetting.GetDefaultSetting(uid);
            playSettingService.CreatPlaySetting(playSetting);
        }
        session.setAttribute("playSetting", playSetting);
        return Msg.success().add("playSetting", playSetting);
    }

    @RequestMapping(value = "/saveSetting")
    @ResponseBody
    private Msg SavePlaySetting(int uid, String foreground1, String foreground2, String background1, String background2, float lyricBgAlpha, int musicVolume, HttpSession session)
    {
        if(userService.findByUserId(uid) != null)
        {
            UserPlaySetting playSetting = playSettingService.GetPlaySettingByUid(uid);
            if(playSetting == null)
            {
                playSetting = new UserPlaySetting(uid, foreground1, foreground2, background1, background2, lyricBgAlpha, musicVolume);
                playSettingService.CreatPlaySetting(playSetting);
            }
            else {
                playSetting = new UserPlaySetting(uid, foreground1, foreground2, background1, background2, lyricBgAlpha, musicVolume);
                playSettingService.SetPlaySetting(playSetting);
            }
            session.setAttribute("playSetting", playSetting);
        }
        else
            session.setAttribute("playSetting", null);
        return Msg.success();
    }

}
