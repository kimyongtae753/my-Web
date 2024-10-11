<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>      
<%@ include file="../header.jsp" %>
<h3>*새글 쓰기*</h3>
<p><a href="bbsList.jsp">[글목록]</a><p>

<%
		int bbsno = Integer.parseInt(request.getParameter("bbsno"));
		bbsDto = bbsDao.read(bbsno);
		if(bbsDto==null){
			out.println("해당 글 없음!!");
		}else{
			
		
%>

	<form name="bbsfrm" id="bbsfrm" method="post" action="bbsUpdateProc.jsp" onsubmit="return bbsCheck()">
	<input type="hidden" name="bbsno" value="<%=request.getParameter("bbsno")%>"> 
	<table class="table">
	<tr>
		<th class="success">작성자</th>	
		<td><input type="text" name="wname" id="wname" value="<%=bbsDto.getWname()%>" maxlength="20" class="form-control" required ></td>
	</tr>
	<tr>
		<th class="success">제목</th>	
		<td><input type="text" name="subject" id="subject" value="<%=bbsDto.getSubject()%>" maxlength="100" class="form-control" required></td>
	</tr>
	<tr>
		<th class="success">내용</th>	
		<td><textarea name="content" id="content" rows="5" class="form-control" required><%=bbsDto.getContent()%></textarea></td>
	</tr>
	<tr>
		<th class="success">비밀번호</th>	
		<td><input type="password" name="passwd" id="passwd" maxlength="10" class="form-control" required></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="수정완료" class="btn btn-success">
			<input type="reset" value="취소" onclick="location.href='bbsList.jsp'" class="btn btn-danger">
		</td>
	
	
	</tr>
	
	</table>

</form>
<%
		}
%>


<%@ include file="../footer.jsp" %>