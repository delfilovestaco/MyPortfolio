package com.myportfolio.web.dao;

import com.myportfolio.web.domain.BoardDto;
import com.myportfolio.web.domain.SearchCondition;
import com.myportfolio.web.dao.BoardDao;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class BoardDaoImplTest {
    @Autowired
    private BoardDao boardDao;

    @Test
    public void insertTestData() throws Exception{
        boardDao.deleteAll();
        assertTrue(boardDao.count()==0);

        for(int i=1; i<=220; i++){
            BoardDto boardDto = new BoardDto("title"+i, "no content"+i, "asdf" );
            boardDao.insert(boardDto);
        }

    }

    @Test
    public void countTest() throws Exception{
        boardDao.deleteAll();
        assertTrue(boardDao.count()==0);

        BoardDto boarDto = new BoardDto("title1", "contents1", "asdf");
        assertTrue(boardDao.insert(boarDto)==1);
        assertTrue(boardDao.count()==1);

        assertTrue(boardDao.insert(boarDto)==1);
        assertTrue(boardDao.count()==2);
    }

    @Test
    public void selectTest() throws Exception{
        boardDao.deleteAll();
        assertTrue(boardDao.count()==0);

        //한개의 데이터 넣기
        BoardDto boardDto = new BoardDto("no title", "no content", "asdf");
        assertTrue(boardDao.insert(boardDto)==1);
        System.out.println("boardDto.getBno() = " + boardDto.getBno()); //이건 당연히 널이지
        //ㄴ> 실제 DB에 들어간 데이터 한 행이 아니라, 타이틀, 컨텐츠, 작성자만 값을 세팅한 객체잖아
        //그걸 insert하고 -> DB에서 다시 select를 하면, 거기에 게시글 번호가 있는 거고

        //DB의 모든 데이터 중, 0번 == 1번째 행의 데이터 중 게시글 번호를 가져옴
        Integer bno = boardDao.selectAll().get(0).getBno();
        //그 게시글 번호로 위의 DTO 객체의 게시글 번호 멤버 변수를 세팅
        boardDto.setBno(bno);
        //특정 게시물 번호 넘기면서 데이터 한 행 가져오고 -> 그걸 다른 데이터 객체에 담아서 한 개 더 생성
        BoardDto boardDto2 = boardDao.select(bno);
        //그럼 boardDto1 == boardDto2 여야 함
        assertTrue(boardDto.equals(boardDto2));
    }

    @Test
    public void selectAllTest() throws Exception{
        boardDao.deleteAll();
        assertTrue(boardDao.count()==0);

        //selectAll 메서드 실행 -> 있는 모든 데이터 한 행 한 행 list로 받아옴
        List<BoardDto> list = boardDao.selectAll();
        assertTrue(list.size()==0); //아직 한개도 없음

        //데이터 한개 넣고 총 1개 나오는 지 테스트
        BoardDto boardDto = new BoardDto("no title", "no content", "asdf");
        assertTrue(boardDao.insert(boardDto)==1);
        list = boardDao.selectAll();
        assertTrue(list.size()==1);

        //데이터 한 개 더 넣고, 총 2개 나오는 지 테스트
        assertTrue(boardDao.insert(boardDto)==1);
        list = boardDao.selectAll();
        assertTrue(list.size() == 2);
    }

    @Test
    public void selectPageTest() throws Exception{
        boardDao.deleteAll();
        assertTrue(boardDao.count()==0);

        //게시글 10개 만들기
        for(int i=1; i<=10; i++){
            BoardDto boardDto = new BoardDto(""+i, "content"+1, "asdf");
            boardDao.insert(boardDto);
        }

        //offset과 pagesize 저장 및 넘겨줄 hashMap
        Map map = new HashMap();
        map.put("offset", 0); //1번부터
        map.put("pageSize", 3); //보여줄 게시글은 3개

        //offset과 pageSize 즉, 출력할 게시글 범위를 담은 map을 주면서 selectPage 호출
        //그 결과 게시글 데이터들 List로 받아옴
        //게시글들은 최신순 즉 내림차수임
        //1번 게시글 부터 3개 가져왔으니, 제일 마지막에 넣은 것부터 3개
        //즉, 타이틀 이름 10, 9, 8
        List<BoardDto> list = boardDao.selectPage(map);
        //1~3번 게시글들 제목 비교
        assertTrue(list.get(0).getTitle().equals("10"));
        assertTrue(list.get(1).getTitle().equals("9"));
        assertTrue(list.get(2).getTitle().equals("8"));

        //offset과 pageSize 저장 및 넘겨줄 hashMap
        map = new HashMap();
        map.put("offset", 0); //1번째 데이터 부터
        map.put("pageSize", 1); //1개

        list = boardDao.selectPage(map); //1번 부터 1개 데이터 담김
        assertTrue(list.get(0).getTitle().equals("10")); //내림차순 -> 가장 마지막 넣은 것

        //offset과 pageSize 저장 및 넘겨줄 hashMap
        map = new HashMap();
        map.put("offset", 7); //8번째 데이터 부터
        map.put("pageSize", 3); //3개 => 3, 2, 1

        list = boardDao.selectPage(map); //8번째 부터 3개 데이터가 담김
        assertTrue(list.get(0).getTitle().equals("3"));
        assertTrue(list.get(1).getTitle().equals("2"));
        assertTrue(list.get(2).getTitle().equals("1"));
    }

    @Test
    public void insertTest() throws Exception{
        boardDao.deleteAll();
        assertTrue(boardDao.count()==0);

        //데이터 한개 생성 후 insert 시도
        BoardDto boardDto = new BoardDto("no title", "no content", "asdf");
        assertTrue(boardDao.insert(boardDto)==1);
        assertTrue(boardDao.count()==1);

        //데이터 한개 더 생성 후 insert 시도
        boardDto = new BoardDto("no title", "no content", "asdf");
        assertTrue(boardDao.insert(boardDto)==1);
        assertTrue(boardDao.count()==2);

        //다 삭제 후 다시 데이터 한 개 생성 후 insert 시도
        boardDao.deleteAll();
        boardDto = new BoardDto("no title", "no content", "asdf");
        assertTrue(boardDao.insert(boardDto)==1);
        assertTrue(boardDao.count()==1);

    }

    @Test
    public void deleteTest() throws Exception{
        boardDao.deleteAll();
        assertTrue(boardDao.count()==0);

        //잘 삭제 되는 지
        BoardDto boardDto = new BoardDto("no title", "no content", "asdf");
        assertTrue(boardDao.insert(boardDto)==1); //1개 데이터 넣고
        Integer bno = boardDao.selectAll().get(0).getBno(); //데이터 list 전체 중 0번 리스트 데이터 한 줄 가져와서, 번호 가져오고
        assertTrue(boardDao.delete(bno, boardDto.getWriter())==1); //그 번호 그 작성자의 게시글 삭제
        assertTrue(boardDao.count()==0);

        //잘 삭제 되는 지2 : 올바른 데이터만 삭제되는 지 (없는 작성자의 이름 넘겨주고 삭제 시도)
        assertTrue(boardDao.insert(boardDto)==1); //1개 데이터 넣고
        bno = boardDao.selectAll().get(0).getBno(); //그 데이터의 게시글 번호 가져오고
        assertTrue(boardDao.delete(bno, boardDto.getWriter()+"222")==0);
        assertTrue(boardDao.count()==1);

        assertTrue(boardDao.delete(bno, boardDto.getWriter())==1);
        assertTrue(boardDao.count()==0);

        //잘 삭제 되는 지3 : 올바른 데이터만 삭제되는 지 (없는 게시글 번호 넘겨주고 삭제 시도)
        assertTrue(boardDao.insert(boardDto)==1);
        bno = boardDao.selectAll().get(0).getBno();
        assertTrue(boardDao.delete(bno+1, boardDto.getWriter())==0);
        assertTrue(boardDao.count()==1);
    }

    @Test
    public void deleteAllTest() throws Exception{
        boardDao.deleteAll();
        assertTrue(boardDao.count()==0);

        BoardDto boardDto = new BoardDto("no title", "no content", "asdf");
        assertTrue(boardDao.insert(boardDto)==1);
        assertTrue(boardDao.deleteAll()==1);
        assertTrue(boardDao.count()==0);

        boardDto = new BoardDto("no title", "no content", "asdf");
        assertTrue(boardDao.insert(boardDto)==1);
        assertTrue(boardDao.insert(boardDto)==1);
        assertTrue(boardDao.deleteAll()==2);
        assertTrue(boardDao.count()==0);
    }

    @Test
    public void updateTest() throws Exception{
        boardDao.deleteAll();
        assertTrue(boardDao.count()==0);

        //데이터 한개 생성
        BoardDto boardDto = new BoardDto("no title", "no content", "asdf");
        assertTrue(boardDao.insert(boardDto)==1);

        //모든 데이터 중 1번째 데이터의 게시글 번호 가져옴
        Integer bno = boardDao.selectAll().get(0).getBno();
        System.out.println("bno = " + bno);
        boardDto.setBno(bno); //데이터 객체의 게시글 번호 세팅
        boardDto.setTitle("yes title"); //데이터 객체의 게시글 제목 세팅
        //넘겨준 객체에 세팅된 게시글 번호와 같은 게시글 번호의 데이터의
        //내용 혹은 제목 혹은 둘 다를 dto에 세팅된 값으로 바꿈
        assertTrue(boardDao.update(boardDto)==1);

        //게시글 번호를 넘겨주며 DTO 객체 하나 받아옴
        BoardDto boardDto2 = boardDao.select(bno);
        assertTrue(boardDto.equals(boardDto2));
    }

    @Test
    public void increaseViewCntTest() throws Exception{
        boardDao.deleteAll();
        assertTrue(boardDao.count()==0);

        //새로운 데이터 객체 생성 -> DB에 데이터 삽입(생성)
        BoardDto boardDto = new BoardDto("no title", "no content", "asdf");
        assertTrue(boardDao.insert(boardDto)==1);
        assertTrue(boardDao.count()==1);

        //0번행 즉 첫번째 데이터 행의 게시글 번호 가져옴
        Integer bno = boardDao.selectAll().get(0).getBno();
        //게시글 번호를 넘기면서 조회수 올리는 메서드 호출 -> 성공 시, 1
        assertTrue(boardDao.increaseViewCnt(bno)==1);

        //게시글 번호에 맞는 데이터 행이 boardDto 객체로 반환됨
        boardDto = boardDao.select(bno);
        assertTrue(boardDto != null); //이건 왜?
        assertTrue(boardDto.getView_cnt()==1); //조회수 올리는 메서드 1회 실행 -> 조회수 1

        //조회수 올리는 메서드 한번 더 실행 -> 총 2회로 올라감
        assertTrue(boardDao.increaseViewCnt(bno)==1); //성공 시 1 반환
        boardDto = boardDao.select(bno);
        assertTrue(boardDto != null); //이건 왜?
        assertTrue(boardDto.getView_cnt()==2); //조회수 올리는 메서드 2회 실행 -> 조회수 2
    }

    @Test
    public void searchSelectPageTest() throws Exception{
        boardDao.deleteAll();
        for (int i = 1; i <= 20; i++){ //title1~title20 까지 생성
            BoardDto boardDto = new BoardDto("title"+i, "asdfasdfasdf", "asdf"+i);
            boardDao.insert(boardDto);
        }
//        List<BoardDto> list2 = boardDao.selectAll(); //20~1까지 순서로 나옴(정렬 옵션에 따라)
//        System.out.println("list2 = " + list2);

//        SearchCondition sc = new SearchCondition(1, 10, "title1", "T");
        //title20~title1(정렬 옵션에 따라)이 그냥 쭉 데이터에 저장되어 있는 것을
        //10개 데이터만 넣을 수 있는 1개 페이지에, title이 title1 혹은 title1어찌구 조건에 알맞는 것들로만 일단 채우는 작업
        //즉 1페이지에 20~1중 10개로 채우고 -> title20~title11 -> 그 다음에 title1 또는 title1 어찌구를 가져오는 게 아니라
        //데이터 10줄을 넣을 수 있는 페이지 1개에 -> title20~title1 순서로 나열된 데이터에서 -> title1 또는 title1 어찌구에 알맞는 데이터들 가져와 채우는 것
        SearchCondition sc = new SearchCondition(1, 10, "title2", "T");
        List<BoardDto> list = boardDao.searchSelectPage(sc);
        System.out.println("list = " + list);
        assertTrue(list.size()==2); //title20, title2

        sc = new SearchCondition(1, 10, "asdf2", "W"); //asdf2~
        list = boardDao.searchSelectPage(sc);
        System.out.println("list = " + list);
        assertTrue(list.size()==2); //asdf20, asdf2
    }

    @Test
    public void searchResultCntTest() throws Exception{
        boardDao.deleteAll();
        for (int i = 1; i <= 20; i++){ //title1~title20 까지 생성
            BoardDto boardDto = new BoardDto("title"+i, "asdfasdfasdf", "asdf"+i);
            boardDao.insert(boardDto);
        }
//        List<BoardDto> list2 = boardDao.selectAll(); //20~1까지 순서로 나옴(정렬 옵션에 따라)
//        System.out.println("list2 = " + list2);

//        SearchCondition sc = new SearchCondition(1, 10, "title1", "T");
        //title20~title1(정렬 옵션에 따라)이 그냥 쭉 데이터에 저장되어 있는 것을
        //10개 데이터만 넣을 수 있는 1개 페이지에, title이 title1 혹은 title1어찌구 조건에 알맞는 것들로만 일단 채우는 작업
        //즉 1페이지에 20~1중 10개로 채우고 -> title20~title11 -> 그 다음에 title1 또는 title1 어찌구를 가져오는 게 아니라
        //데이터 10줄을 넣을 수 있는 페이지 1개에 -> title20~title1 순서로 나열된 데이터에서 -> title1 또는 title1 어찌구에 알맞는 데이터들 가져와 채우는 것
        SearchCondition sc = new SearchCondition(1, 10, "title2", "T");
        int resultCnt = boardDao.searchResultCnt(sc); //해당 searchCondition 조건에 맞게 테이블(게시판)을 구성 -> 10개 들어가는 1페이지에 title2 조건으로 -> 20, 2 들어감
        List<BoardDto> list = boardDao.searchSelectPage(sc);
        System.out.println("list = " + list);
        assertTrue(resultCnt==2); //title20, title2

        sc = new SearchCondition(1, 10, "asdf2", "W");
        resultCnt = boardDao.searchResultCnt(sc);
        System.out.println("resultCnt = " + resultCnt);
        assertTrue(resultCnt==2);
    }


}