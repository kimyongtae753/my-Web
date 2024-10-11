/**
 * myscript.js 
 */
function bbsCheck(){
    //답변형 게시판 유효성 검사
    //1.작성자는 2글자 이상 2.제목은 2글자 이상 3.내용은 2글자 이상 4.비밀번호는 4글자 이상이면서 숫자형만 사용

  let wname = $("#wname").val();
    wname = wname.trim();
    if(wname.length<2){
        alert("작성자 2~20글자 이내에서 작성해 주세요")
        $("#wname").focus();
        return false;

    }
    let subject = $("#subject").val();
    subject = subject.trim();
    if(subject.length<2){
        alert("제목은 2~20글자 이내에서 작성해 주세요")
        $("#subject").focus();
        return false;

    }
    let content = $("#content").val();
    content = content.trim();
    if(content.length<2){
        alert("작성자 2~20글자 이내에서 작성해 주세요")
        $("#content").focus();
        return false;

    }
	let passwd = $("#passwd").val();
	   passwd = passwd.trim();
	   
	   if (passwd.length < 4 || !/^\d+$/.test(passwd)) {
	       alert("비밀번호는 4글자 이상이어야 하며 숫자만 포함되어야 합니다.");
	       $("#passwd").focus();
	       return false;
	   }
	function pwCheck(){
		let passwd = $("#passwd").val();
			   passwd = passwd.trim();
			   
			   if (passwd.length < 4 || !/^\d+$/.test(passwd)) {
			       alert("비밀번호는 4글자 이상이어야 하며 숫자만 포함되어야 합니다.");
			       $("#passwd").focus();
			       return false;
			   }
		let message = "삭제된 내용은 복구되지 않습니다.\n계속 진행할까요?";
			  if(confirm(message)){//확인 true, 취소 false값 반환
				return true; 
			}else{
					return false;
			}
			   
	   
	}
}//bbsCheck() end

	function searchCheck(){
		let word = $("#word").val();
		word = word.trim();
		if(word.length==0){
			alert("검색어를 입력해주세요");
			return false;
		}
		return true;
		
	}//searchCheck end
	
	function loginCheck() { //로그인 유효성 검사 (아이디, 비번)
		//1)아이디 5~10글자 이내인지 검사
		let id = $("#id").val();
		id = id.trim();
		if(!(id.length>=5 && id.length<=10)){
			alert("아이디 5~10글자이내 입력해 주세요");
			$("#id").focus();
			return false;		
		}//if end
		
		//2)비밀번호 5~10글자 이내인지 검사
		let passwd = $("#passwd").val();
		passwd = passwd.trim();
		if(!(passwd.length>=5 && passwd.length<=10)){
			alert("비밀번호 5~10글자이내 입력해 주세요");
			$("#passwd").focus();
			return false;		
		}//if end
		
		return true;//서버로 전송
		
	}//loginCheck() end


	function idCheck() { //아이디 중복확인
		//모달창
		//->부모창과 자식창이 한몸으로 구성되어 있음
		//->참조 https://www.w3schools.com/bootstrap/bootstrap_modal.asp


		//새창 만들기
		//->부모창과 자식창이 별개로 구성되어 있음
		//->모바일에 기반을 둔 frontend단(SPA)에서는 사용하지 말것!!
		//->참조 https://www.w3schools.com/jsref/met_win_open.asp
		//window.open("파일명", "새창이름", "다양한옵션들")
		window.open("idCheckForm.jsp", "idwin", "width=400,height=350");	
		
	}//idCheck() end

	function emailCheck() { //아이디 중복확인
		//모달창
		//->부모창과 자식창이 한몸으로 구성되어 있음
		//->참조 https://www.w3schools.com/bootstrap/bootstrap_modal.asp


		//새창 만들기
		//->부모창과 자식창이 별개로 구성되어 있음
		//->모바일에 기반을 둔 frontend단(SPA)에서는 사용하지 말것!!
		//->참조 https://www.w3schools.com/jsref/met_win_open.asp
		//window.open("파일명", "새창이름", "다양한옵션들")
		window.open("emailCheckForm.jsp", "emailwin", "width=400,height=350");	
		
	}//idCheck() end

	function memberCheck(){//회원가입 유효성 검사
		//1)아이디 5~10 인지
		let id = $("#id").val();
		id = id.trim();
		if(!(id.length>=5 && id.length<=10)){
			alert("아이디는 5~10글자 이내 입력해주세요");
			$("#id").focus();
			return false;
		}

		//아이디명 금칙어

		//2)비밀번호 5~10글자인지
		let passwd = $("#passwd").val();
		passwd = passwd.trim();
		if(!(passwd.length>=5 && passwd.length<=10)){
			alert("비밀번호는는 5~10글자 이내 입력해주세요");
			$("#passwd").focus();
			return false;
		}

		//3)비밀번호와 비밀번호 확인이 서로 일치하는지
		let repasswd = $("#repasswd").val();
		repasswd = repasswd.trim();
		if(repasswd.length<5 && passwd!=repasswd){
			alert("비밀번호를 똑같이 입력해주세요");
			$("#repasswd").focus();
			return false;
		}

		//4)이름 두글자 이상 인지?
		let mname = $("#mname").val();
		mname = mname.trim();
		if(!(mname.length>=2)){
			alert("이름은 2글자 이상 입력해주세요");
			$("#mname").focus();
			return false;
		}

		//4)이메일 다섯글자 이상 인지?
		let email = $("#email").val();
		email = email.trim();
		if(!(email.length>=2)){
			alert("이름은 2글자 이상 입력해주세요");
			$("#email").focus();
			return false;
		}

		//5)직업을 선택했는지

		let job = $("#job").val();
		if(job==0){
			alert("직업을 선택해주세요");
			return false;
		}

		return true; //서버로 전송
	}

	function findIDCheck() { //로그인 유효성 검사 (아이디, 비번)
		//1)아이디 5~10글자 이내인지 검사
		let mname = $("#mname").val();
		mname = mname.trim();
		if(mname.length<2){
			alert("이름을 두글자이상 입력해 주세요");
			$("#mname").focus();
			return false;		
		}//if end
		
		//2)비밀번호 5~10글자 이내인지 검사
		let email = $("#email").val();
		email = email.trim();
		if(email.length<5){
			alert("비밀번호 5~10글자이내 입력해 주세요");
			$("#passwd").focus();
			return false;		
		}//if end
		
		return true;//서버로 전송
		
	}//loginCheck() end
	
	