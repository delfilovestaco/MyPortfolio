<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page import="java.net.URLDecoder"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
  <style>
    body{
      height: 100vh;
      width: 100vw;
      background-image: url('<c:url value="/images/abstract-blue-background-simple-design-for-your-website-free-vector.jpg"/>');
      background-repeat : no-repeat;
      background-size : cover;
    }
    * { box-sizing:border-box; }
    form {
      background-color: #fefefe;
      width:400px;
      height:600px;
      display : flex;
      flex-direction: column;
      align-items:center;
      position : absolute;
      top:50%;
      left:50%;
      transform: translate(-50%, -50%) ;
      border: 1px solid rgb(89,117,196);
      border-radius: 10px;
    }
    .input-field {
      width: 300px;
      height: 40px;
      border : 1px solid rgb(89,117,196);
      border-radius:5px;
      padding: 0 10px;
      margin-bottom: 10px;
    }
    #userid{
      width: 230px;
    }

    #btn-idCheck{
      background-color: rgb(89,117,196);
      color : white;
      width:60px;
      height:40px;
      font-size: 13px;
      line-height: 35px;
      text-align: center;
      border : none;
      border-radius: 5px;
      margin : 0 0 0 10px;
      float: right;
    }

    label {
      width:300px;
      height:30px;
      margin-top :4px;
    }
    button {
      background-color: rgb(89,117,196);
      color : white;
      width:300px;
      height:50px;
      font-size: 17px;
      border : none;
      border-radius: 5px;
      margin : 20px 0 30px 0;
    }

    .title {
      font-size : 50px;
      margin: 40px 0 30px 0;
    }
    .msg {
      height: 30px;
      text-align:center;
      font-size:16px;
      color:red;
      margin-bottom: 20px;
    }

    .sns-chk {
      margin-top : 5px;
    }
  </style>
  <title>Register</title>
</head>
<script>
  let msg = `${msg}`;
  if(msg=="reg_no") alert("입력하신 정보를 다시 한번 확인 후 시도해주세요.");
</script>
<body>
<form action="<c:url value="/register/add"/>" method="POST" onsubmit="return formCheck(this)">
<form:form modelAttribute="UserDto">
  <div class="title">Register</div>
  <div id="msg" class="msg"><form:errors path="id"/></div>
  <label for="">아이디</label>
  <div id="idarea">
    <input class="input-field" type="text" id="userid" name="id" placeholder="4~12자리 영소문자와 숫자 조합">
    <a href="#" class="btn" id="btn-idCheck">중복 확인</a>
    <input type="hidden" name="checked_id" value="">
  </div>
  <label for="">비밀번호</label>
  <input class="input-field" type="password" name="pwd" placeholder="8~12자리 영대소문자와 숫자 조합">
  <label for="">이름</label>
  <input class="input-field" type="text" name="name" placeholder="홍길동">
  <label for="">이메일</label>
  <input class="input-field" type="text" name="email" placeholder="example@fastcampus.co.kr">
  <label for="">생일</label>
  <input class="input-field" type="text" name="birth" placeholder="2020-12-31">
  <div class="sns-chk">
    <label><input type="checkbox" name="sns" value="facebook"/>페이스북</label>
    <label><input type="checkbox" name="sns" value="kakaotalk"/>카카오톡</label>
    <label><input type="checkbox" name="sns" value="instagram"/>인스타그램</label>
  </div>
  <button type="submit">회원 가입</button>
</form:form>
</form>

<script>
  // btnIdCheck = document.getElementById('btn-idCheck');
  // btnIdCheck.addEventListener('click', function() {
  //     // alert("hi");
  //   let userid = document.getElementById('userid').value;
  //   // alert(userid)
  //   if(userid.trim()==''){
  //     alert("아이디를 입력해주세요!");
  //     document.getElementById('userid').focus()
  //     return;
  //   }
    $(document).ready(function(){
      $("#btn-idCheck").click(function () {
        let userid = $("input[name=id]").val();
        let useridArr = [...userid];

        if(userid.trim()==''){
          alert("아이디를 입력해주세요!");
          $("input[name=id]").focus()
          return;
      }
        if(userid.trim().length < 4){
          alert("아이디는 4자 이상으로 입력해주세요!");
          $("input[name=id]").focus()
          return;
        }
        if(!useridArr.some(i => i < 'z')){
          alert("아이디는 영소문자를 포함해서 작성해주세요.");
          return;
        }
        if(!useridArr.some(i => i < 9)){
          alert("아이디는 숫자를 포함해서 작성해주세요.");
          return;
        }

        $.ajax({
          type: 'GET',
          url: '/web/register/checkId?userid=' + encodeURIComponent(userid),
          headers: {"content-type": "application/json"},
          success: function(response) {
            if (response === 'ID_OK') {
              alert("사용 가능한 아이디입니다.");
            } else {
              alert("중복된 아이디가 있습니다.");
            }
          },
          error: function() {
            alert("중복된 아이디가 있습니다.");
          }
        }); //ajax
      });

      $("#btn-idCheck").click(function() {
        $("input[name=checked_id]").val('y');
      });
});

  function formCheck(frm) {
    var msg ='';
    let userpwd = $("input[name=pwd]").val();
    let userpwdArr = [...userpwd];

    if($("input[name='checked_id']").val()==''){
      alert('아이디중복 확인을 해주세요.');
      $("input[name='checked_id']").eq(0).focus();
      return false;
    }

    if(frm.id.value.length < 1 || frm.pwd.value.length < 1 || frm.name.value.length < 1 || frm.email.value.length < 1 || frm.birth.value.length < 1){
      alert("모든 항목을 알맞게 작성해주세요!");
      return false;
    }
    if(frm.id.value.length < 4) {
      setMessage('id 길이는 4자 이상이어야 합니다.', frm.id);
      return false;
    }
    if(frm.pwd.value.length < 8){
      setMessage('pwd 길이는 8자 이상이어야 합니다.', frm.pwd);
      return false;
    }
    if(!userpwdArr.some(i => i < 9)) {
      setMessage('pwd는 숫자를 포함해서 작성해주세요.', frm.pwd);
      return false;
    }
    return true;
  }
  function setMessage(msg, element){
    document.getElementById("msg").innerHTML = `<i class="fa fa-exclamation-circle"> ${'${msg}'}</i>`;
    if(element) {
      element.select();
    }
  }
</script>
</body>
</html>