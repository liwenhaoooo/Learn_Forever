package com.online_course.${module}.controller.admin;

import com.github.pagehelper.Page;
import com.online_course.server.domain.${Domain};
import com.online_course.server.dto.${Domain}Dto;
import com.online_course.server.dto.PageDto;
import com.online_course.server.dto.ResponseDto;
import com.online_course.server.service.${Domain}Service;
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
@RequestMapping("/admin/${domain}")
@RestController
public class ${Domain}Controller {

    private static final Logger LOG = LoggerFactory.getLogger(${Domain}Controller.class);
    public static final String BUSINESS_NAME = "${tableNameCn}";



@Resource
    private ${Domain}Service ${domain}Service;

    /**
     * 列表查询
     */
    @PostMapping("/list")
    public ResponseDto list(@RequestBody PageDto pageDto) {
        ResponseDto responseDto = new ResponseDto();
        ${domain}Service.list(pageDto);
        responseDto.setContent(pageDto);
        return responseDto;
    }
    /**
     * 保存，id有值时更新，无值时新增
     */
    @PostMapping("/save")
    public ResponseDto save(@RequestBody ${Domain}Dto ${domain}Dto) {

        // 保存校验



        ResponseDto responseDto = new ResponseDto();
        ${domain}Service.save(${domain}Dto);
        responseDto.setContent(${domain}Dto);
        return responseDto;
    }
    /**
     * 删除
     */
    @DeleteMapping("/delete/{id}")
    public ResponseDto delete(@PathVariable String id) {
        ResponseDto responseDto = new ResponseDto();
        ${domain}Service.delete(id);
        return responseDto;
    }
}