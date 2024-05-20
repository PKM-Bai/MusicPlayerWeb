package com.music.utils;

import java.io.File;
import java.io.FileFilter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;

public class Tools {
    private static String dbName = "music_player_db";
    private static String jdbcDriver = "com.mysql.jdbc.Driver";
    private static String username = "root";
    private static String password = "root";

    public static String projectResourcePath = "E:\\Project\\WEB Project\\MusicPlayerWeb\\src\\main\\webapp\\resources";

    // 读取文本文件---用于获取歌词文本文件内容
    public static String readTxt(String filePath) {
        String result = null;
        try{
            Path path = Paths.get(filePath);
            byte[] data = Files.readAllBytes(path);
            result = new String(data, "utf-8");
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

    // 传入路径 获取该文件夹下所有文件
    public static ArrayList<String> getAllFile(String path, ArrayList<String> list) {
        File file = new File(path);
        //获取全部File
        //返回目录名加文件名
        //添加过滤器
        try{
            String[] strings = file.list();
//            for (String string : strings) {
//                System.out.println(string);
//            }
            //这些路径名表示此抽象路径名所表示目录中的文件。
            File[] files = file.listFiles(new FileFilter() {
                @Override
                public boolean accept(File pathname) {
                    return true;
                }
            });
            for (int i = 0; i < files.length; i++) {
                //判断是否是目录，是的话继续递归
                if (files[i].isDirectory()) {
                    getAllFile(files[i].getAbsolutePath(), list);
                } else {
                    //否则添加到list
                    //获取全部文件名
                    list.add(files[i].getName());
                    //获取全部包+文件名
//                    list.add(files[i].getAbsolutePath());
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return list;
    }

    // 根据生日计算年龄
    public static int getAgeByBirth(Date birthday) {
        int age = 0;
        try {
            Calendar now = Calendar.getInstance();
            now.setTime(new Date());// 当前时间

            Calendar birth = Calendar.getInstance();
            birth.setTime(birthday);

            if (birth.after(now)) {//如果传入的时间，在当前时间的后面，返回0岁
                age = 0;
            } else {
                age = now.get(Calendar.YEAR) - birth.get(Calendar.YEAR);
//                if (now.get(Calendar.DAY_OF_YEAR) > birth.get(Calendar.DAY_OF_YEAR)) {
//                    age += 1;
//                }
            }
            return age;
        } catch (Exception e) {//兼容性更强,异常后返回数据
            return 0;
        }
    }

    // 生成6位的随机整数
    public static String getRandomID() {
        Random random = new Random();
        String str = String.valueOf(random.nextInt(9));
        for (int i = 0; i < 5; i++) {
            str += random.nextInt(9);
        }
        return str;
    }

    public static void main(String[] args)
    {
        try
        {
            Class.forName(jdbcDriver);
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/?user=" + username + "&password=" + password);
            Statement s = conn.createStatement();
            int Result = s.executeUpdate("CREATE DATABASE " + dbName);
            System.out.println("数据库创建" + (Result == 0 ? "失败！" : "成功！"));
        }
        catch (Exception e)
        {
            e.printStackTrace();
            System.out.println("数据库创建失败！");
        }

    }


}

