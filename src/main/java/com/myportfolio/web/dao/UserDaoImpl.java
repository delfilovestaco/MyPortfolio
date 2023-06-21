package com.myportfolio.web.dao;

import com.myportfolio.web.domain.UserDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class UserDaoImpl implements UserDao {
    @Autowired
    private SqlSession session;
    private String namespace="com.myportfolio.web.dao.UserMapper.";

    @Override
    public UserDto select(String id) throws Exception{
        return session.selectOne(namespace+"select", id);
    }

    @Override
    public List<UserDto> selectAll() throws Exception{
        return session.selectList(namespace+"selectAll");
    }
    @Override
    public int count() throws Exception{
        return session.selectOne(namespace+"count");
    } // T selectOne(String statement)

    @Override
    public int insert(UserDto userDto) throws Exception{
        return session.insert(namespace+"insert", userDto);
    }
    @Override
    public int delete(String id, String pwd) throws Exception{
        Map map = new HashMap();
        map.put("id", id);
        map.put("pwd", pwd);
        return session.delete(namespace+"delete", map);
    }
    @Override
    public int deleteAll() throws Exception{
        return session.delete(namespace+"deleteAll");
    } // int delete(String statement)
    @Override
    public int update(UserDto userDto) throws Exception{
        return session.update(namespace+"update", userDto);
    }

}
