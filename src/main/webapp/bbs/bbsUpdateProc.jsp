<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %> 
<%@ include file="../header.jsp" %>
<!-- 본문  -->
<p>
	<a href="bbsForm.jsp">"글쓰기"</a>
	&nbsp;&nbsp;
	<a href="bbsList.jsp">"글목록"</a>
</p>
<%
	// 수정 요청한 정보 가져오기
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	String passwd = request.getParameter("passwd").trim();
	String wname = request.getParameter("wname").trim(); // 작성자 이름 가져오기
	String subject = request.getParameter("subject").trim(); // 제목 가져오기
	String content = request.getParameter("content").trim(); // 내용 가져오기
	
	// DTO 객체에 담기
	bbsDto = new BbsDTO();
	bbsDto.setBbsno(bbsno);
	bbsDto.setPasswd(passwd);
	bbsDto.setWname(wname); // 작성자 이름 설정
	bbsDto.setSubject(subject); // 제목 설정
	bbsDto.setContent(content); // 내용 설정
	
	// DAO에서 실행하기
	int cnt = bbsDao.updateproc(bbsDto);
	if (cnt == 0) {
    	out.println("<p>비밀번호가 일치하지 않거나 필수 정보가 비어 있습니다!!</p>");
    	out.println("<p><a href='javascript:history.back()'>[다시시도]</a></p>");
    } else {
    	out.println("<script>");
    	out.println("    alert('게시글이 수정되었습니다'); ");
    	out.println("    location.href='bbsList.jsp'; "); // 목록 페이지 이동
    	out.println("</script>");
    }
%>

<%@ include file="../footer.jsp" %>