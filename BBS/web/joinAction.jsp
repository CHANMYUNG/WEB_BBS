<%--
  Created by IntelliJ IDEA.
  User: NooHeat
  Date: 09/06/2017
  Time: 10:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>


<!DOCTYPE HTML>
<html>
<head>
    <title>JSP 게시판 웹 사이트</title>
</head>
<body>
<%
    PrintWriter dd = response.getWriter();
    dd.println("<script>");
    dd.println("alert("+user.getUserID()+user.getUserPassword()+user.getUserName()+user.getUserGender()+user.getUserEmail()+")");
    dd.println("</script>");
    if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
            || user.getUserGender() == null || user.getUserEmail() == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('입력이 안된 값이 있습니다')");
        script.println("history.back()");
        script.println("</script>");
    }
    else {
        UserDAO userDAO = new UserDAO();
        int result = userDAO.join(user);

        // 유저가 이미 존재하는 경우
        if (result == -1) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('이미 존재하는 아이디입니다')");
            script.println("history.back()");
            script.println("</script>");
        }
        else{
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href = 'main.jsp'");
            script.println("</script>");
        }
    }
%>
</body>
</html>
