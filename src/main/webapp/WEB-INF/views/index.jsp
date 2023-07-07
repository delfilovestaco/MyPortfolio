<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page session="false"%>
<c:set var="loginId" value="${pageContext.request.getSession(false).getAttribute('id')==null ? '' : pageContext.request.session.getAttribute('id')}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId =='' ? 'Login' : 'Logout'}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>myportfolio</title>
    <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <style>
        .background {
            height: 100vh;
            width: 100vw;
            background-image: url('<c:url value="/images/abstract-blue-background-simple-design-for-your-website-free-vector.jpg"/>');
            background-repeat : no-repeat;
            background-size : cover;
        }
    </style>
</head>
<script>
    let msg = `${msg}`;
    if(msg=="reg_ok") alert("회원가입을 축하드립니다!");
</script>
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
<div class="background">
</div>
</body>
</html>