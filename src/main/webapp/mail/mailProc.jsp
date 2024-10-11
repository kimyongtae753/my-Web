<%@page import="javax.mail.Transport"%>
<%@page import="java.util.Date"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="net.utility.Utility"%>
<%@page import="javax.mail.Session"%>
<%@page import="net.utility.MyAuthenticator"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<h3>메일 보내기 결과</h3>
<% 
	try{
		//1) 사용하고자 하는 메일서버에서 인증받은 계정과 비번 등록하기
		//MyAuthenticator 클래스 생성
		
		//2) 메일서버 (pop3/SMTP)지정하기
		String mailServer = "mw-002.cafe24.com";
		Properties props = new Properties();
		props.put("mail.smtp.host", mailServer);
		props.put("mail.smtp.auth", true);
	
		//3)메일서버에서 인증받은 계정+비번
		Authenticator myAuth = new MyAuthenticator();
		
		//4)
		Session sess = Session.getInstance(props, myAuth);
		out.print("<p>메일 서버 인증 성공</p>");
		
		//5)메일 보내기
		request.setCharacterEncoding("UTF-8");
		String to 		= 		request.getParameter("to").trim();
		String from 	= 		request.getParameter("from").trim();
		String subject 	= 		request.getParameter("subject").trim();
		String content 	= 		request.getParameter("content").trim();
		
		//엔터 및 특수문자 변경
		
		content = Utility.convertChar(content);
		
		
		//받는 사람 이메일 주소
		InternetAddress[] address = { new InternetAddress(to) };
		
		
		//메일 관련 정보
		Message msg = new MimeMessage(sess); 
		
		//받는 사람
		msg.setRecipients(Message.RecipientType.TO, address);
		//참조 CC
		//숨은 참조 BCC
		
		//보내는 사람
		msg.setFrom(new InternetAddress(from));
		
		//메일 제목
		msg.setSubject(subject);
		
		//메일 내용
		msg.setContent(content, "text/html; charset=UTF-8");
		
		//메일 보낸 날짜
		msg.setSentDate(new Date());
		
		//메일 전송
		Transport.send(msg);
		
		out.print(to + " 님에게 메일이 발송되었습니다");
		
		
	}catch(Exception e){
		out.print("메일 전송 실패!");
		out.print("<p><a href='javascriptLhistory.back();'>[다시시도]</a></p>");
		e.printStackTrace();
	}











%>










<%@ include file="../footer.jsp" %>