<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %> 
<%@ include file="../header.jsp" %>
<!-- 본문  -->
<%
	int pdsno=Integer.parseInt(request.getParameter("pdsno"));
	String passwd = request.getParameter("passwd").trim();
	String saveDir = application.getRealPath("/storage");//첨부된 파일을 삭제하기 위해서(파일이 저장된 실제 물리적인 경로)
	
	
	int cnt = pdsDao.delete(pdsno, passwd, saveDir); 
	if(cnt==0){
    	out.println("<p>비밀번호가 일치하지 않습니다!!</p>");
    	out.println("<p><a href='javascript:history.back()'>[다시시도]</a></p>");
    }else{
    	out.println("<script>");
    	out.println("    alert('게시글이 삭제되었습니다');");
    	out.println("    location.href='pdsList.jsp';"); //목록 페이지 이동
    	out.println("</script>");
    }
%>

<%@ include file="../footer.jsp" %>