package com.service.impl;

import com.dao.StudentDao;
import com.entity.Student;
import com.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentDao studentDao;


    @Override
    public Map selecByPageAndByUsername(int page, int rows, String name) {
        name = name == null  ? null : "%" + name + "%";
        int start = (page - 1) * rows;
        Map map = new HashMap();
        List<Student> students = studentDao.selectAll(start, rows, name);
        int total = studentDao.getCount(name);
        map.put("total", total);
        map.put("rows", students);

        return map;
    }

    @Override
    public void updateByPrimaryKey(Student student) {
        studentDao.updateByPrimaryKeySelective(student);
    }

    @Override
    public void add(Student student) {
        studentDao.add(student);
    }

    @Override
    public void multiDelete(int[] ids) {
        studentDao.multiDelete(ids);
    }
}
