<%@page import="net.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		
		<div style="text-align: center">
			<h3> 아이디 중복확인 결과 </h3>
		
<% 	
		String id = request.getParameter("id").trim();
		int cnt = memberDao.duplecateID(id);
		out.println("입력ID : <strong>" + id + "</strong>");
		if(cnt==0){
			out.println("<p>사용 가능한 아이디 입니다</p>");
%>
		<!-- 사용 가능한 id를 부모창(opener)에 전달하기(memberForm.jsp)-->
		<a href="javascript:apply('<%=id%>')">[적용]</a>
		<script>
			function apply(id){
				opener.document.memfrm.id.value = id;
				window.close();
				
			}
		</script>		
<%			
		}else{
			out.println("<p style='color:red'>해당 아이디는 사용할 수 없습니다</p>");
			}
%>	
		<hr>
		<a href="javascript:history.back()">[다시검색]</a>
		&nbsp;&nbsp;
		<a href="javascript:window.close()">[창닫기]</a>	
		
		</div>


</body>
</html>