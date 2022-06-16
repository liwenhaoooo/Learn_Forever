package com.online_course.business.controller.admin;

import com.online_course.server.domain.Chapter;
import com.online_course.server.dto.ChapterDto;
import com.online_course.server.service.ChapterService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author wenhaoli
 * @date 2022/06/12 16:46
 */
@RequestMapping("/admin/chapter")
@RestController
public class ChapterController {
    @Resource
    private ChapterService chapterService;
    @RequestMapping("/list")
    public List<ChapterDto> list(){
        return chapterService.list();
    }
}
