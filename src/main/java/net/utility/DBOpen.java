package net.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class DBOpen {

    public Connection getConnection() {
        // MariaDB연동
        Connection con = null;
        PreparedStatement pstmt = null; // pstmt 변수 선언

        try {
            // MariaDB서버 연결 정보
            String url = "jdbc:mariadb://localhost:3306/greenit";
            String user = "root";
            String password = "1234";
            String driver = "org.mariadb.jdbc.Driver";
            
//            String url      = "jdbc:mysql://localhost/내아이디";
//		    String user     = "내아이디";
//		    String password = "비밀번호";
//		    String driver   = "org.gjt.mm.mysql.Driver";

            Class.forName(driver);
            con = DriverManager.getConnection(url, user, password);
            System.out.println("MariaDB 연결 성공!!");
            
        } catch (Exception e) {
            System.out.println("MariaDB 연결 실패 : " + e);
        } /*finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
            } catch (Exception e) {
                System.out.println("PreparedStatement 닫기 실패 : " + e);
            }
            try {
                if (con != null) {
                    con.close(); // con을 닫는 코드 수정
                }
            } catch (Exception e) {
                System.out.println("Connection 닫기 실패 : " + e);
            }
        }*/

        return con; // Connection 반환
    }
}