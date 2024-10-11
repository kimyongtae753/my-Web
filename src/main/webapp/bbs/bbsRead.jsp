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
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	bbsDto = bbsDao.read(bbsno);
	if(bbsDto==null){
		out.println("해당 글 없음");
	}else{
		bbsDao.incrementCnt(bbsno);//조회수 증기
%>
	<table class="table">
	<tr>
		<th class="success">제목</th>
		<td><%=bbsDto.getSubject()%></td>
	</tr>
	<tr>
		<th class="success">내용</th>
		<td>
		<% 

		String content = bbsDto.getContent();
		content = Utility.convertChar(content);
		out.print(content);
%>				
		</td>
	</tr>
	<tr>
		<th class="success">조회수</th>
		<td><%=bbsDto.getReadcnt()%></td>
	</tr>
	<tr>
		<th class="success">작성자</th>
		<td><%=bbsDto.getWname()%></td>
	</tr>
	<tr>
		<th class="success">작성일</th>
		<td><%=bbsDto.getRegdt()%></td>
	</tr>
	<tr>
		<th class="success">IP</th>
		<td><%=bbsDto.getIp()%></td>
	</tr>
	
	
	</table>
	<br>
	<input type="button" value="답변쓰기" class="btn btn-info" onclick="location.href='bbsReply.jsp?bbsno=<%=bbsno%>'">
	<input type="button" value="수정" class="btn btn-info" onclick="location.href='bbsUpdate.jsp?bbsno=<%=bbsno%>'">
	<input type="button" value="삭제" class="btn btn-info" onclick="location.href='bbsDel.jsp?bbsno=<%=bbsno%>'">

<%		
	}
%>




<%@ include file="../footer.jsp" %>