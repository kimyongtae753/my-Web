
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>    
<%@ include file="../header.jsp" %>
<h3>*글목록*</h3>
<p><a href="bbsForm.jsp">[글쓰기]</a><p>

<table class="table table-hover">
<thead>
	<tr class="success">
		<th style="text-align: center">제목</th>
		<th style="text-align: center">조회수</th>
		<th style="text-align: center">작성자</th>
		<th style="text-align: center">작성일</th>
	</tr>
</thead>
<tbody>
<%
	ArrayList<BbsDTO> list = bbsDao.list();
	if(list==null){
		out.println("<tr>");
		out.println("	<td colspan='4'>");
		out.println("		<strong>관련 자료 없음</strong>");
		out.println("	</td>");
		out.println("</tr>");
	}else{
		//오늘 날짜를 문자열 "2024-09-26"으로 만들기
		String today = Utility.getDate();
		
		for(int i=0; i<list.size(); i++) {
			bbsDto = list.get(i);
%>

			<tr>
			
				<td style="text-align: center;">
<% 		
			//답변 이미지
			for(int n = 0; n<bbsDto.getIndent(); n++){
				out.println("<img src='../images/reply.gif'>");
			}
			
%>				
				<a style="color: <%= bbsDto.getIndent() >= 1 ? "green" : "black" %>;" href="bbsRead.jsp?bbsno=<%=bbsDto.getBbsno()%>"><%=bbsDto.getSubject()%></a>
<% 
			String regdt = bbsDto.getRegdt().substring(0, 10);
			if(regdt.equals(today)){
				out.println("<img src='../images/new.gif'>");
			}
			//조회수 10 이상이면 hot
			if(bbsDto.getReadcnt()>=20){
				out.println("<img src='../images/hot.gif'>");
			}
			
			
			
%>
			
			
			</td>
			<td><%=bbsDto.getReadcnt()%></td>
			<td><%=bbsDto.getWname()%></td>
			<td><%=bbsDto.getRegdt().substring(0, 10)%></td>
			</tr>
<% 
		}
		
		//글 갯수
		int totalRecord = bbsDao.count();
		out.println("<tr>");
		out.println("	<td colspan='4' style='text-align:center;'>");
		out.println("		글갯수:<strong>" + totalRecord + "</strong>");
		out.println("	</td>");
		out.println("</tr>");
		
	}
%>

</tbody>
</table>

<%@ include file="../footer.jsp" %>