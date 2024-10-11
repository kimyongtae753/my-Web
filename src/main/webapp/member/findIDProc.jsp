<%@ page language="java" contentType="text/html; charset=UTF-8"
   	pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>    
<%@ include file="../header.jsp" %>
<h3>아이디/비밀번호 찾기 결과</h3>

<% 
	
	String mname=request.getParameter("mname").trim();
	String email=request.getParameter("email").trim();
	
	memberDto.setMname(mname);
	memberDto.setEmail(email);
	
	boolean flag = memberDao.findID(memberDto);
	out.println("Name: " + mname);
	out.println("Email: " + email);
	if(flag == false){
		out.println("<p>이름과 이메일 확인</p>");
		out.println("<p><a href='javascript:history.back()'>재시도</p>");
	}else{
		 String message="";
		 message += "아이디와 임시 비밀번호가 이메일로 전송되었습니다\\n";
		 message += "임시 비밀번호는 로그인 후 수정하시기 바랍니다.";
		 out.println("<script>");
		 out.println("		alert('" + message + "');");
		 out.println("		location.href='loginForm.jsp'");
		 out.println("</script>");
		 
	}

%>


<%@ include file="../footer.jsp" %>