package com.dao;

import com.entity.Student;
import org.apache.ibatis.annotations.Param;

import javax.security.auth.Subject;
import java.util.List;

public interface StudentDao {


    List<Student> selectAll(@Param("start") int start, @Param("page") int page,
                            @Param("name") String name);

    int getCount(@Param("name") String name);

    void multiDelete(int[] ids);

    int updateByPrimaryKeySelective(Student student);

    int add(Student student);
}