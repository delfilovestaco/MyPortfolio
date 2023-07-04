package com.myportfolio.web.service;

import com.myportfolio.web.domain.CommentDto;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface CommentService {
    int getCount(Integer bno) throws Exception;

    //댓글 삭제
    @Transactional(rollbackFor = Exception.class)
    //2가지 작업(update~, delete) -> transation
    //Exception과 그 자손들(compile time, checked) 예외 발생 -> rollback
    //기본적으로 runtime 에러들은 rollback을 함. 근데 컴파일(체크드) 에러는 하지 않음 -> 하도록
    int remove(Integer cno, Integer bno, String commenter) throws Exception;

    @Transactional(rollbackFor = Exception.class)
    int write(CommentDto commentDto) throws Exception;

    List<CommentDto> getList(Integer bno) throws Exception;

    CommentDto read(Integer cno) throws Exception;

    int modify(CommentDto commentDto) throws Exception;
}
