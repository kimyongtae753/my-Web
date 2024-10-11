<%@page import="net.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>이메일 중복확인 결과</title>
</head>
<body>
    <div style="text-align: center">
        <h3>이메일 중복확인 결과</h3>
        
<% 	
    String email = request.getParameter("email").trim();
    
    // 이메일 형식 검증
  	String emailPattern = "^[A-Za-z0-9]+@[A-Za-z]+(\\.[A-Za-z]{2,})+$";
    if (!email.matches(emailPattern)) {
        out.println("<p style='color:red'>형식에 맞지 않습니다</p>");
    } else {
     
        int cnt = memberDao.duplecateEmail(email); // 메서드 이름 수정
        out.println("입력 이메일 : <strong>" + email + "</strong>");
        
        if(cnt == 0) {
            out.println("<p>사용 가능한 이메일 입니다</p>");
%>
            <!-- 사용 가능한 이메일을 부모창(opener)에 전달하기(memberForm.jsp)-->
            <a href="javascript:apply('<%=email%>')">[적용]</a>
            <script>
                function apply(email){
                    opener.document.memfrm.email.value = email;
                    window.close();
                }
            </script>		
<%			
        } else {
            out.println("<p style='color:red'>해당 이메일은 사용할 수 없습니다</p>");
        }
    }
%>	
        <hr>
        <a href="javascript:history.back()">[다시검색]</a>
        &nbsp;&nbsp;
        <a href="javascript:window.close()">[창닫기]</a>	
    </div>
</body>
</html>