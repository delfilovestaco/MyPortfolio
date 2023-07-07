package com.myportfolio.web.dao;

import com.myportfolio.web.domain.UserDto;

import java.util.List;

public interface UserDao {
    UserDto select(String id) throws Exception;

    List<UserDto> selectAll() throws Exception;

    int count() throws Exception // T selectOne(String statement)
    ;
    int countId(String id) throws Exception;

    int insert(UserDto userDto) throws Exception;

    int delete(String id, String pwd) throws Exception;

    int deleteAll() throws Exception // int delete(String statement)
    ;

    int update(UserDto userDto) throws Exception;
}
