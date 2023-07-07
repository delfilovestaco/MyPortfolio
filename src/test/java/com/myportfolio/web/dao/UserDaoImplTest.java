package com.myportfolio.web.dao;

import com.myportfolio.web.domain.UserDto;
import junit.framework.TestCase;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
//import junitparams.JUnitParamsRunner;

import java.sql.Date;

import static org.junit.Assert.assertTrue;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class UserDaoImplTest extends TestCase {
    @Autowired
    private UserDao userDao;

    @Test
    public void testSelect() throws Exception{
        userDao.deleteAll();
        assertTrue(userDao.count() == 0);

        UserDto userDto = new UserDto("asdf", "1234", "서두부", "aaa@aaa.com", Date.valueOf("2021-01-01"),"fb");
        assertTrue(userDao.insert(userDto) == 1);
        assertTrue(userDao.count() == 1);

    }

    @Test
    public void testCount() throws Exception{
        userDao.deleteAll();
        assertTrue(userDao.count() == 0);

        UserDto userDto1 = new UserDto("asdf", "1234", "서두부", "aaa@aaa.com", Date.valueOf("2021-01-01"),"fb");
        assertTrue(userDao.insert(userDto1) == 1);
        assertTrue(userDao.count() == 1);

        UserDto userDto2 = new UserDto("asdf2", "1234", "서두부", "aaa@aaa.com", Date.valueOf("2021-01-01"),"fb");
        assertTrue(userDao.insert(userDto2) == 1);
        assertTrue(userDao.count() == 2);
    }

    @Test
    public void testInsert() throws Exception{
        userDao.deleteAll();
        assertTrue(userDao.count() == 0);

        UserDto userDto = new UserDto("asdf", "1234", "서두부", "aaa@aaa.com", Date.valueOf("2021-01-01"),"fb");
        assertTrue(userDao.insert(userDto) == 1);
        assertTrue(userDao.count() == 1);


    }

    @Test
    public void testDelete() throws Exception{
        userDao.deleteAll();
        assertTrue(userDao.count() == 0);

        UserDto userDto = new UserDto("asdf", "1234", "서두부", "aaa@aaa.com", Date.valueOf("2021-01-01"),"fb");
        assertTrue(userDao.insert(userDto) == 1);
        assertTrue(userDao.count() == 1);

        assertTrue(userDao.delete("asdf", "1234") == 1);
        assertTrue(userDao.count() == 0);
    }

    @Test
    public void testDeleteAll() throws Exception{
        userDao.deleteAll();
        assertTrue(userDao.count() == 0);

        UserDto userDto1 = new UserDto("asdf", "1234", "서두부", "aaa@aaa.com", Date.valueOf("2021-01-01"),"fb");
        assertTrue(userDao.insert(userDto1) == 1);
        assertTrue(userDao.count() == 1);
        UserDto userDto2 = new UserDto("asdf2", "1234", "서두부", "aaa@aaa.com", Date.valueOf("2021-01-01"),"fb");
        assertTrue(userDao.insert(userDto2) == 1);
        assertTrue(userDao.count() == 2);

        userDao.deleteAll();
        assertTrue(userDao.count() == 0);
    }

    @Test
    public void testUpdate() throws Exception{
        userDao.deleteAll();
        assertTrue(userDao.count() == 0);

        //데이터 한개 생성
        UserDto userDto1 = new UserDto("asdf", "1234", "서두부", "aaa@aaa.com", Date.valueOf("2021-01-01"),"fb");
        assertTrue(userDao.insert(userDto1) == 1);
        assertTrue(userDao.count() == 1);

        //모든 데이터 중 특정 아이디를 가진 데이터 가져옴
        String id = userDao.selectAll().get(0).getId();
        userDto1.setId(id); //데이터 객체의 아이디를 세팅
        userDto1.setName("이베베"); //데이터 객체의 이름을 세팅
        userDto1.setPwd("123400"); //데이터 객체의 비번을 세팅
        //넘겨준 객체에 세팅된 아이디와 같은 아이디의 데이터의
        //이름과 비번을 세팅된 값으로 바꿈
        assertTrue(userDao.update(userDto1)==1);

        //아이디를 넘겨주며 DTO 객체 하나 받아옴
        UserDto userDto2 = userDao.select(id);
        assertTrue(userDto1.equals(userDto2));
    }

    @Test
    public void countId() throws Exception{
        assertTrue(userDao.countId("asdf") == 1);
    }
}