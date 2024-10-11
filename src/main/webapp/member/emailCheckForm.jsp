<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>idCheckForm.jsp</title>
</head>
<body>

	<div style="text-align: center">
		<h3>* 이메일 중복확인 *</h3>
		<form method="post" action="emailCheckProc.jsp" onsubmit="return blankCheck()">
        	이메일 :
        	<input type="text" name="email" id="email" maxlength="50" required autofocus>
       	    <input type="submit" value="중복확인">		
		</form>
	</div>
	<script>
		function blankCheck() {
			let id = document.getElementById("email").value;
			id = id.trim();
			if(id.length<10){
				alert("아이디는 5~10글자 이내로 입력해 주세요");
				return false;
			}
			return true;
		}
	</script>
	
	
	
</body>
</html>