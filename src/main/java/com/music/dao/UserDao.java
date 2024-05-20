package com.music.dao;

import com.music.entity.SongList;
import com.music.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao {
    User login(@Param("loginAcctNum") String accountNum, @Param("loginPassword") String password);

    User findByUserId(int uid);

    int updateUserInfo(User user);

    List<SongList> findCreatSongList(int uid);

}
