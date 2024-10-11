package net.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.swing.text.AbstractDocument.Content;

import net.utility.DBClose;
import net.utility.DBOpen;
import net.utility.MyAuthenticator;



public class MemberDAO{
	
	private DBOpen dbopen = null;
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private StringBuilder sql = null;
	
	
	public MemberDAO() {
		dbopen = new DBOpen();
	}

	
	
	public String loginProc(MemberDTO memberDto) {
		String mlevel = null;
		
		try {
			con = dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" SELECT mlevel ");
			sql.append(" FROM member ");
			sql.append(" WHERE id=? AND passwd=? "); 
			sql.append(" AND mlevel in ('A1', 'B1', 'C1', 'D1') ");
				
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, memberDto.getId());
			pstmt.setString(2, memberDto.getPasswd());
			
			rs = pstmt.executeQuery();
			
			// 결과 처리
			if (rs.next()) {
				mlevel = rs.getString("mlevel");
			}
			
			
			
		}catch(Exception e){
			System.out.println("로그인실패:" + e);
		}finally {
			DBClose.close(con, pstmt, rs);
		}
		return mlevel;
	}	
	
		public int duplecateID(String id) {
		int cnt = 0;
		try {
			con=dbopen.getConnection();
			
			sql = new StringBuilder();
			sql.append(" SELECT COUNT(id) as cnt ");
		    sql.append(" FROM member ");
		    sql.append(" WHERE id = ? ");
		    
		    
		    pstmt = con.prepareStatement(sql.toString());
		    pstmt.setString(1, id);
		    
		    rs = pstmt.executeQuery();
			
		    if (rs.next()) {
				cnt = rs.getInt("cnt");
						} 
		} catch (Exception e) {
			System.out.println("아이디 중복확인 실패 :" + e);
			
		}finally {
			DBClose.close(con, pstmt, rs);
		}
		return cnt;
		
	}
	
		public int duplecateEmail(String email) {
			int cnt = 0;
			try {
				con=dbopen.getConnection();
				
				sql = new StringBuilder();
				sql.append(" SELECT COUNT(email) as cnt ");
			    sql.append(" FROM member ");
			    sql.append(" WHERE email = ? ");
			    
			    
			    pstmt = con.prepareStatement(sql.toString());
			    pstmt.setString(1, email);
			    
			    rs = pstmt.executeQuery();
				
			    if (rs.next()) {
					cnt = rs.getInt("cnt");
							} 
			} catch (Exception e) {
				System.out.println("이메일 중복확인 실패 :" + e);
				
			}finally {
				DBClose.close(con, pstmt, rs);
			}
			return cnt;
			
		}
		
		public int create(MemberDTO memberDto) {
			int cnt = 0;
			try {
				con=dbopen.getConnection();
				
				StringBuilder sql = new StringBuilder();
		        sql.append("INSERT INTO member (id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate) ");
		        sql.append("VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'D1', now())");

				pstmt=con.prepareStatement(sql.toString());
				pstmt.setString(1, memberDto.getId());
	            pstmt.setString(2, memberDto.getPasswd());
	            pstmt.setString(3, memberDto.getMname());
	            pstmt.setString(4, memberDto.getTel());
	            pstmt.setString(5, memberDto.getEmail());
	            pstmt.setString(6, memberDto.getZipcode());
	            pstmt.setString(7, memberDto.getAddress1());
	            pstmt.setString(8, memberDto.getAddress2());
	            pstmt.setString(9, memberDto.getJob());
	            
	            cnt=pstmt.executeUpdate();
		        
			} catch (Exception e) {
				System.out.println(" 회원 가입 실패!! :" + e);
			}finally {
				DBClose.close(con, pstmt);
			}
			return cnt;
		}

		public boolean findID(MemberDTO memberDto) { 
			boolean flag = false;
			
			try {
				con = dbopen.getConnection();
				sql = new StringBuilder();
				
			
				
				//이름과 이메일이 일치하는 id가져오기
				sql.append(" SELECT id ");
				sql.append(" FROM member ");
				sql.append(" WHERE mname = ? AND email = ? ");
				
				pstmt=con.prepareStatement(sql.toString());
				pstmt.setString(1, memberDto.getMname());
				pstmt.setString(2, memberDto.getEmail());
				rs=pstmt.executeQuery();
				if(rs.next()) {
				
				String id = rs.getString("id");
				
				
				String[] ch = {
	                       "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
	                       "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
	                       "0","1","2","3","4","5","6","7","8","9"
	               };//ch[0]~ch[61]
				
				//ch배열에서 랜덤하게 10글자 뽑아서 가져오기
				
				StringBuilder imsiPW = new StringBuilder();
				for(int i=0; i<10; i++) {
					int num = (int)(Math.random()*ch.length);
					imsiPW.append(ch[num]);
					
				}
				
				sql = new StringBuilder();
				sql.append(" UPDATE member ");
				sql.append(" SET passwd = ? ");
				sql.append(" WHERE mname = ? AND email = ? ");
				
				pstmt=con.prepareStatement(sql.toString());
				pstmt.setString(1, imsiPW.toString());
				pstmt.setString(2, memberDto.getMname());
				pstmt.setString(3, memberDto.getEmail());
				
				int cnt = pstmt.executeUpdate();
				if(cnt==1) {//임시비밀번호로 테이블이 수정되었다면
					//4) 1)아이디(id)와 2)임시비밀번호(imsiPW)를 웹메일 전송하기
					
					String content= "임시비밀번호로 로그인 후, 회원 정보 수정에서 비밀번호 변경하세여";
					content += "<hr>";
					content += "<table boder='1'>";
					content += "<tr>";
					content += "	<th>아이디</th>";
					content += "	<td>" + id + "</td>" ;
					content += "</tr>";
					content += "<tr>";
					content += "	<th>임시비밀번호</th>";
					content += "	<td>" + imsiPW.toString() + "</td>"; 
					content += "</tr>";
					content += "</table>";
					
				
				
				String mailServer = "mw-002.cafe24.com";
				Properties props = new Properties();
				props.put("mail.smtp.host", mailServer);
				props.put("mail.smtp.auth", true);
				
				Authenticator myAuth = new MyAuthenticator(); //다형성 
				Session sess = Session.getInstance(props, myAuth);
				
				
				
				InternetAddress[] address = {new InternetAddress(memberDto.getEmail()) };
				Message msg = new MimeMessage(sess); 
				
				//받는 사람
				msg.setRecipients(Message.RecipientType.TO, address);
				
				msg.setFrom(new InternetAddress("webmaster@greenart"));
				
				//메일 제목
				msg.setSubject("Myweb 아이디/비번 입니다");
				
				//메일 내용
				msg.setContent(content, "text/html; charset=UTF-8");
				
				//메일 보낸 날짜
				msg.setSentDate(new Date());
				
				//메일 전송
				Transport.send(msg);
				
				flag = true;
				
				
				
				
				}
			}	
		}catch (Exception e) {
				System.out.println("아이디/비번 찾기 실패:" + e);
		}finally {
				DBClose.close(con, pstmt, rs);
		}
			
		return flag;
			
			
			
		
		
}

		
}//class end

	