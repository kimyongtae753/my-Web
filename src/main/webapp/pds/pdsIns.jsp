<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>
<!-- 본문  -->
<h3>사진 올리기 결과</h3>

<% 
	try{
	
	//1. 첨부된 파일 저장하기
	
	//첨부된 파일을 저장하는 폴더 생성 / src/main/webapp/storage
	
	//실제 물리적인 경로
	String saveDirectory = application.getRealPath("/storage");
	//E:\java202407\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\basic06_myweb\storage
	
	//저장 최대 용량 (10M)
	int maxPostSize = 1024*1024*10;
	
	//한글 인코딩
	String encoding = "UTF-8";
	
	MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, new DefaultFileRenamePolicy());
	
	//2) 1)단계에서 저장한 파일의 파일명, 파일크기 가져오기
	String fileName = "";
	long filesize = 0;
	File file = null;		//실제 파일 담기
	String item = "";
	
	Enumeration files = mr.getFileNames(); //mr에서 <input type=file>을 전부 수거하기
	while(files.hasMoreElements()){			//여러개의 파일을 첨부하는 경우에 한개씩 처리하기
		item = (String)files.nextElement();
		fileName = mr.getFilesystemName(item);
		if(fileName !=null){
			file = mr.getFile(item);
			if(file.exists()){
				filesize = file.length();
			}
		}
		
	}//while end
	
	//3) tb_pds테이블 저장하기
	String wname = mr.getParameter("wname");
	String subject = mr.getParameter("subject");
	String passwd = mr.getParameter("passwd");
	
	//dto 객체 담기
	
	pdsDto.setWname(wname);
	pdsDto.setSubject(subject);
	pdsDto.setPasswd(passwd);
	pdsDto.setFilename(fileName);
	pdsDto.setFilesize(filesize);
	
	int cnt = pdsDao.create(pdsDto);
	if(cnt==0){
		out.println("<p><a href='javascript:history.back();'>[돌아가기]</a></p>");
	}else{
		out.println(" <script> ");
		out.println(" alert('파일이 추가되었습니다');");
		out.println(" location.href='pdsList.jsp'; ");
		out.println(" </script> ");
	}
	
	
	}catch(Exception e){
	out.print(e);
	out.print("<p>사진 업로드 실패!!</p>");
	out.print("<p><a href='javascript:history.back();'>[다시시도]</a></p>");
	
	}

%>
<!-- 본문 끝 -->
<%@ include file="../footer.jsp" %>