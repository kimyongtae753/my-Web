<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>
<%@ include file="../member/auth.jsp" %>    
<%@ include file="../header.jsp" %>
<!-- 본문  -->
<h3>갤러리 보기</h3>
<p><a href="pdsForm.jsp" >[사진올리기]</a><a href="pdsList.jsp">[갤러리]</a></p>

<%

	int pdsno = Integer.parseInt(request.getParameter("pdsno"));
	pdsDto = pdsDao.read(pdsno); 
	if(pdsDto==null){
	out.println("해당 글 없음");
	}else{
		pdsDao.incrementCnt(pdsno);//조회수 증기 
%>
	<table class="table">

	<tr>
		<th class="success">글제목</th>
		<td><%=pdsDto.getSubject()%></td>
	</tr>
	<tr>
		<th class="success">사진</th>
		<td><img src="../storage/<%=pdsDto.getFilename()%>"></td>
	</tr>
	<tr>
		<th class="success">파일크기</th>
		<td><%=pdsDto.getFilesize()%></td>
	</tr>
	<tr>
		<th class="success">작성자</th>
		<td><%=pdsDto.getWname()%></td>
	</tr>
	<tr>
		<th class="success">작성일</th>
		<td><%=pdsDto.getRegdate()%></td>    
	</tr> 
	<tr>
		<th class="success">조회수</th>
		<td><%=pdsDto.getReadcnt()%></td>  
	</tr>  
	
	
	</table>
	<hr>
	
<% 
		if(s_mlevel.equals("A1")){
%>			
			<input type="button" value="삭제" class="btn btn-info" onclick="location.href='pdsDel.jsp?pdsno=<%=pdsno%>'">	

<%
		}
%>	
	<input type="button" value="답변쓰기" class="btn btn-info" onclick="location.href='pdsReply.jsp?pdsno=<%=pdsno%>'">
	<input type="button" value="수정" class="btn btn-info" onclick="location.href='pdsUpdate.jsp?pdsno=<%=pdsno%>'">
	

<%		
	}
%>


<%@ include file="../footer.jsp" %>