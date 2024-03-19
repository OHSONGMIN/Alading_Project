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
/* 본문 영역 */
.mypage {
	margin: auto;
	padding: 30px;
	width: 400px;
	flex: 1;
}

.mypage h3 {
	padding: 0px;
	text-align: center;
}

table {
	margin: 10px;
	padding: 0px;
	border-collapse: collapse;
	border: none;
	font-size: 13px;
}

table th, table td {
	padding: 5px;
	text-align: left;
	width: 350px;
	border-top: 1px solid;
	border-bottom: 1px solid;
	border-color: #ddd;
}
/*헤더*/
table th {
	width: 200px;
	background-color: #f2f2f2;
	color: #333;
	text-align: center;
	border-right: 1px solid;
	border-right-color: #ddd;
}
</style>
</head>
<body>
	<%@ include file="../user/category.jsp"%>

	<form>
		<div class="inner">
			<div class="mypage">
				<h3>내 정보 수정</h3>
				<hr>
				<table>
					<tbody>
						<tr>
							<th>아이디</th>
							<td>${ loginUser.memId }</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input type="password" name="memPw"
								value="${ loginUser.memPw }"></td>
						</tr>
						<tr>
							<th>비밀번호 확인</th>
							<td><input type="password" name="memPw2"
								value="${ loginUser.memPw }"></td>
						</tr>
						<tr>
							<th>이름</th>
							<td><input type="text" name="name"
								value="${ loginUser.name }"></td>
						</tr>
						<tr>
							<th>생년월일 8자리</th>
							<td><input type="text" name="birth"
								value="${ loginUser.birth }"></td>
						</tr>
						<tr>
							<th>휴대전화번호</th>
							<td><input type="text" name="phone"
								value="${ loginUser.phone }"></td>
						</tr>
						<tr>
							<th>주소</th>
							<td><input type="text" name="address"
								value="${ loginUser.address }"></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><input type="email" name="email"
								value="${ loginUser.email }"></td>
						</tr>
						<tr>
							<td colspan="2"><input type="submit" value="수정하기"></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</form>

</body>
</html>