<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page session="true"%>
<c:set var="loginId" value="${sessionScope.id}"/>
<%--<c:set var="loginId" value="${pageContext.request.getSession(false).getAttribute('id')==null ? '' : pageContext.request.session.getAttribute('id')}"/>--%>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'Logout'}"/>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>myportfolio</title>
  <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://code.jquery.com/jquery-1.11.3.js" charset="utf-8"></script>
  <style>
    <%--body{--%>
    <%--  height: 100vh;--%>
    <%--  width: 100vw;--%>
    <%--  background-image: url('<c:url value="/images/abstract-blue-background-simple-design-for-your-website-free-vector.jpg"/>');--%>
    <%--  background-repeat : no-repeat;--%>
    <%--  background-size : cover;--%>
    <%--}--%>

    *{
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      font-family: "Noto Sans KR", sans-serif;
    }

    .container {
      width : 50%;
      margin : auto;
    }

    .writing-header {
      position: relative;
      margin: 20px 0 0 0;
      padding-bottom: 10px;
      border-bottom: 1px solid #323232;
    }

    input {
      width: 100%;
      height: 35px;
      margin: 5px 0px 10px 0px;
      border: 1px solid #e9e8e8;
      padding: 8px;
      background: #f8f8f8;
      outline-color: #e6e6e6;
    }

     .containerTxt {
      width: 100%;
      background: #f8f8f8;
      margin: 5px 0px 10px 0px;
      border: 1px solid #e9e8e8;
      resize: none;
      padding: 8px;
      outline-color: #e6e6e6;
    }

    .frm {
      width:100%;
    }
    .btn {
      font-size: 16px; /* Set a font size */
      background-color: rgb(236, 236, 236); /* Blue background */
      border: none; /* Remove borders */
      color: black; /* White text */
      padding: 6px 12px; /* Some padding */
      cursor: pointer; /* Mouse pointer on hover */
      border-radius: 5px;
      float: right;
    }

    .btn:hover {
      text-decoration: underline;
    }
    /*  ----------------------------- */

    /** {*/
    /*  border : 0;*/
    /*  padding : 0;*/
    /*}*/

    #commentList {
      border: 1px solid rgb(235,236,239);
      width : 100%;
      /*margin: auto;*/
      margin : 50px 0 20px 0;
    }

    #commentList > ul {
      /*border: 5px solid #009f47;*/

      border:  1px solid rgb(235,236,239);
      border-bottom : 0;
    }

    #commentList > ul > li {
      /*border: 5px solid #009f47;*/
      /*background-color: #f9f9fa;*/
      list-style-type: none;
      border-bottom : 1px solid rgb(235,236,239);
      padding : 18px 18px 0 18px;
    }

    .comment-content {
      /*border: 5px solid #009f47;*/

      overflow-wrap: break-word;
    }

    .comment-bottom {
      font-size:9pt;
      color : rgb(97,97,97);
      padding: 8px 0 8px 0;
    }

    .comment-bottom > a {
      color : rgb(97,97,97);
      text-decoration: none;
      margin : 0 6px 0 0;
    }

    .comment-area {
      padding : 0 0 0 46px;
    }

    .commenter {
      font-size:12pt;
      font-weight:bold;
    }

    .commenter-writebox {
      padding : 15px 20px 20px 20px;
    }

    .comment-img {
      font-size:36px;
      position: absolute;
    }

    .comment-item {
      position:relative;
    }

    .up_date {
      margin : 0 8px 0 0;
    }

    #comment-writebox {
      background-color: white;
      border : 1px solid #e5e5e5;
      border-radius: 5px;
    }

    #reply-writebox > .reply-writebox-content > textarea
    {
      display: block;
      width: 100%;
      min-height: 17px;
      padding: 0 20px;
      border: 0;
      outline: 0;
      font-size: 13px;
      resize: none;
      box-sizing: border-box;
      background: transparent;
      overflow-wrap: break-word;
      overflow-x: hidden;
      overflow-y: auto;
    }
    #comment-writebox > .comment-writebox-content > textarea
    {
      display: block;
      width: 100%;
      min-height: 17px;
      padding: 0 20px;
      border: 0;
      outline: 0;
      font-size: 13px;
      resize: none;
      box-sizing: border-box;
      background: transparent;
      overflow-wrap: break-word;
      overflow-x: hidden;
      overflow-y: auto;
    }
    #modify-writebox > .modify-writebox-content > textarea
    {
      display: block;
      width: 100%;
      min-height: 17px;
      padding: 0 20px;
      border: 0;
      outline: 0;
      font-size: 13px;
      resize: none;
      box-sizing: border-box;
      background: transparent;
      overflow-wrap: break-word;
      overflow-x: hidden;
      overflow-y: auto;
    }

    #comment-writebox-bottom {
      /*border: 5px solid #009f47;*/
      box-sizing: unset;
      padding : 3px 10px 10px 10px;
      min-height : 35px;
    }

    /*.btn*/
    /*{*/
    /*  font-size:10pt;*/
    /*  color : black;*/
    /*  background-color: #eff0f2;*/
    /*  text-decoration: none;*/
    /*  padding : 9px 10px 9px 10px;*/
    /*  border-radius: 5px;*/
    /*  float : right;*/
    /*}*/

    #btn-write-comment{
      color : #009f47;
      background-color: #e0f8eb;
    }
    #btn-write-reply
    {
      color : #009f47;
      background-color: #e0f8eb;
    }

    #btn-cancel-reply {
      background-color: #eff0f2;
      margin-right : 10px;
    }

    #btn-write-modify {
      color : #009f47;
      background-color: #e0f8eb;
    }

    #btn-cancel-modify {
      margin-right : 10px;
    }

    #reply-writebox {
      display : none;
      background-color: white;
      border : 1px solid #e5e5e5;
      border-radius: 5px;
      margin : 10px;
    }

    #reply-writebox-bottom {
      box-sizing: unset;
      padding : 3px 10px 10px 10px;
      min-height : 35px;
    }

    #modify-writebox {
      background-color: white;
      border : 1px solid #e5e5e5;
      border-radius: 5px;
      margin : 10px;
    }

    #modify-writebox-bottom {
      box-sizing: unset;
      padding : 3px 10px 10px 10px;
      min-height : 35px;
    }

    /* The Modal (background) */
    .modal {
      display: none; /* Hidden by default */
      position: fixed; /* Stay in place */
      z-index: 1; /* Sit on top */
      padding-top: 100px; /* Location of the box */
      left: 0;
      top: 0;
      width: 100%; /* Full width */
      height: 100%; /* Full height */
      overflow: auto; /* Enable scroll if needed */
      background-color: rgb(0,0,0); /* Fallback color */
      background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    }

    /* Modal Content */
    .modal-content {
      background-color: #fefefe;
      margin: auto;
      padding: 20px;
      border: 1px solid #888;
      width: 50%;
    }

    /* The Close Button */
    .close {
      color: #aaaaaa;
      float: right;
      font-size: 28px;
      font-weight: bold;
    }

    .close:hover,
    .close:focus {
      color: #000;
      text-decoration: none;
      cursor: pointer;
    }

    .paging {
      color: black;
      width: 100%;
      text-align: center;
    }

    .page {
      color: black;
      text-decoration: none;
      padding: 6px;
      margin-right: 10px;
    }

    .paging-active {
      background-color: rgb(216, 216, 216);
      border-radius: 5px;
      color: rgb(24, 24, 24);
    }

    .paging-container {
      width:100%;
      height: 70px;
      margin-top: 30px;
      /*margin : auto;*/
    }
  </style>
</head>
<%---------------------------------------------------------%>
<body>
<div id="menu">
  <ul>
    <li id="logo">myportfolio</li>
    <li><a href="<c:url value='/'/>">Home</a></li>
    <li><a href="<c:url value='/board/list'/>">Board</a></li>
    <li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
    <li><a href="<c:url value='/register/add'/>">Sign in</a></li>
    <li><a href=""><i class="fa fa-search"></i></a></li>
  </ul>
</div>

<script>
  let msg = `${msg}`;
  if(msg=="reg_ok") alert("게시물 등록에 실패하였습니다. 다시 시도해 주세요.");
  if(msg=="MOD_ERR") alert("게시물 수정에 실패하였습니다. 다시 시도해 주세요.");
</script>

<%--전체 컨테이너--%>
<div class="container">
  <h2 class="writing-header">게시판 ${mode=="new" ? "글쓰기" : "읽기"}</h2>
  <form id="form" class="frm" action="" method="post">
    <input type="hidden" name="bno" value="${boardDto.bno}">

    <input name="title" type="text" value="<c:out value='${boardDto.title}'/>" placeholder="  제목을 입력해 주세요." ${mode=="new" ? "" : "readonly='readonly'"}><br>
    <textarea class="containerTxt" name="content" rows="20" placeholder=" 내용을 입력해 주세요." ${mode=="new" ? "" : "readonly='readonly'"}><c:out value="${boardDto.content}"/></textarea><br>

    <c:if test="${mode eq 'new'}">
      <button type="button" id="writeBtn" class="btn btn-write"><i class="fa fa-pencil"></i> 등록</button>
    </c:if>
    <c:if test="${mode ne 'new'}">
      <button type="button" id="writeNewBtn" class="btn btn-write"><i class="fa fa-pencil"></i> 글쓰기</button>
    </c:if>
    <c:if test="${boardDto.writer eq loginId}">
      <button type="button" id="modifyBtn" class="btn btn-modify"><i class="fa fa-edit"></i> 수정</button>
      <button type="button" id="removeBtn" class="btn btn-remove"><i class="fa fa-trash"></i> 삭제</button>
    </c:if>
    <button type="button" id="listBtn" class="btn btn-list"><i class="fa fa-bars"></i> 목록</button>
  </form>

<%-- 댓글 보여주는 곳 --%>
  <c:if test="${mode ne 'new'}">
  <div id="commentList">
<%-- 댓글 리스트 --%>
<%--    <ul>--%>
<%--      <li class="comment-item" data-cno="1" data-bno="1070">--%>
<%--                <span class="comment-img">--%>
<%--                    <i class="fa fa-user-circle" aria-hidden="true"></i>--%>
<%--                </span>--%>
<%--        <div class="comment-area">--%>
<%--          <div class="commenter">asdf</div>--%>
<%--          <div class="comment-content">asdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdf--%>
<%--          </div>--%>
<%--          <div class="comment-bottom">--%>
<%--            <span class="up_date">2022.01.01 23:59:59</span>--%>
<%--            <a href="#" class="btn-write"  data-cno="1" data-bno="1070" data-pcno="">답글쓰기</a>--%>
<%--            <a href="#" class="btn-modify" data-cno="1" data-bno="1070" data-pcno="">수정</a>--%>
<%--            <a href="#" class="btn-delete" data-cno="1" data-bno="1070" data-pcno="">삭제</a>--%>
<%--          </div>--%>
<%--        </div>--%>
<%--      </li>--%>
<%--    </ul>--%>
  </div>
<%-- commentList 끝 --%>

<%-- 페이징 처리 --%>
<%--    <div class="paging-container">--%>
<%--      <div class="paging">--%>
<%--        <a class="page" href="#">&lt;</a>--%>
<%--        <a class="page" href="#">1</a>--%>
<%--        <a class="page" href="#">2</a>--%>
<%--        <a class="page" href="#">3</a>--%>
<%--        <a class="page" href="#">4</a>--%>
<%--        <a class="page paging-active" href="#">5</a>--%>
<%--        <a class="page" href="#">6</a>--%>
<%--        <a class="page" href="#">7</a>--%>
<%--        <a class="page" href="#">8</a>--%>
<%--        <a class="page" href="#">9</a>--%>
<%--        <a class="page" href="#">10</a>--%>
<%--        <a class="page" href="#">&gt;</a>--%>
<%--      </div>--%>
<%--    </div>--%>
<%-- 페이징 처리 끝 --%>
<%--  댓글 쓰는 곳  --%>
    <div id="comment-writebox">
      <div class="commenter commenter-writebox">${id}</div>
      <div class="comment-writebox-content">
        <textarea name="wrt_comment" id="wrt_comment" cols="30" rows="3" placeholder="댓글을 남겨보세요"></textarea>
      </div>
      <div id="comment-writebox-bottom">
        <div class="register-box">
          <a href="#" class="btn" id="btn-write-comment">등록</a>
        </div>
      </div>
    </div>
<%--  댓글 쓰는 곳 끝  --%>
<%--  </div>--%>

<%-- 답글 창 --%>
  <div id="reply-writebox">
    <div class="commenter commenter-writebox">${id}</div>
    <div class="reply-writebox-content">
      <textarea name="reply_comment" id="reply_comment" cols="30" rows="3" placeholder="댓글을 남겨보세요"></textarea>
    </div>
    <div id="reply-writebox-bottom">
      <div class="register-box">
        <a href="#" class="btn" id="btn-write-reply">등록</a>
        <a href="#" class="btn" id="btn-cancel-reply">취소</a>
      </div>
    </div>
  </div>

<%-- 댓글 수정 창 --%>
  <div id="modalWin" class="modal">
    <!-- Modal content -->
    <div class="modal-content">
      <span class="close">&times;</span>
      <p>
      <h2> | 댓글 수정</h2>
      <div id="modify-writebox">
        <div class="commenter commenter-writebox"></div>
        <div class="modify-writebox-content">
          <textarea name="mod_comment" id="mod_comment" cols="30" rows="5" placeholder="댓글을 남겨보세요"></textarea>
        </div>
        <div id="modify-writebox-bottom">
          <div class="register-box">
            <a href="#" class="btn" id="btn-write-modify">등록</a>
          </div>
        </div>
      </div>
      </p>
    </div>
  </div>
  </c:if>
<%--  ---------------------------%>
</div>

<script>
  $(document).ready(function(){
    let formCheck = function() {
      let form = document.getElementById("form");
      if(form.title.value=="") {
        alert("제목을 입력해 주세요.");
        form.title.focus();
        return false;
      }

      if(form.content.value=="") {
        alert("내용을 입력해 주세요.");
        form.content.focus();
        return false;
      }
      return true;
    }

    $("#writeNewBtn").on("click", function(){
      location.href="<c:url value='/board/write'/>";
    });

    $("#writeBtn").on("click", function(){
      let form = $("#form");
      form.attr("action", "<c:url value='/board/write'/>");
      form.attr("method", "post");

      if(formCheck())
        form.submit();
    });

    $("#modifyBtn").on("click", function(){
      let form = $("#form");
      let isReadonly = $("input[name=title]").attr('readonly');

      // 1. 읽기 상태이면, 수정 상태로 변경
      if(isReadonly=='readonly') {
        $(".writing-header").html("게시판 수정");
        $("input[name=title]").attr('readonly', false);
        $("textarea").attr('readonly', false);
        $("#modifyBtn").html("<i class='fa fa-pencil'></i> 등록");
        return;
      }

      // 2. 수정 상태이면, 수정된 내용을 서버로 전송
      form.attr("action", "<c:url value='/board/modify${searchCondition.queryString}'/>");
      form.attr("method", "post");
      if(formCheck())
        form.submit();
    });

    $("#removeBtn").on("click", function(){
      // div comment list -> ul 내에 li가 하나라도 있다면, 삭제 불가
      let liTags = document.querySelectorAll('li.comment-item');
      if(liTags.length > 0){
        alert("댓글이 작성된 글은 삭제할 수 없습니다.")
      }
      else{
        if(!confirm("정말로 삭제하시겠습니까?")) return;

        let form = $("#form");
        form.attr("action", "<c:url value='/board/remove${searchCondition.queryString}'/>");
        form.attr("method", "post");
        form.submit();
      }
    });

    $("#listBtn").on("click", function(){
      location.href="<c:url value='/board/list${searchCondition.queryString}'/>";
    });
  });
</script>
<%-----------------------------댓글-------------------------------------%>
<script>
  let id = '${id}';
  let bno = '${boardDto.bno}';

  let addZero = function(value=1){
    return value > 9 ? value : "0"+value;
  }

  let dateToString = function(ms=0) {
    let date = new Date(ms);

    let yyyy = date.getFullYear();
    let mm = addZero(date.getMonth() + 1);
    let dd = addZero(date.getDate());

    let HH = addZero(date.getHours());
    let MM = addZero(date.getMinutes());
    let ss = addZero(date.getSeconds());

    return yyyy+"."+mm+"."+dd+ " " + HH + ":" + MM + ":" + ss;
  }
  // ------------------------------------------------------------

  //1. 댓글 목록을 가져와서 보여주는 함수
  let showList = function(bno) {
    $.ajax({
      type:'GET',       // 요청 메서드
      url: '/web/comments?bno='+bno,  // 요청 URI
      success : function(result){
        $("#commentList").html(toHtml(result))// 서버로부터 응답이 도착하면 호출될 함수
      },
      error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
    }); // $.ajax()
  }

  //2. close 버튼 클릭시
  $(".close").click(function(){
    $("#modalWin").css("display","none");
  });

  //3. 페이지가 로딩 되면 실행 될 함수
  $(document).ready(function(){
    //3-0. 일단 리스트 보여줌
    showList(bno);

    //3-1. send 버튼 클릭 시 : 작성 함수
    $("#btn-write-comment").click(function(){
      let comment = $("textarea[name=wrt_comment]").val();

      if(comment.trim()==''){
        alert("댓글을 입력해주세요!");
        $("textarea[name=wrt_comment]").focus()
        return;
      }

      $.ajax({
        type:'POST',       // 요청 메서드
        url: '/web/comments?bno='+bno,  // 요청 URI  //web/comments?bno=1085 POST
        headers : { "content-type": "application/json"}, // 요청 헤더
        data : JSON.stringify({bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
        success : function(result){
          alert(result)
          showList(bno);
        },
        error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
      }); // $.ajax()
      // alert("the request is sent")

      $("textarea[name=wrt_comment]").val(''); //대댓글 쓴 창 비워주고
    });

    // ---------------수정-----------------------

    // //3-2. 특정 게시글의 수정 버튼 클릭 시 : 수정 함수
    // $("#commentList").on("click", ".btn-modify", function(){
    //   let cno = $(this).parent().attr("data-cno");
    //   let comment = $("div.comment-content", $(this).parent()).text();
    //
    //   //1. comment의 내용을 input에 뿌려주기
    //   $("textarea[name=mod_comment]").val(comment)
    //   //2. cno 전달하기
    //   $("#mod_comment").attr("data-cno", cno); //속성 추가하기 (맨 위의 수정버튼에, 댓글에 달린 수정 버튼 아님)
    //   //=> controller 로 두가지 정보를 전달
    // });
    $("#commentList").on("click", ".btn-modify", function(e){
      let target = e.target;
      let cno = target.getAttribute("data-cno");
      let bno = target.getAttribute("data-bno");
      let pcno = target.getAttribute("data-pcno");
      let li = $("li[data-cno="+cno+"]");
      let commenter = $(".commenter", li).first().text();
      let comment = $(".comment-content", li).first().text();

      $("#modalWin .commenter").text(commenter);
      $("#modalWin textarea").text(comment);
      $("#btn-write-modify").attr("data-cno", cno);
      $("#btn-write-modify").attr("data-pcno", pcno);
      $("#btn-write-modify").attr("data-bno", bno);

      // 팝업창을 열고 내용을 보여준다.
      $("#modalWin").css("display","block");
    });

    //3-3. 수정 버튼 클릭 시 : 수정되는 함수
    $("#btn-write-modify").click(function(){
      let comment = $("textarea[name=mod_comment]").val();
      let cno = $(this).attr("data-cno");

      if(comment.trim()==''){
        alert("댓글을 입력해주세요!");
        $("textarea[name=mod_comment]").focus()
        return;
      }

      $.ajax({
        type:'PATCH',       // 요청 메서드
        url: '/web/comments/'+cno,  // 요청 URI  //ch4/comment/70 PATCH
        headers : { "content-type": "application/json"}, // 요청 헤더
        data : JSON.stringify({cno:cno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
        success : function(result){
          alert(result)
          showList(bno);
        },
        error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
      }); // $.ajax()
      // alert("the request is sent")
      $(".close").trigger("click");
    });

    // --------------------답글-----------------------

    //3-4. 특정 게시글의 답글 버튼 클릭 시 : 답글 창
    // $("#commentList").on("click", ".btn-write", function(){
      // //1. replyForm의 위치를 해당 댓글 아래로 옮기고
      // $("#reply-writebox").appendTo($(this).parent())
      // //ㄴ> replayForm 이라는 아이디 가진 것 찾아서 -> 붙이는데
      // //ㄴ> this:이 버튼의 -> parent : 부모인, li태그 뒤에
      //
      // //2. replyForm을 보여줌
      // $("#reply-writebox").css("display", "block");
    // });
    // --------------답글 쓰기 클릭
    // $("a.btn-write").click(function(e){
      $("#commentList").on("click", ".btn-write", function(e){
      let target = e.target;
      let cno = target.getAttribute("data-cno")
      let bno = target.getAttribute("data-bno")

      let repForm = $("#reply-writebox");
      repForm.appendTo($("li[data-cno="+cno+"]"));
      repForm.css("display", "block");
      repForm.attr("data-pcno", pcno);
      repForm.attr("data-bno",  bno);
    });
    //--------------답글 취소
    $("#btn-cancel-reply").click(function(e){
      $("#reply-writebox").css("display", "none");
    });

    //3-5. 답글 작성 후 -> 답글 버튼 누르면 -> 대댓글로 작성되도록하는 함수
    $("#btn-write-reply").click(function(){
      let comment = $("textarea[name=reply_comment]").val();
      let pcno = $("#reply-writebox").parent().attr("data-cno");

      if(comment.trim()==''){
        alert("댓글을 입력해주세요!");
        $("textarea[name=reply_comment]").focus()
        return;
      }

      $.ajax({
        type:'POST',       // 요청 메서드
        url: '/web/comments?bno='+bno,  // 요청 URI  //ch4/comments?bno=1085 POST
        headers : { "content-type": "application/json"}, // 요청 헤더
        data : JSON.stringify({pcno:pcno, bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
        success : function(result){
          alert(result)
          showList(bno);
        },
        error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
      }); // $.ajax()
      // alert("the request is sent")

      //대댓글 작업 다 한 후 뒷처리 작업
      $("#reply-writebox").css("display", "none"); //replyform 다시 안보이게
      $("#reply-writebox").appendTo("body"); //replyForm 자리 다시 돌려놓고
      $("textarea[name=reply_comment]").val(''); //대댓글 쓴 창 비워주고
    });

    // ---------------삭제----------------------------

    //3-5. 특정 게시물의 삭제 버튼 클릭 시 : 삭제 함수
    //삭제 함수 1. 페이지 로딩 직후에는 삭제 버튼이 없음 -> 아래와 같이 작성 -> 작동 안 함
    // $(".delBtn").click(function(){
    //   alert("del button clicked")
    // });

    //4 삭제 함수. 이벤트를 고정된 요소에 걸기 -> commentList에
    //commentList 안에 있는 btn-delete 클래스에다가(on) 이벤트를 거는 것
    $("#commentList").on("click", ".btn-delete", function(){
      // let cno = $(this).parent().attr("data-cno");
      // let bno = $(this).parent().attr("data-bno");
      let cno = $(this).attr("data-cno");
      let bno = $(this).attr("data-bno");
      let pcno = $(this).attr("data-pcno");
      // alert("cno = " + cno + "pcno = " + pcno)

      // 해당 댓글의 cno를 pcno로 가진 요소가 있는 지 확인
      //리스트를 하나씩 돌면서, 해당 list의 pcno값이 cno값과 같다면
      //삭제 불가 하다는 창 알리고 -> return
      let isPcno = document.querySelectorAll('li.comment-item[data-pcno="' + cno + '"]');

      if (isPcno.length > 1) {
        //1. 답글이 있는 경우 혹은 댓글 자기 자신
          alert("답글이 작성된 댓글은 삭제할 수 없습니다.")
          return;
      }else {
        //2. 답글이 없는 경우
        if(!confirm("정말로 삭제하시겠습니까?")) return;

        $.ajax({
          type:'DELETE',       // 요청 메서드
          url: '/web/comments/'+cno+'?bno='+bno,  // 요청 URI
          success : function(result){
            alert(result)
            //삭제 후에 새로운 목록 가져오기
            showList(bno);
          },
          error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
        }); // $.ajax()
        // alert("del button clicked")
      }
    });

  });

  //5. html 문자열로 만들어 주는 함수
  let toHtml = function (comments){
    let tmp = '<ul>';
    comments.forEach(function (comment) {
      tmp += '<li class="comment-item" data-cno='+comment.cno
      tmp += ' data-pcno='+comment.pcno
      tmp += ' data-bno='+comment.bno
      if(comment.cno != comment.pcno){
        tmp += ' style="margin-left:20px"'
      }
      tmp += '>'
      tmp += '<span class="comment-img">'
      tmp += '<i class="fa fa-user-circle" aria-hidden="true"></i>'
      tmp += '</span>'
      tmp += '<div class="comment-area">'
      tmp += '<div class="commenter">'+comment.commenter+'</div>'
      tmp += '<div class="comment-content">'+comment.comment+'</div>'
      tmp += '<div class ="comment-bottom">'
      tmp += '<span class="up_date">'+dateToString(comment.up_date)+'</span>'
      if(comment.cno == comment.pcno) {
        tmp += '<a href="#" class="btn-write" data-cno=' + comment.cno
        tmp += ' data-bno=' + comment.bno
        tmp += ' data-pcno=' + comment.pcno
        tmp += '>답글쓰기</a>'
      }
      if(comment.commenter == "${loginId}"){
        tmp += '<a href="#" class="btn-modify" data-cno='+comment.cno
        tmp += ' data-bno='+comment.bno
        tmp += ' data-pcno='+comment.pcno
        tmp += '>수정</a>'
        tmp += '<a href="#" class="btn-delete" data-cno='+comment.cno
        tmp += ' data-bno='+comment.bno
        tmp += ' data-pcno='+comment.pcno
        tmp += '>삭제</a>'
      }
      tmp += '</div>'
      tmp += '</div>'
      tmp += '</li>'
    })
    return tmp + '</ul>';
  }
</script>

</body>
</html>