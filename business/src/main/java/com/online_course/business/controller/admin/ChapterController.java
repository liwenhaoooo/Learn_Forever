package com.online_course.business.controller.admin;

import com.github.pagehelper.Page;
import com.online_course.server.domain.Chapter;
import com.online_course.server.dto.ChapterDto;
import com.online_course.server.dto.PageDto;
import com.online_course.server.dto.ResponseDto;
import com.online_course.server.service.ChapterService;
import com.online_course.server.util.ValidatorUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author wenhaoli
 * @date 2022/06/12 16:46
 */
@RequestMapping("/admin/chapter")
@RestController
public class ChapterController {

    private static final Logger LOG = LoggerFactory.getLogger(ChapterController.class);
    public static final String BUSINESS_NAME = "大章";


    @Resource
    private ChapterService chapterService;

    /**
     * 列表查询
     */
    @PostMapping("/list")
    public ResponseDto list(@RequestBody PageDto pageDto) {
        ResponseDto responseDto = new ResponseDto();
        chapterService.list(pageDto);
        responseDto.setContent(pageDto);
        return responseDto;
    }
    /**
     * 保存，id有值时更新，无值时新增
     */
    @PostMapping("/save")
    public ResponseDto save(@RequestBody ChapterDto chapterDto) {

        // 保存校验
        ValidatorUtil.require(chapterDto.getName(), "Name");
        ValidatorUtil.require(chapterDto.getCourseId(), "CourseID");
        ValidatorUtil.length(chapterDto.getCourseId(), "CourseID", 1, 8);


        ResponseDto responseDto = new ResponseDto();
        chapterService.save(chapterDto);
        responseDto.setContent(chapterDto);
        return responseDto;
    }
    /**
     * 删除
     */
    @DeleteMapping("/delete/{id}")
    public ResponseDto delete(@PathVariable String id) {
        ResponseDto responseDto = new ResponseDto();
        chapterService.delete(id);
        return responseDto;
    }
}
