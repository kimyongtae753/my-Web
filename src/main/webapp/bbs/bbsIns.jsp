<%@page import="java.awt.Container"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>   
<%@ include file="../header.jsp" %>
<% 
	//사용자가 입력 요청한 정보를 가져오기
	String wname 	=request.getParameter("wname").trim();
	String subject 	=request.getParameter("subject").trim();
	String content 	=request.getParameter("content").trim();
	String passwd 	=request.getParameter("passwd").trim();
	String ip 	=request.getRemoteAddr().trim();
	
	
	//bbsDto 객체 담기
	bbsDto.setWname(wname);
	bbsDto.setSubject(subject);
	bbsDto.setContent(content);
	bbsDto.setPasswd(passwd);
	bbsDto.setIp(ip);
	
	int cnt = bbsDao.create(bbsDto);
    if(cnt==0){
    	out.println("<p>글 추가 실패했습니다!!</p>");
    	out.println("<p><a href='javascript:history.back()'>[다시시도]</a></p>");
    }else{
    	out.println("<script>");
    	out.println("    alert('게시글이 추가되었습니다');");
    	out.println("    location.href='bbsList.jsp';"); //목록 페이지 이동
    	out.println("</script>");
    }//if end
%>
<%@ include file="../footer.jsp" %>