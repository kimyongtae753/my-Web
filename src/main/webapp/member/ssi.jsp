<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- ssi.jsp 공통페이지 --%>

<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>

<%@ page import="net.utility.*" %>
<%@ page import="net.member.*" %>

<jsp:useBean id="memberDao" class="net.member.MemberDAO" scope="page"></jsp:useBean>
<jsp:useBean id="memberDto" class="net.member.MemberDTO" scope="page"></jsp:useBean>

<%request.setCharacterEncoding("UTF-8");%>