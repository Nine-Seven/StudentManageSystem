package com.controller;

import com.entity.Student;
import com.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
public class StudentController {
    @Autowired
    private StudentService studentService;


    @RequestMapping("/selectAll")
    @ResponseBody
    public Map selectAll(int page, int rows, String name) {
        return studentService.selecByPageAndByUsername(page, rows, name);
    }

    @RequestMapping("/update")
    public @ResponseBody
    Boolean update(Student student) {

        try {
            studentService.updateByPrimaryKey(student);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @RequestMapping("/add")
    public @ResponseBody
    Boolean add(Student student) {
      //  System.out.println(student);
        try {
            studentService.add(student);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }
    @RequestMapping("/multiDelete")
    public @ResponseBody
    Boolean multiDelete(int[] ids) {
        try {
            studentService.multiDelete(ids);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }


}
