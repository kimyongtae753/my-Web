<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*, javax.sql.*" %>
<%@ include file="auth.jsp" %>
<%@ include file="../header.jsp" %>

<%-- <%
    String message = "";
    String id = "";
    
    // 데이터베이스 연결 설정
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        // JDBC 드라이버 로드
        Class.forName("com.mysql.cj.jdbc.Driver");
        // 데이터베이스 연결
        String dbURL = "jdbc:mysql://localhost:3306/yourDatabaseName"; // 데이터베이스 URL
        String dbUser = "yourUsername"; // 사용자명
        String dbPass = "yourPassword"; // 비밀번호
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
        
        // 이름과 이메일 입력 처리
        String mname = request.getParameter("mname");
        String email = request.getParameter("email");
        
        if (mname != null && email != null) {
            // 1. ID 찾기
            String sql = "SELECT id FROM member WHERE mname=? AND email=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, mname);
            pstmt.setString(2, email);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                id = rs.getString("id");
                message = "찾은 ID: " + id;
            } else {
                message = "일치하는 정보가 없습니다.";
            }
        }

        // 임시 비밀번호 설정
        String tempPassword = "temp1234"; // 임시 비밀번호 (임의로 설정, 실제로는 랜덤 생성 추천)
        if (!id.isEmpty()) {
            String updateSql = "UPDATE member SET passwd=? WHERE mname=? AND email=?";
            pstmt = conn.prepareStatement(updateSql);
            pstmt.setString(1, tempPassword);
            pstmt.setString(2, mname);
            pstmt.setString(3, email);
            int rowsUpdated = pstmt.executeUpdate();
            
            if (rowsUpdated > 0) {
                message += "<br>임시 비밀번호가 설정되었습니다: " + tempPassword;
            } else {
                message += "<br>비밀번호 설정에 실패했습니다.";
            }
        }
    } catch (Exception e) {
        message = "오류 발생: " + e.getMessage();
    } finally {
        // 자원 해제
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>

<div class="container">
    <h3>아이디/비밀번호 찾기</h3>
    <form method="post" action="memberModify.jsp">
        <div class="form-group">
            <label for="mname">이름:</label>
            <input type="text" class="form-control" name="mname" required>
        </div>
        <div class="form-group">
            <label for="email">이메일:</label>
            <input type="email" class="form-control" name="email" required>
        </div>
        <button type="submit" class="btn btn-primary">찾기</button>
    </form>
    <p><%= message %></p> <!-- 결과 메시지 출력 -->
</div> --%>

	<form method="post" action="findIDProc.jsp" onsubmit="return findIDCheck()"> <!--myscript -->
	<table class= "table">
	<tr>
		<th>이름</th>
		<td>
			<input type="text" name="mname" id="mname" placeholder="이름" maxlength="20" required>
		</td>
	</tr>
	<tr>
		<th>이메일</th>
		<td>
			<input type="email" name="email" id="email" placeholder="이메일" maxlength="40" required>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="아이디/비밀번호 찾기" class="btn btn-primary"/>
			<input type="reset" value="취소" class="btn btn-primary"/>
		</td>
	</tr>
	</table>
</form>	

<%@ include file="../footer.jsp" %>