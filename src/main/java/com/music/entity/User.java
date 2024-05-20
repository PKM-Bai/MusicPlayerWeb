package com.music.entity;

import com.music.utils.Tools;

import java.text.SimpleDateFormat;
import java.util.Date;

public class User {
    private int u_id;
    private String name;
    private String loginAcctNum;
    private String loginPassword;
    private String E_mail;
    private String head;
    private String info;
    private String sex;
    private String birthday;
    private String address;

    private int age;

    public User(int u_id, String name, String loginAcctNum, String loginPassword, String e_mail, String head, String info, String sex, String birthday, String address) {
        this.u_id = u_id;
        this.name = name;
        this.loginAcctNum = loginAcctNum;
        this.loginPassword = loginPassword;
        E_mail = e_mail;
        this.head = head;
        this.info = info;
        this.sex = sex;
        this.birthday = birthday;
        this.address = address;
    }

    public int getAge() {
        try {
            // 定义一个出生时间
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            Date bithday = format.parse(this.birthday);
            age = Tools.getAgeByBirth(bithday);
        }catch (Exception e) {
            age = 0;
        }
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public int getU_id() {
        return u_id;
    }

    public void setU_id(int u_id) {
        this.u_id = u_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLoginAcctNum() {
        return loginAcctNum;
    }

    public void setLoginAcctNum(String loginAcctNum) {
        this.loginAcctNum = loginAcctNum;
    }

    public String getLoginPassword() {
        return loginPassword;
    }

    public void setLoginPassword(String loginPassword) {
        this.loginPassword = loginPassword;
    }

    public String getE_mail() {
        return E_mail;
    }

    public void setE_mail(String e_mail) {
        E_mail = e_mail;
    }

    public String getHead() {
        return head;
    }

    public void setHead(String head) {
        this.head = head;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
