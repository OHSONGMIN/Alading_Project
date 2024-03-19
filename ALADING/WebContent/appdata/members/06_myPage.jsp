<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알라딩 서점</title>
<script type="text/javascript" src="include/main_login.js"></script>
<script type="text/javascript" src="include/myPage.js"></script>
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

	<div class="inner">
		<div class="mypage">
			<h3>마이페이지</h3>
			<hr>
			<table>
				<tbody>
					<tr>
						<th>아이디</th>
						<td>${ loginUser.getMemId() }</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td>****</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>${ loginUser.name }</td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td>${ loginUser.birth }</td>
					</tr>
					<tr>
						<th>휴대전화번호</th>
						<td>${ loginUser.phone }</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>${ loginUser.address }</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>${ loginUser.email }</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>