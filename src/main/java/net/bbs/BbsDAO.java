package net.bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import net.utility.DBClose;
import net.utility.DBOpen;

public class BbsDAO{
	
	private DBOpen dbopen = null;
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private StringBuilder sql = null;
	
	
	public BbsDAO() {
		dbopen = new DBOpen();
	}
	
	public int create(BbsDTO bbsDto) {
		int cnt = 0;
		
		try {
			con = dbopen.getConnection();
			
			sql = new StringBuilder();
		    
		    //sql.append(" INSERT INTO tb_bbs( wname, subject, content, grpno, indent, ansnum, regdt, passwd, readcnt, ip) ");
		    //sql.append(" VALUES ('메시', '바르셀로나', '공격수', '9', '124.0.0.1', (select ifnull(max(bbsno),0)+1 from tb_bbs as TB), now()) ");
			
		    sql.append(" INSERT INTO tb_bbs(wname, subject, content, passwd, ip, grpno, regdt) ");
		    sql.append(" VALUES (?, ?, ?, ?, ?, (select ifnull(max(bbsno),0)+1 from tb_bbs as TB), now()) ");
		    
		    pstmt=con.prepareStatement(sql.toString());
		    pstmt.setString(1, bbsDto.getWname());
		    pstmt.setString(2, bbsDto.getSubject());
		    pstmt.setString(3, bbsDto.getContent());
		    pstmt.setString(4, bbsDto.getPasswd());
		    pstmt.setString(5, bbsDto.getIp());
		    
		    cnt = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("글 추가실패" + e);
			
		}finally {
			DBClose.close(con, pstmt);;
		}
		return cnt;
	}
	
	
	public ArrayList<BbsDTO> list(){
		ArrayList<BbsDTO> list = null;
		
		try {
			con=dbopen.getConnection();
			
			sql = new StringBuilder();
			sql.append(" SELECT bbsno, wname, subject, readcnt, regdt, indent ");
		    sql.append(" FROM tb_bbs ");
		    sql.append(" ORDER BY grpno DESC, ansnum ASC ");
		    
		    pstmt = con.prepareStatement(sql.toString());
		    rs = pstmt.executeQuery();
			if (rs.next()) {
				list = new ArrayList<BbsDTO>();
				do {
					BbsDTO bbsDto = new BbsDTO();
					bbsDto.setBbsno(rs.getInt("bbsno"));
					bbsDto.setWname(rs.getString("wname"));
					bbsDto.setSubject(rs.getString("subject"));
					bbsDto.setReadcnt(rs.getInt("readcnt"));
					bbsDto.setRegdt(rs.getString("regdt"));
					bbsDto.setIndent(rs.getInt("indent"));
					
					list.add(bbsDto);
					
				} while (rs.next());
			}//if end
		} catch (Exception e) {
			System.out.println("전체목록실패:" + e);
			
		}finally {
			DBClose.close(con, pstmt, rs);
		}
		return list;
		
		
	}
	
	public int count(){
		int cnt=0;
		
		try {
			con=dbopen.getConnection();
			
			sql = new StringBuilder();
			sql.append(" SELECT COUNT(*) as cnt ");
		    sql.append(" FROM tb_bbs ");
		    
		    
		    pstmt = con.prepareStatement(sql.toString());
		    rs = pstmt.executeQuery();
			if (rs.next()) {
					cnt = rs.getInt("cnt");
			
					
				
			}//if end
		} catch (Exception e) {
			System.out.println("글갯수 실패:" + e);
			
		}finally {
			DBClose.close(con, pstmt, rs);
		}
		return cnt;
		
		
	}
	
	public BbsDTO read(int bbsno) {
		BbsDTO bbsDto = null;
		try {
			con=dbopen.getConnection();
			
			sql = new StringBuilder();
			sql.append(" SELECT bbsno, wname, subject, content, readcnt, regdt, ip, grpno, indent, ansnum ");
		    sql.append(" FROM tb_bbs ");
		    sql.append(" WHERE bbsno = ? ");
		    
		    pstmt=con.prepareStatement(sql.toString());
		    pstmt.setInt(1, bbsno);
		    
		    rs=pstmt.executeQuery();
		    if(rs.next()) {
		    	bbsDto = new BbsDTO();
		    	bbsDto.setBbsno(rs.getInt("bbsno"));
		    	bbsDto.setWname(rs.getString("wname"));
		    	bbsDto.setSubject(rs.getString("subject"));
		    	bbsDto.setContent(rs.getString("content"));
		    	bbsDto.setReadcnt(rs.getInt("readcnt"));
		    	bbsDto.setRegdt(rs.getString("regdt"));
		    	bbsDto.setIp(rs.getString("ip"));
		    	bbsDto.setGrpno(rs.getInt("grpno"));
		    	bbsDto.setIndent(rs.getInt("indent"));
		    	bbsDto.setAnsnum(rs.getInt("ansnum"));
		    	
		    }
			
		} catch (Exception e) {
			System.out.println("상세보기 실패:" + e);
		}finally {
			DBClose.close(con, pstmt, rs);
		}
		return bbsDto;
	}
	
	public void incrementCnt(int bbsno){
		
		try {
			con=dbopen.getConnection();
			
			sql = new StringBuilder();
			sql.append(" UPDATE tb_bbs ");
		    sql.append(" SET readcnt = readcnt + 1 ");
		    sql.append(" WHERE bbsno = ? ");
		    
		    
		    pstmt = con.prepareStatement(sql.toString());
		    pstmt.setInt(1, bbsno);
		    pstmt.executeUpdate();
			
					
				
		
		} catch (Exception e) {
			System.out.println("조회수 증가 실패:" + e);
			
		}finally {
			DBClose.close(con, pstmt);
		}
		
		
	}
	
public int delete(BbsDTO bbsDto){
		int cnt=0;	
		try {
			con=dbopen.getConnection();
			
			sql = new StringBuilder();
			sql.append(" DELETE FROM tb_bbs ");
		    sql.append(" WHERE bbsno = ? ");
		    
		    
		    pstmt = con.prepareStatement(sql.toString());
		    pstmt.setInt(1, bbsDto.getBbsno());
		    
		    cnt=pstmt.executeUpdate();
			
					
				
		
		} catch (Exception e) {
			System.out.println("게시글 삭제 실패:" + e);
			
		}finally {
			DBClose.close(con, pstmt);
		}
		
		return cnt;
	}
		public int updateproc(BbsDTO bbsDto) {
			int cnt = 0;

			try {
				con = dbopen.getConnection();

	        sql = new StringBuilder();
	        sql.append(" UPDATE tb_bbs ");
	        sql.append(" SET wname = ?, subject = ?, content = ?, passwd = ?, regdt = SYSDATE ");
	        sql.append(" WHERE bbsno = ? AND passwd = ? "); // 비밀번호 확인 추가
	
	        pstmt = con.prepareStatement(sql.toString());
	        pstmt.setString(1, bbsDto.getWname());
	        pstmt.setString(2, bbsDto.getSubject());
	        pstmt.setString(3, bbsDto.getContent());
	        pstmt.setString(4, bbsDto.getPasswd());
	        pstmt.setInt(5, bbsDto.getBbsno());
	        pstmt.setString(6, bbsDto.getPasswd()); // 비밀번호를 확인하기 위해 다시 설정
	
	        cnt = pstmt.executeUpdate();
	    } catch (Exception e) {
	        System.out.println("게시글 수정 실패:" + e);
	    } finally {
	        DBClose.close(con, pstmt);
	    }

			return cnt;
		}
	
		public int reply(BbsDTO bbsDto) {
			int cnt = 0;
			try {
				con = dbopen.getConnection();
				sql = new StringBuilder();
				
				//1)부모글 정보 가져오기(select문)
				int grpno = 0; //그룹번호
				int indent = 0; //들여쓰기
				int ansnum = 0; //글순서
				sql.append(" SELECT grpno, indent, ansnum ");
				sql.append(" FROM tb_bbs ");
				sql.append(" WHERE bbsno = ? ");
				
				pstmt=con.prepareStatement(sql.toString());
				pstmt.setInt(1, bbsDto.getBbsno());
				rs=pstmt.executeQuery();
				if(rs.next()) {
					grpno = rs.getInt("grpno"); //그룹번호 : 부모글 그룹번호 그대로 가져오기
					indent = rs.getInt("indent") + 1; //들여쓰기 : 부모글 들여쓰기 + 1;
					ansnum = rs.getInt("ansnum") + 1; //글순서 : 부모글 글순서 + 1
				}
				
				//2)글순서 재조정 하기(update문)
				
				sql.delete(0, sql.length()); //1)단계에서 사용했던 sql값 지우기
				sql.append(" UPDATE tb_bbs ");
				sql.append(" SET ansnum = ansnum + 1 ");
				sql.append(" WHERE grpno = ? AND ansnum >= ? ");
				
				pstmt=con.prepareStatement(sql.toString());
				pstmt.setInt(1, grpno);
				pstmt.setInt(2, ansnum);
				pstmt.executeUpdate();
				
		
				//3)답변글 추가하기(insert문)
				sql.delete(0, sql.length()); //1)단계에서 사용했던 sql값 지우기
				sql.append(" INSERT INTO tb_bbs(wname, subject, content, passwd, ip, grpno, indent, ansnum, regdt) ");
				sql.append(" VALUES (?, ?, ?, ?, ?, ?, ?, ?, now()) ");
				
				 
				
				
				pstmt=con.prepareStatement(sql.toString());
				pstmt.setString(1, bbsDto.getWname());
				pstmt.setString(2, bbsDto.getSubject());
				pstmt.setString(3, bbsDto.getContent());
				pstmt.setString(4, bbsDto.getPasswd());
				pstmt.setString(5, bbsDto.getIp());
				pstmt.setInt(6, grpno);
				pstmt.setInt(7, indent);
				pstmt.setInt(8, ansnum);
				
				cnt=pstmt.executeUpdate();
				
				
				
				
			} catch (Exception e) {
				System.out.println("답변쓰기 실패"+e);
			}finally {
				DBClose.close(con, pstmt, rs);
			}
			return cnt;
		}//reply()
	
		public int count2(String col, String word) {
			int cnt = 0;
			
			try {
				
				con=dbopen.getConnection();
				
				sql = new StringBuilder();
				sql.append(" SELECT COUNT(*) as cnt ");
			    sql.append(" FROM tb_bbs ");
			    
			    if(word.length()>=1){//검색어가 존재한다면
			    	String search = "";
			    	if(col.equals("subject_content")) {
			    	search += " WHERE subject LIKE '%" + word + "%' ";
			    	search += " OR content LIKE '%" + word + "%' ";
			    	}else if(col.equals("wname")) {
			    		search += " WHERE wname LIKE '%" + word + "%' ";
					
			    		}//if end 
			    	
			    	sql.append(search);
			    
			    }//if end			    
			    
			    pstmt = con.prepareStatement(sql.toString());
			    rs = pstmt.executeQuery();
				if (rs.next()) {
						cnt = rs.getInt("cnt");
				}
				
			} catch (Exception e) {
				System.out.println("검색 실패"+e);
			}finally {
				DBClose.close(con, pstmt, rs);
			}
			
			
			return cnt;
		}//count2 end
		public ArrayList<BbsDTO> list2(String col, String word){
			ArrayList<BbsDTO> list = null;
			
			try {
				con=dbopen.getConnection();
				
				sql = new StringBuilder();
				sql.append(" SELECT bbsno, wname, subject, readcnt, regdt, indent ");
			    sql.append(" FROM tb_bbs ");
			    
			    if(word.length()>=1){//검색어가 존재한다면
			    	String search = "";
			    	if(col.equals("subject_content")) {
			    		search += " WHERE subject LIKE '%" + word + "%' ";
			    		search += " OR content LIKE '%" + word + "%' ";
			    	}else if(col.equals("wname")) {
			    		search += " WHERE wname LIKE '%" + word + "%' ";
					
			    		}//if end 
			    	
			    	sql.append(search);
			    
			    }//if end		
			    
			    
			    
			    sql.append(" ORDER BY grpno DESC, ansnum ASC ");
			    
			    pstmt = con.prepareStatement(sql.toString());
			    rs = pstmt.executeQuery();
				
			    if (rs.next()) {
					list = new ArrayList<BbsDTO>();
					do {
						BbsDTO bbsDto = new BbsDTO();
						bbsDto.setBbsno(rs.getInt("bbsno"));
						bbsDto.setWname(rs.getString("wname"));
						bbsDto.setSubject(rs.getString("subject"));
						bbsDto.setReadcnt(rs.getInt("readcnt"));
						bbsDto.setRegdt(rs.getString("regdt"));
						bbsDto.setIndent(rs.getInt("indent"));
						
						list.add(bbsDto);
						
					} while (rs.next());
				}//if end
			} catch (Exception e) {
				System.out.println("전체목록실패:" + e);
				
			}finally {
				DBClose.close(con, pstmt, rs);
			}
			return list;
			
			
		}
		
		public ArrayList<BbsDTO> list3(String col, String word, int nowPage, int recordPerPage){
			ArrayList<BbsDTO> list = null;
			
			 int startRow = ((nowPage-1) * recordPerPage) + 1 ;
		     int endRow   = nowPage * recordPerPage;
		   
		     
		    
			try {
				con=dbopen.getConnection();
				sql=new StringBuilder();
				word = word.trim();
				
				 if(word.length()==0) {//검색어가 존재하지 않는 경우 bbs.sql파일에서 페이징 부분의 6)
				    	sql.append(" SELECT * ");
				    	sql.append(" FROM( ");
				    	sql.append(" 		SELECT bbsno, wname, subject, readcnt, regdt, indent, ROWNUM AS r ");
				    	sql.append(" 		FROM( ");
				    	sql.append(" 					SELECT bbsno, wname, subject, readcnt, regdt, indent ");
				    	sql.append(" 					FROM tb_bbs ");
				    	sql.append(" 					ORDER BY grpno DESC, ansnum ASC ");
				    	sql.append(" 			) ");
				    	sql.append(" 	) ");
				    	sql.append(" WHERE r>="	+ startRow + " AND r<="+ endRow);
				    	 
	     }else {//검색어가 존재하는 경우 bbs.sql파일에서 페이징 부분의 7)
	    	 sql.append(" SELECT * ");
	    	 sql.append(" FROM( ");
	    	 sql.append(" 		SELECT bbsno, wname, subject, readcnt, regdt, indent, ROWNUM AS r ");
	    	 sql.append(" 		FROM( ");
	    	 sql.append(" 		SELECT bbsno, wname, subject, readcnt, regdt, indent ");
	    	 sql.append(" 				FROM tb_bbs ");
	    	
	    	 				String search = "";
					    	if(col.equals("subject_content")) {
					    		search += " WHERE subject LIKE '%" + word + "%' ";
					    		search += " OR content LIKE '%" + word + "%' ";
					    	}else if(col.equals("wname")) {
					    		search += " WHERE wname LIKE '%" + word + "%' ";
					    	}//if end
					    	sql.append(search);
	  
	    	 sql.append(" 				ORDER BY grpno DESC, ansnum ASC ");
	    	 sql.append(" 			) ");
	    	 sql.append(" 		) ");
	    	 sql.append(" WHERE r>=" + startRow + " AND r<="+ endRow);
	    	 
	    	 
	    	 
		}
			    
			    pstmt = con.prepareStatement(sql.toString());
			    rs = pstmt.executeQuery();
				if (rs.next()) {
					list = new ArrayList<BbsDTO>();
					do {
						BbsDTO bbsDto = new BbsDTO();
						bbsDto.setBbsno(rs.getInt("bbsno"));
						bbsDto.setWname(rs.getString("wname"));
						bbsDto.setSubject(rs.getString("subject"));
						bbsDto.setReadcnt(rs.getInt("readcnt"));
						bbsDto.setRegdt(rs.getString("regdt"));
						bbsDto.setIndent(rs.getInt("indent"));
						
						list.add(bbsDto);
						
					} while (rs.next());
				}//if end
			} catch (Exception e) {
				System.out.println("전체목록실패:" + e);
				
			}finally {
				DBClose.close(con, pstmt, rs);
			}
			return list;
			
			
		}
	
	
	
	
	
	
}