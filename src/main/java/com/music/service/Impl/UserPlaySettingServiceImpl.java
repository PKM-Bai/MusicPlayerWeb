package com.music.service.Impl;

import com.music.dao.UserPlaySettingDao;
import com.music.entity.UserPlaySetting;
import com.music.service.UserPlaySettingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserPlaySettingServiceImpl implements UserPlaySettingService {
    @Autowired
    private UserPlaySettingDao settingDao;

    @Override
    public UserPlaySetting GetPlaySettingByUid(int uid) {
        return settingDao.GetPlaySettingByUid(uid);
    }

    @Override
    public int CreatPlaySetting(UserPlaySetting ups) {
        return settingDao.CreatPlaySetting(ups);
    }

    @Override
    public int SetPlaySetting(UserPlaySetting ups) {
        return settingDao.SetPlaySetting(ups);
    }

}
