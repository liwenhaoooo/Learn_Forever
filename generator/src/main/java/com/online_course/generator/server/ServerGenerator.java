package com.online_course.generator.server;

import com.online_course.generator.util.FreemarkerUtil;
import freemarker.template.TemplateException;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @author wenhaoli
 * @date 2022/06/18 11:54
 */
public class ServerGenerator {
    static String toServicePath = "server\\src\\main\\java\\com\\online_course\\server\\service\\";

    public static void main(String[] args) throws IOException, TemplateException {
        String Domain = "Section";
        String domain = "section";
        Map<String, Object> map = new HashMap<>();
        map.put("Domain", Domain);
        map.put("domain", domain);

        FreemarkerUtil.initConfig("service.ftl");
        FreemarkerUtil.generator(toServicePath + Domain + "Service.java", map);
    }
}
