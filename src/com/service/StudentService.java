package com.service;

import com.entity.Student;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface StudentService {

    Map selecByPageAndByUsername(int page, int rows, String name);

    void updateByPrimaryKey(Student student);

    void add(Student student);

    void multiDelete(int[] ids);
}
