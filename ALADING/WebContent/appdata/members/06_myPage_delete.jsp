<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알라딩 서점</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="include/main.js"></script>
<link href="../appdata/css/main.css" rel="stylesheet">
<script>
	function find_IdPw() {
		location.href="04_find.jsp";
	}
	function main() { // 메인
		location.href="01_main.jsp";
	}
	function myPage() { // 마이페이지
		location.href="06_myPage.jsp";
	}
	function logout() { // 로그아웃
		location.href="05_logout.jsp";
	}
</script>
<style>
/* 본문 */
.delete_mem {
	margin: auto;
	padding: 50px;
	width: 400px;
	align-items: center;
	background-color: #fff;
	text-align: center;
	border: none;
}

/**/
.delete_mem>h3 {
	color: #333;
}

/**/
.delete_mem>p {
	font-size: 13px;
}

/**/
.delete_mem>ul {
	margin: 0;
	padding: 0;
	list-style: none;
}

/**/
.delete_mem input {
	width: 100%;
	padding: 15px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

/* 탈퇴 버튼 */
.delete_mem input[type="submit"] {
	background-color: #285a34;
	color: #fff;
	border: none;
	border-radius: 5px;
	padding: 15px;
	width: 100%;
	cursor: pointer;
	font-weight: 700;
	font-size: 13px;
}

/* 탈퇴 버튼 (커서 O) */
.delete_mem input[type="submit"]:hover {
	background-color: #45a049;
}

/*회원탈퇴칸 */
.delete fieldset {
	background-color: #fff;
	border: none;
	width: 300px;
	padding: 20px;
	margin: 0 auto;
	text-align: center;
}
</style>
</head>
<body>
	<%@ include file="../user/category.jsp"%>

	<form action="delete" method="post">
		<div class="inner">
			<fieldset class="delete_mem">
				<h3>회원탈퇴</h3>
				<p>원활한 회원탈퇴를 위해 아이디와 비밀번호를 입력해주세요.</p>
				<ul>
					<li><input type="text" name="memId"
						placeholder="아이디를 입력해 주세요."></li>
					<li><input type="password" name="memPw"
						placeholder="비밀번호를 입력해 주세요."></li>
					<br>
					<br>
					<li><input type="submit" value="탈퇴하기"></li>
				</ul>
			</fieldset>
		</div>
	</form>

</body>
</html>