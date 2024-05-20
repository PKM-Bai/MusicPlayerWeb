package com.music.controller;

import com.music.entity.Msg;
import com.music.entity.SongList;
import com.music.entity.User;
import com.music.service.DatabaseService;
import com.music.service.SongListService;
import com.music.service.UserService;
import com.music.utils.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private SongListService songListService;
    @Autowired
    private DatabaseService dbService;

    @RequestMapping("/index")
    public String toUserIndex(int uid, Model model){
        List<SongList> songLists = userService.findCreatSongList(uid);
        for (int i = 0; i < songLists.size(); i++) {
            songLists.get(i).setMusicList(songListService.findMusicBySongListID(songLists.get(i).getSl_id()));
        }
        model.addAttribute("creatSongList", songLists);
        model.addAttribute("user", userService.findByUserId(uid));

        return "user-index";
    }

    @RequestMapping("/song_list")
    public String toUser_songList(int uid, int sl_id, Model model) {
        User user = userService.findByUserId(uid);
        List<SongList> creatSongLists = userService.findCreatSongList(user.getU_id());
        SongList songList = null;
        for (SongList sl : creatSongLists)
        {
            if(sl.getSl_id() == sl_id)
            {
                songList = sl;
            }
        }
        if(songList == null && creatSongLists.size() != 0)
            songList = creatSongLists.get(0);

        // 获取每个歌单中的歌曲列表
        for (int i = 0; i < creatSongLists.size(); i++) {
            creatSongLists.get(i).setMusicList(songListService.findMusicBySongListID(creatSongLists.get(i).getSl_id()));
        }
        model.addAttribute("creatSongList", creatSongLists);
        model.addAttribute("songList", songList);
        model.addAttribute("user", user);

        return "user-songList";
    }



    @RequestMapping(value = "/login")
    @ResponseBody
    public Msg login(String accountNum, String password, HttpSession session) {
        User user = userService.login(accountNum, password);
        if (user != null){
            session.setAttribute("user", user);
            return Msg.success();
        } else {
            return Msg.fail();
        }
    }

    @RequestMapping(value = "/out_login")
    @ResponseBody
    public Msg out_login(HttpSession session) {
        session.invalidate();   // 销毁跟用户关联session
        return Msg.success();
    }
    @RequestMapping(value = "/userPage_out_login")
    public String userPage_out_login(HttpSession session) {
        session.invalidate();   // 销毁跟用户关联session
        return "redirect:../index.jsp";
    }

    @ResponseBody
    @RequestMapping(value = "/update_user")
    public Msg update_user(HttpServletRequest request,@RequestParam(value="pic",required = false) MultipartFile file,HttpSession session) {
        int uid = Integer.parseInt(request.getParameter("u_id"));
        String name = request.getParameter("u_name");
        String sex = request.getParameter("u_sex");
        String head = null;
        try {
            if(!file.isEmpty())
            {
                head = file.getOriginalFilename();
                file.transferTo(new File(Tools.projectResourcePath + "\\image\\HeadPortrait\\" + file.getOriginalFilename())); //复制文件
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }finally {
            User user = userService.findByUserId(uid);

            if (user == null)
                return Msg.fail();

            user.setName(name);
            user.setSex(sex);
            if(head != null)
                user.setHead(head);
            int r = userService.updateUserInfo(user);
            if (r == 0)
                return Msg.fail();

            session.setAttribute("user", user);

            return Msg.success();
        }

    }


    @RequestMapping(value = "/init_db")
    public Msg Init_database() {
        dbService.InitDatabase();
        return Msg.success();
    }

}
