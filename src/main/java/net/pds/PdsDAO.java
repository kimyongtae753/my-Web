package net.pds;

import net.bbs.BbsDTO;
import net.pds.PdsDTO;
import net.utility.DBClose;
import net.utility.DBOpen;
import net.utility.Utility;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class PdsDAO{ 
	
	private DBOpen dbopen;
	private Connection con;
	private PreparedStatement pstmt;
	private StringBuilder sql;
	private ResultSet rs = null;

	public PdsDAO() {
		dbopen = new DBOpen();
	}
	
	
	public int create (PdsDTO pdsDto){
		int cnt = 0;
		
		try {
			con = dbopen.getConnection();
			
			sql = new StringBuilder();
			sql.append(" INSERT INTO tb_pds(wname, subject, passwd, filename, filesize, regdate) ");
		    sql.append(" VALUES (?, ?, ?, ?, ?, now()) ");
		      
		    pstmt=con.prepareStatement(sql.toString());
		    pstmt.setString(1, pdsDto.getWname());
		    pstmt.setString(2, pdsDto.getSubject());
		    pstmt.setString(3, pdsDto.getPasswd());
		    pstmt.setString(4, pdsDto.getFilename());
		    pstmt.setLong(5, pdsDto.getFilesize());
		    
		    cnt = pstmt.executeUpdate();
		    
		} catch (Exception e) {
			System.out.println("포토갤러리 추가실패" + e);
			
		}finally {
			DBClose.close(con, pstmt);;
		}
		return cnt;
	}
	
	public ArrayList<PdsDTO> list(){
		ArrayList<PdsDTO> list = null;
		
		try {
			con=dbopen.getConnection();
			
			sql = new StringBuilder();
			sql.append(" SELECT pdsno, wname, subject, filename, readcnt, regdate ");
		    sql.append(" FROM tb_pds ");
		    sql.append(" ORDER BY regdate DESC ");
		    
		    pstmt = con.prepareStatement(sql.toString());
		    rs = pstmt.executeQuery();
			if (rs.next()) {
				list = new ArrayList<PdsDTO>();
				do {
					PdsDTO dto = new PdsDTO();
					dto.setPdsno(rs.getInt("pdsno"));
					dto.setWname(rs.getString("wname"));
					dto.setSubject(rs.getString("subject"));
					dto.setFilename(rs.getString("filename"));
					dto.setReadcnt(rs.getInt("readcnt"));
					dto.setRegdate(rs.getString("regdate"));
					
					list.add(dto);
					
				} while (rs.next());
			}//if end
		} catch (Exception e) {
			System.out.println("전체목록실패:" + e);
			
		}finally {
			DBClose.close(con, pstmt, rs);
		}
		return list;
		
		
	}
	
	public PdsDTO read(int pdsno) {
		PdsDTO pdsDto = null;
		try {
			con=dbopen.getConnection();
			
			sql = new StringBuilder();
			sql.append(" SELECT pdsno, wname, subject, filename, filesize ");
		    sql.append(" FROM tb_pds ");
		    sql.append(" WHERE pdsno = ? ");
		    
		    pstmt=con.prepareStatement(sql.toString());
		    pstmt.setInt(1, pdsno);
		    
		    rs=pstmt.executeQuery();
		    if(rs.next()) {
		    	pdsDto = new PdsDTO();
		    	pdsDto.setPdsno(rs.getInt("pdsno"));
		    	pdsDto.setWname(rs.getString("wname"));
		    	pdsDto.setSubject(rs.getString("subject"));
		    	pdsDto.setFilename(rs.getString("filename"));
		    	pdsDto.setFilesize(rs.getLong("filesize"));
		  
		    	
		    }
			
		} catch (Exception e) {
			System.out.println("상세보기 실패:" + e);
		}finally {
			DBClose.close(con, pstmt, rs);
		}
		return pdsDto;
	}
	
	public void incrementCnt(int pdsno){
		
		try {
			con=dbopen.getConnection();
			
			sql = new StringBuilder();
			sql.append(" UPDATE tb_pds ");
		    sql.append(" SET readcnt = readcnt + 1 ");
		    sql.append(" WHERE pdsno = ? ");
		    
		    
		    pstmt = con.prepareStatement(sql.toString());
		    pstmt.setInt(1, pdsno);
		    pstmt.executeUpdate();
			
					
				
		
		} catch (Exception e) {
			System.out.println("조회수 증가 실패:" + e);
			
		}finally {
			DBClose.close(con, pstmt);
		}
		
		
	}
	
	public int delete(int pdsno, String passwd, String saveDir){
		
		int cnt=0;	
		try {
			//테이블의 행이 삭제하기 전에, 삭제하고자 하는 파일명 가져온다
			String filename ="";
			PdsDTO oldDto = read(pdsno);
			if(oldDto!=null) {
				filename = oldDto.getFilename();
			}//if end
			
			con=dbopen.getConnection();
			
			sql = new StringBuilder();
			sql.append(" DELETE FROM tb_pds ");
		    sql.append(" WHERE pdsno = ? AND passwd =? ");
		    
		    
		    pstmt = con.prepareStatement(sql.toString());
		    pstmt.setInt(1, pdsno);
		    pstmt.setString(2, passwd);
		    
		    cnt=pstmt.executeUpdate();
		    
		    if(cnt==1) {//테이블에서 행삭제가 성공했으므로, 첨부했던 파일도 삭제
		    	Utility.deleteFile(saveDir, filename);
		    }		
				
		
		} catch (Exception e) {
			System.out.println("포토 갤러리 삭제 실패:" + e);
			
		}finally {
			DBClose.close(con, pstmt);
		}
		
		return cnt;
	}


	
	
}

