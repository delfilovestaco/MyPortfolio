package com.myportfolio.web.controller;

import com.myportfolio.web.domain.CommentDto;
import com.myportfolio.web.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

//@Controller
//@ResponseBody //모든 메서드에 @ResponseBody 붙는다면 -> 클래스에 붙여도 됨
@RestController //위 두개와 동일
public class CommentController {
    @Autowired
    CommentService service;

//    {
//        "pcno" : 0,
//            "comment" : "hi"
//    }

//    {
//        "pcno" : 0,
//            "comment" : "hiiiiibybybybybye",
//            "commenter" : "asdf"
//    }

    //댓글을 수정하는 메서드
    @PatchMapping("/comments/{cno}") //PATCH /comments/1 <- 수정할 댓글 대상
//    @ResponseBody
    public ResponseEntity<String> modify(@PathVariable Integer cno, @RequestBody CommentDto dto, HttpSession session){
          String commenter = (String)session.getAttribute("id");
//        String commenter = "asdf";
        dto.setCommenter(commenter); //현재 접속자 id 정보를 가져와서 dto에 세팅
        dto.setCno(cno);
        System.out.println("dto = " + dto); //수정할 데이터 콘솔에 출력

        try {
            if(service.modify(dto) != 1){
                throw new Exception("Modify Failed");
            }
            return new ResponseEntity<String>("MOD_OK", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("MOD_ERR", HttpStatus.BAD_REQUEST);
        }
    }

    //댓글을 저장하는 메서드
    @PostMapping("/comments") //web/comments?bno=1085 POST
//    @ResponseBody
    public ResponseEntity<String> write(@RequestBody CommentDto dto, Integer bno, HttpSession session){
        String commenter = (String)session.getAttribute("id");
//        String commenter = "asdf";
        dto.setCommenter(commenter); //현재 접속자 id 정보를 가져와서 dto에 세팅
        dto.setBno(bno);
        System.out.println("dto = " + dto);
        //bno는 매개변수로, cno는 AI, comment는 요청시, commenter는 session에서

        try {
            if(service.write(dto) != 1){ //결과 값이 1이면 성공 -> 아니면 실패 -> 예외 던짐
                throw new Exception("Write Failed");
            }
            return new ResponseEntity<String>("WRT_OK", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("WRT_ERR", HttpStatus.BAD_REQUEST);
        }
    }

    //지정된 댓글을 삭제하는 메서드
    @DeleteMapping("/comments/{cno}") // DELETE /comments/1 <- 삭제할 댓글 번호 그 뒤에 ?bno=1080이 붙음 이게 쿼리스트링
    //{cno}는 쿼리스트링 값이 아님, URI의 일부임 -> 해당 값을 받는 매개변수에 @PathVariable 붙임
//    @ResponseBody
    public ResponseEntity<String> remove(@PathVariable Integer cno, Integer bno, HttpSession session){
        String commenter = (String)session.getAttribute("id"); //getAttribute가 반환 하는 것 Object -> 형변환 필요
//        String commenter = "asdf"; //Test 하고자 하드코딩 한 것
        try {
            int rowCnt = service.remove(cno, bno, commenter);

            if(rowCnt != 1){ //성공 시 1 반환 -> 아니면 실패라는 뜻
                throw new Exception(("Delete Failed"));
            }
            return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("DEL_ERR", HttpStatus.BAD_REQUEST);
        }
    }

    //지정된 게시물의 모든 댓글을 가져오는 메서드
    @GetMapping ("/comments") //comments?bno=1080 GET
//    @ResponseBody
    public ResponseEntity<List<CommentDto>> list(Integer bno){ //게시물 번호를 주면 -> 게시물에 달린 댓글 목록 가져오는 메서드
        List<CommentDto> list = null;
        try {
            list = service.getList(bno);
            System.out.println("list = " + list);
            return new ResponseEntity<List<CommentDto>>(list, HttpStatus.OK); //200
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<List<CommentDto>>(HttpStatus.BAD_REQUEST); //400
        }
//        return list; //뷰를 찾을 수 없다고 나옴. -> @ResponseBody 붙여줘야 뷰라고 인식 안 함
    }
}
