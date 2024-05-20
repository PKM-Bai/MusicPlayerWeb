package com.music.service;

import com.music.entity.SongList;
import com.music.entity.User;

import java.util.List;

public interface UserService {
    User login(String accountNum, String password);

    User findByUserId(int uid);

    int updateUserInfo(User user);

    List<SongList> findCreatSongList(int uid);
}
