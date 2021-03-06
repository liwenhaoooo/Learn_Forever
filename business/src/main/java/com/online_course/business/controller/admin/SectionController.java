package com.online_course.business.controller.admin;

import com.github.pagehelper.Page;
import com.online_course.server.domain.Section;
import com.online_course.server.dto.SectionDto;
import com.online_course.server.dto.PageDto;
import com.online_course.server.dto.ResponseDto;
import com.online_course.server.dto.SectionPageDto;
import com.online_course.server.service.SectionService;
import com.online_course.server.util.ValidatorUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author wenhaoli
 * @date 2022/06/12 16:46
 */
@RequestMapping("/admin/section")
@RestController
public class SectionController {

    private static final Logger LOG = LoggerFactory.getLogger(SectionController.class);
    public static final String BUSINESS_NAME = "小节";

@Resource
    private SectionService sectionService;

    /**
     * 列表查询
     */
    @PostMapping("/list")
    public ResponseDto list(@RequestBody SectionPageDto sectionPageDto) {
        ResponseDto responseDto = new ResponseDto();
        ValidatorUtil.require(sectionPageDto.getCourseId(), "CourseID");
        ValidatorUtil.require(sectionPageDto.getChapterId(), "ChapterID");
        sectionService.list(sectionPageDto);
        responseDto.setContent(sectionPageDto);
        return responseDto;
    }
    /**
     * 保存，id有值时更新，无值时新增
     */
    @Transactional
    @PostMapping("/save")
    public ResponseDto save(@RequestBody SectionDto sectionDto) {
        // 保存校验
        ValidatorUtil.require(sectionDto.getTitle(), "标题");
        ValidatorUtil.length(sectionDto.getTitle(), "标题", 1, 50);
        ValidatorUtil.length(sectionDto.getVideo(), "视频", 1, 200);

        ResponseDto responseDto = new ResponseDto();
        sectionService.save(sectionDto);
        responseDto.setContent(sectionDto);
        return responseDto;
    }
    /**
     * 删除
     */
    @DeleteMapping("/delete/{id}")
    public ResponseDto delete(@PathVariable String id) {
        ResponseDto responseDto = new ResponseDto();
        sectionService.delete(id);
        return responseDto;
    }
}
