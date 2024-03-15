<%@page import="java.util.ArrayList"%>
<%@page import="com.project.model.dao.OrderDAO"%>
<%@page import="com.project.model.vo.DetailVO"%>
<%@page import="java.util.List"%>
<%@page import="com.project.model.vo.OrderVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../user/category.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 상제 조회</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<script>
/* function cancelOrder() {
	alert("지워라~~");
	
	location.href = "deleteOneOrder?orderId=${orderId}"
	location.href = "deleteOneOrder";
} */
</script>
<style>
table {
	border: 1px solid black;
	border-collapse: collapse;
	width: 500px;
}
</style>
<script>
  function confirmCancellation() {
    var confirmation = confirm("주문을 취소하시겠습니까?");
    if (confirmation) {
      // 사용자가 확인을 누른 경우
      // form을 제출
      document.getElementById('cancelOrderForm').submit();
    }
    alert("주문이 취소되었습니다");
  }
  
	function prevPage() {
      
      history.go(-1);
   }
</script>
<body>
	<%
   
   HttpSession session1 = request.getSession();
   MembersVO membersVO = (MembersVO)session.getAttribute("loginUser");
   
%>
	<div class="inner">
		<table>
			<tr>
				<td>주문 번호 [ ${vo.getOrderId()} ]</td>
				<td><input type="button" value="주문취소"
					onclick="confirmCancellation()"></td>
			</tr>
		</table>


		<form id="cancelOrderForm" action="deleteOneOrder">
			<h2>주문 상세 조회</h2>




			<h3>주문자 정보</h3>
			<table border="1">
				<tr>
					<th>주문하신 분</th>
					<td>${loginUser.getName()}</td>
					<!-- 으로 나중에 가져오기 -->
					<th>주문일</th>
					<td>${vo.getOrderdate()}</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>${vo.getRcvPhone()}</td>
					<th>주문상태</th>
					<td>결제완료</td>
				</tr>
				<tr>
					<th>받으실 분</th>
					<td>${vo.getRcvName()}</td>
					<th>배송방법</th>
					<td>택배</td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan="3">${vo.getRcvAddress()}</td>
				</tr>
			</table>

			<h3>상품 정보</h3>
			<table border="1">
				<tr>
					<th>상품명</th>
					<th>수량</th>
					<th>판매가</th>
					<th>상태</th>
				</tr>
				<c:forEach var="vo" items="${detailVOList}">
					<tr>
						<td>${vo.getBookName() }</td>
						<!-- detailVOList에서 가져온 vo -->
						<td>${vo.getBookCnt() }</td>
						<td>${vo.getPrice() }</td>
						<td>결제완료</td>
					</tr>
				</c:forEach>
				<tr>
					<td>합계</td>
					<td>${vo.getTotalCnt() }</td>
					<!-- OrderInfo 저장해놓은 vo -->
					<td>${vo.getTotalPrice() }</td>
					<td></td>
				</tr>
			</table>

			<h3>결제 정보</h3>
			<table border="1">
				<tr>
					<th>결제수단</th>
					<td>${vo.getPayment() }</td>
				</tr>
				<tr>
					<th>결제금액</th>
					<td>${vo.getTotalPrice() }</td>
				</tr>
			</table>

			<br>
			<button type="button" onclick="prevPage()">이전페이지</button>
		</form>
	</div>

</body>
</html>