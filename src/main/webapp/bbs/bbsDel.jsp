<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>     
<%@ include file="../header.jsp" %>
<!-- 본문  -->
<!-- 글번호(bbsno)와 비밀번호 (passwd)가 일치하면 삭제  -->
<p><a href="bbsList.jsp">[글목록]</a>

<form method="post" action="bbsDelProc.jsp" onsubmit="return pwCheck()">
	<input type="hidden" name="bbsno" value="<%=request.getParameter("bbsno")%>">
	<table>
	<tr>
		<th class="success">비밀번호</th>
		<td><input type="password" name="passwd" id="passwd" maxlength="10" required></td>
	</tr>
	<tr>
		<td colspan="3">
			<input type="submit" value="삭제" class="btn btn-danger">
		</td>
	</tr>
	</table>

</form>





<%@ include file="../footer.jsp" %>