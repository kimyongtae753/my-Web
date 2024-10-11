<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>     
<%@ include file="../header.jsp" %>
<!-- 본문  -->
<!-- 글번호(pdsno)와 비밀번호 (passwd)가 일치하면 삭제  -->
<p><a href="pdsList.jsp">[글목록]</a>

<form method="post" action="pdsDelProc.jsp" onsubmit="return pwCheck2()">
	<input type="hidden" name="pdsno" value="<%=request.getParameter("pdsno")%>">
	<table class="table">
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