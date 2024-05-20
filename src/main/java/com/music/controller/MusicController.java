package com.music.controller;

import com.music.entity.Msg;
import com.music.service.MusicService;
import com.music.entity.Music;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping(value = "/music")
public class MusicController {

    @Autowired
    private MusicService musicService;

    @RequestMapping(value = "/getAllMusic")
    @ResponseBody
    public Msg getAllMusic()  {
        List<Music> list = musicService.getAllMusic();
        if (list != null)
            return Msg.success().add("musicList", list);
        else
            return Msg.success().add("musicList", null);
    }

}
