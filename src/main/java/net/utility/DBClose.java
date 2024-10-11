package net.utility;

import java.sql.*;

public class DBClose{
	//데이터베이스 연결 자원 반납	
	public static void close(Connection con) {
		try {
			if(con!=null) {con.close();}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}//end
	
	public static void close(Connection con, PreparedStatement pstmt) {
		try {
			if(pstmt !=null) {pstmt.close();}
		} catch (Exception e) {
			// TODO: handle exception
		}
		try {
			if(con!=null) {con.close();}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}//end
	
	public static void close(Connection con, PreparedStatement pstmt, ResultSet rs) {
		try {
			if(pstmt !=null) {pstmt.close();}
		} catch (Exception e) {
			// TODO: handle exception
		}
		try {
			if(con!=null) {con.close();}
		} catch (Exception e) {
			// TODO: handle exception
		}
		try {
			if(rs!=null) {rs.close();}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}//end
}//class end