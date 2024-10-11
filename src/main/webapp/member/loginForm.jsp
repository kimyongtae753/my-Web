<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="auth.jsp" %>
<%@ include file="../header.jsp" %>
<!-- 본문시작 loginForm.jsp -->
<div class="container">
    <h3 class="text-center">* 로 그 인 *</h3>
    <%
        if(s_id.equals("guest") || s_passwd.equals("guest") || s_mlevel.equals("guest")) {
            //로그인하지 않았다면
            //ID저장 쿠키 확인-----------------------------------
            Cookie[] cookies = request.getCookies(); //사용자 PC에 저장된 모든 쿠키값 가져오기
            String c_id = "";
            if(cookies != null){ //쿠키값들이 존재하는지?
                for(int i=0; i<cookies.length; i++){ //모든 쿠키값을 검색
                    Cookie cookie = cookies[i];      //쿠키 하나씩 가져오기
                    if(cookie.getName().equals("c_id")==true){ //logingProc.jsp에서 선언한 쿠키변수 참조
                        c_id = cookie.getValue(); //쿠키변수값 가져오기
                    }//if end
                }//for end                
            }//if end        
            //------------------------------------------------
    %>
        <form name="loginfrm" id="loginfrm" method="post" action="loginProc.jsp" onsubmit="return loginCheck()">
            <table class="table table-bordered">
                <tr>
                    <td>
                        <input type="text" name="id" id="id" value="<%=c_id%>" maxlength="10" placeholder="아이디" required class="form-control">
                    </td>
                    <td rowspan="2">
                        <input type="image" src="../images/bt_login.gif" class="btn btn-primary">
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="password" name="passwd" id="passwd" maxlength="10" placeholder="비밀번호" required class="form-control">
                    </td>
                </tr>    
                <tr>
                    <td colspan="2">
                        <label><input type="checkbox" name="c_id" value="SAVE" <%if(!c_id.isEmpty()){out.print("checked");}%>> ID 저장</label>
                    </td>
                </tr>            
                <tr>
                    <td colspan="2" class="text-center">
                        <a href="agreement.jsp">[회원가입]</a>
                        &nbsp;&nbsp;&nbsp;
                        <a href="findID.jsp">[아이디/비밀번호찾기]</a>
                    </td>    
                </tr>
            </table>
        </form>
    <%
        } else {
            //로그인 성공 했다면
            out.println("<strong>" + s_id + "</strong> 님"); 
            out.println("<a href='logout.jsp'>[로그아웃]</a>");
            out.println("<br></br>");
            out.println("<a href='memberModify.jsp'>[회원정보수정]</a>");
        }//if end
    %>
</div>
<!-- 본문끝 -->
<%@ include file="../footer.jsp" %>