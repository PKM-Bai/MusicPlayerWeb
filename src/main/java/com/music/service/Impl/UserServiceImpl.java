package com.music.service.Impl;

import com.music.dao.UserDao;
import com.music.entity.SongList;
import com.music.entity.User;
import com.music.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;

    @Override
    public User login(String accountNum, String password) {
        return userDao.login(accountNum, password);
    }

    @Override
    public User findByUserId(int uid) {
        return userDao.findByUserId(uid);
    }

    @Override
    public int updateUserInfo(User user) {
        return userDao.updateUserInfo(user);
    }

    @Override
    public List<SongList> findCreatSongList(int uid) {
        return userDao.findCreatSongList(uid);
    }

}
