package com.music.controller;


import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

@Controller
public class ToolsController {

    @RequestMapping(value = "/downMusic")
    public ResponseEntity<byte []> fileDownload(HttpServletRequest request, String filename) throws IOException {
        // 指定要下载的文件所在路径
        String path = request.getServletContext().getRealPath("/resources/music/flac");
        // 创建该文件对象
        File file = new File(path + File.separator + filename);
        // 对文件名编码，防止中文文件乱码
        filename = this.getFilename(request, filename);
        // 设置响应头
        HttpHeaders headers = new HttpHeaders();
        // 通知浏览器以下载的方式打开文件
        headers.setContentDispositionFormData("attachment", filename);
        // 定义以流的形式下载返回文件数据
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        // 使用stringMVC框架的ResponseEntity对象封装返回下载数据
        return new ResponseEntity<byte []>(FileUtils.readFileToByteArray(file), headers, HttpStatus.OK);
    }


    public String getFilename(HttpServletRequest request, String filename) throws UnsupportedEncodingException {
        // IE不同版本 User-Agent 中出现的关键词
        String[] IEBrowserKeyWords = {"MSIE", "Trident", "Edge"};
        // 获取请求头代理信息
        String userAgent = request.getHeader("User-Agent");
        for (String keyWord : IEBrowserKeyWords) {
            // IE内核浏览器，统一为UTF-8编码显示
            return URLEncoder.encode(filename, "UTF-8");
        }
        // 火狐等其他浏览器统一为 ISO-8859-1 编码显示
        return new String(filename.getBytes("UTF-8"), "ISO-8859-1");
    }

}
