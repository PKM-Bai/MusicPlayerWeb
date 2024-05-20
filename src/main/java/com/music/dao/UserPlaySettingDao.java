package com.music.dao;

import com.music.entity.UserPlaySetting;

public interface UserPlaySettingDao {
    // 根据用户id获取他的播放设置
    UserPlaySetting GetPlaySettingByUid(int uid);
    // 创建用户播放设置
    int CreatPlaySetting(UserPlaySetting ups);
    // 修改用户播放设置
    int SetPlaySetting(UserPlaySetting ups);

}
