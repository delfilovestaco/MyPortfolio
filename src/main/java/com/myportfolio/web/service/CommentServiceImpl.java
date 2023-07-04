package com.myportfolio.web.service;

import com.myportfolio.web.dao.BoardDao;
import com.myportfolio.web.dao.CommentDao;
import com.myportfolio.web.domain.CommentDto;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {
    //    //주입 1. 인스턴스 변수에 주입하는 방법
//    : 여러 개를 주입 받아야 하는데, 애너테이션 누락 실수가 나올 수도 있음. -> 생성자 이용이 나은 이유
//    ex) @repository를 DAO 클래스에서 누락 -> 여기서 dao 주입 받을 때, @Autowired 가 없어도 에러 안 남
//    잘 받았구나 착각하기 쉬움 -> 생성자로 주입 -> 컴파일 시 문제 발견 가능
    BoardDao boardDao; // 댓글 작성 수정 삭제 -> boardDao에도 영향이 감
    CommentDao commentDao;

    //주입 2. 생성자 주입 : Autowired 없어도 됨. 자동으로 매개변수에 맞게 주입해줌
    //생성자가 하나밖에 없을 때만 가능함
//        @Autowired
    public CommentServiceImpl(CommentDao commentDao, BoardDao boardDao) {
        this.commentDao = commentDao;
        this.boardDao = boardDao;
    }

    @Override
    public int getCount(Integer bno) throws Exception{
        return commentDao.count(bno);
    }

    //댓글 삭제
    @Override
    @Transactional(rollbackFor =  Exception.class) //2가지 작업(update~, delete) -> transation
    //Exception과 그 자손들(compile time, checked) 예외 발생 -> rollback
    //기본적으로 runtime 에러들은 rollback을 함. 근데 컴파일(체크드) 에러는 하지 않음 -> 하도록
    public int remove(Integer cno, Integer bno, String commenter) throws  Exception{
        int rowCnt = boardDao.updateCommentCnt(bno, -1); //특정 게시물의 댓글 수를 -1 함
        System.out.println("updateCommentcnt - rowCnt = " + rowCnt);
//        throw new Exception("test"); // 일부러 컴파일 예외 발생 -> rollback 되는 지 확인하려고 : 댓글 수만 감소하고 실제 삭제는 안 함 -> 댓글도 그대로, 댓글 수도 그대로여야 함
        rowCnt = commentDao.delete(cno, commenter); //특정 댓글의 번호와 작성자 비교 후 삭제 함 (실질적인 댓클 삭제 단계)
        System.out.println("rowCnt = " + rowCnt);
        return rowCnt; //성공이면 1 반환
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int write(CommentDto commentDto) throws Exception{
        boardDao.updateCommentCnt(commentDto.getBno(), 1); //1번째 작업 : 댓글 수 증가
//            throw new Exception("test"); // 일부러 예외 발생 : 댓글 수만 증가 시키고 실제 댓글 삽입 작업은 안 함 -> 댓글도 없고, 댓글 수도 증가되지 않아야 함(rollback)
        return commentDao.insert(commentDto); //2번째 작업 : 실제 댓글 삽입
    }

    @Override
    public List<CommentDto> getList(Integer bno) throws Exception{
//        throw new Exception("test");
        return commentDao.selectAll(bno);
    }

    @Override
    public CommentDto read(Integer cno) throws Exception{
        return commentDao.select(cno);
    }

    @Override
    public int modify(CommentDto commentDto) throws Exception{
        return commentDao.update(commentDto);
    }

}
