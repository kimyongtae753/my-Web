<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>
<!-- 본문  -->
<h3>포토 갤러리</h3>
<p><a href="pdsForm.jsp">[사진올리기]</a>

<%
	ArrayList<PdsDTO> list = pdsDao.list();
	if(list == null) {
		out.println("관련 자료 없음!!");
	}else{
		out.println("전체 글 갯수 : " + list.size());
	

%>
				<table class="table table-hover">
				<thead>
					<tr class = "success" >
						<th style="text-align: center">제목</th>
						<th style="text-align: center">사진</th>
						<th style="text-align: center">조회수</th>
						<th style="text-align: center">작성자</th>
						<th style="text-align: center">작성일</th>
					</tr>				
				</thead>
				<tbody>
				
				<%
					for(int i=0; i<list.size(); i++){
						pdsDto = list.get(i);
						
				%>
						<tr>
							<td><a href="pdsRead.jsp?pdsno=<%=pdsDto.getPdsno()%>"><%=pdsDto.getSubject() %></a></td>
							<td><a href="pdsRead.jsp?pdsno=<%=pdsDto.getPdsno()%>"><img src="../storage/<%=pdsDto.getFilename()%>" width="50" height="40"></a></td>
							<td><%=pdsDto.getReadcnt() %></td>
							<td><%=pdsDto.getWname() %></td>
							<td><%=pdsDto.getRegdate().substring(0, 10) %></td>
							
						</tr>
				
				<%
					}//for end
				%>
				
				</tbody>
				</table>
	
	


<%
	}//if end	
%>
<%@ include file="../footer.jsp" %>