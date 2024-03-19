<%@page import="com.project.*"%>
<%@page import="com.project.model.common.Paging"%>
<%@page import="com.project.model.vo.BookVO"%>
<%@ include file="category.jsp"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
%>
<!-- 검색창에서 검색을 했을 때 나오는 결과(책리스트) -->

<%
Integer datasize = 0;
System.out.println("search : " + request.getAttribute("search"));
System.out.println("searchOption : " + request.getAttribute("searchOption"));
if (request.getAttribute("list") != null) {
	datasize = (Integer) request.getAttribute("size");
	System.out.println("Received parameter: " + datasize);
}
%>

<%
//0. 페이징 처리를 위한 객체(Paging) 생성
try {
	Paging p = new Paging();

	//1. 전체 게시물 수량 구하기
	p.setTotalRecord(datasize);
	p.setTotalPage();
	System.out.println("> 전체 게시글 수 : " + p.getTotalRecord());
	System.out.println("> 전체 페이지 수 : " + p.getTotalPage());

	//2. 현재 페이지 구하기
	String cPage = request.getParameter("cPage");
	if (cPage != null) {
		p.setNowPage(Integer.parseInt(cPage));
	}
	System.out.println("> cPage : " + cPage);
	System.out.println("> paging nowPage : " + p.getNowPage());

	//3. 현재 페이지에 표시할 게시글 시작번호(begin), 끝번호 구하지
	int fixedNumPerPage = 5; // 고정된 페이지당 게시글 수

	p.setEnd(p.getNowPage() * fixedNumPerPage);
	p.setBegin(p.getEnd() - fixedNumPerPage + 1);

	//3-1. (선택적) 끝 번호가 데이터 건수보다 많아지면 데이터 건수와 동일하게 설정
	if (p.getEnd() > p.getTotalRecord()) {
		p.setEnd(p.getTotalRecord());
	}

	System.out.println(">> 시작번호(begin) : " + p.getBegin());
	System.out.println(">> 끝번호(end) : " + p.getEnd());

	//------ 블록(block) 게산하기 -----------------
	//4. 블록 시작페이지, 끝페이지 구하기
	//4-1. 시작페이지 구하기
	int beginPage = (p.getNowPage() - 1) / p.getPagePerBlock() * p.getPagePerBlock() + 1;
	p.setBeginPage(beginPage);
	p.setEndPage(beginPage + p.getPagePerBlock() - 1);

	//4-2. 끝페이지(endPage)가 전체 페이지 수(totalPage) 보다 크면
	// 끝페이지를 전체 페이지 수로 변경처리(설정)
	if (p.getEndPage() > p.getTotalPage()) {
		p.setEndPage(p.getTotalPage());
	}

	System.out.println(">> 시작페이지(beginPage) : " + p.getBeginPage());
	System.out.println(">> 끝페이지(endPage) : " + p.getEndPage());

	System.out.println("p : " + p);
%>
<%
//검색 결과를 데이터베이스 또는 다른 소스에서 가져옴
List<BookVO> searchData = null;
List<BookVO> list = null;

searchData = (List<BookVO>) request.getAttribute("list");
System.out.println("list222searchData : " + searchData);
int begin = p.getBegin() - 1;
list = searchData.subList(begin, p.getEnd());
System.out.println("리스트 : " + list);

// 현재 페이지에 해당하는 데이터만 추출
//List<YourDataClass> currentPageData = searchData.subList(begin, end);
//================================
//현재 페이지 기준으로 DB데이터(게시글) 가져오기
//시작번호(begin), 끝번호(end) 사용해서
//List<BbsVO> list = adminBookDAO.getPageList(p.getBegin(), p.getEnd());
//System.out.println(">> 현재 페이지 글목록(list) : " + list);

//--------------------------
//JSTL, EL 사용을 위해 scope에 데이터 등록(page 영역)
pageContext.setAttribute("list", list);
pageContext.setAttribute("pvo", p);

//(개인적실습) 현재 페이지번호 사용 블록번호 구하고, 블록번호로 시작/끝 페이지 구하기
System.out.println("p : " + p);
} catch (Exception e) {
// 예외 처리: 예외 메시지를 출력하거나 다른 처리를 수행할 수 있음
e.printStackTrace();
// 여기에 예외 처리 로직을 추가하십시오.
}
%>
<!DOCTYPE html>
<script>
	function goBack() {
		location.href = "userSearchAll.jsp"; // userSearchAll.jsp 페이지로 이동
	}
</script>
<%
HttpSession session1 = request.getSession();
MembersVO membersVO = (MembersVO) session.getAttribute("loginUser");
%>
<script>
	function processAction(action) {
		var bookId = document.querySelector("input[name='bookId']").value;
		var quantity = document.querySelector("input[name='quantity']").value;

		if (action === 'orderSelNow') {
<%try {
	if (membersVO.getMemId() == null) {%>
	alert("로그인 후 이용해주세요");
			window.location.href = '../members/02_login.jsp'
<%} else {%>
	url = "orderSelNow?bookId=" + bookId + "&quantity=" + quantity;
<%}
// 로그인한 사용자일 경우 원하는 작업을 수행
// memId 변수에 로그인한 사용자의 아이디가 저장됨
} catch (NullPointerException e) {%>
	alert("로그인 후 이용해주세요");
			window.location.href = '../members/02_login.jsp'
<%}%>
	} else if (action === 'addToCart') {
			alert("장바구니에 추가 버튼을 클릭했습니다. bookId: " + bookId);
<%try {
	if (membersVO.getMemId() == null) {%>
	alert("로그인 후 이용해주세요");
			window.location.href = '../members/02_login.jsp'
<%} else {%>
	$.ajax({
				type : "get",
				url : "addCart",
				dataType : "json",
				data : {
					"bookId" : bookId
				}, //나중에 1대신 bookId로 변경해서 addCartController로 전달함을 표현
				success : function(respData) {
					console.log("받은 데이터 " + respData);
					console.log(respData.list);

					if (confirm("도서를 장바구니에 담았습니다. 장바구니로 이동하시겠습니까?")) {
						location.href = "cart.jsp?quantity=" + quantity;
					} else {

					}
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:" + error);
				}
			})
<%}
// 로그인한 사용자일 경우 원하는 작업을 수행
// memId 변수에 로그인한 사용자의 아이디가 저장됨
} catch (NullPointerException e) {%>
	alert("로그인 후 이용해주세요");
			window.location.href = '../members/02_login.jsp'
<%}%>
	} else if (action === 'addToWishlist') {
			alert("찜 버튼을 클릭했습니다. bookId: " + bookId);
<%try {
	if (membersVO.getMemId() == null) {%>
	alert("로그인 후 이용해주세요");
			window.location.href = '../members/02_login.jsp'
<%} else {%>
	$.ajax({
				type : "get",
				url : "addLike",
				dataType : "json",
				data : {
					"bookId" : bookId
				},
				success : function(respData) {
					console.log("받은 데이터 " + respData);
					console.log(respData.list);
					if (respData.count >= 1) {
						if (confirm("이미 찜 목록에 등록된 도서입니다. 찜 목록으로 이동하시겠습니까?")) {
							location.href = "like.jsp";
						} else {
						}
					} else {
						if (confirm("찜 목록에 등록되었습니다. 찜 목록으로 이동하시겠습니까?")) {
							location.href = "like.jsp?quantity=" + quantity;
						} else {
						}
					}
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:" + error);
				}
			})
<%}
// 로그인한 사용자일 경우 원하는 작업을 수행
// memId 변수에 로그인한 사용자의 아이디가 저장됨
} catch (NullPointerException e) {%>
	alert("로그인 후 이용해주세요");
			window.location.href = '../members/02_login.jsp'
<%}%>
	}

		window.location = url;
	}
</script>
<html>
<div class="inner">
	<head>
<meta charset="UTF-8">
<style>
#bbs table {
	width: 580px;
	margin-left: 10px;
	border-collapse: collapse;
	font-size: 14px;
}

#bbs table caption {
	font-size: 20px;
	font-weight: bold;
	margin-bottom: 10px;
}

#bbs th, #bbs td {
	border: 1px solid black;
	padding: 4px 10px;
	text-align: center;
}

#bbs .align-left {
	text-align: left;
}

.title {
	background-color: #285A34;
}

.no {
	width: 10%;
}

.writer {
	width: 15%;
}

.regdate {
	width: 20%;
}

.hit {
	width: 15%;
}

/*** 페이지 표시 영역 스타일(시작) ***/
.paging {
	list-style: none;
}

.paging li {
	float: left;
	margin-right: 8px;
}

.paging li a {
	text-decoration: none;
	display: block;
	padding: 3px 7px;
	border: 1px solid #285A34;
	font-weight: bold;
	color: black;
}

.paging .disable {
	border: 1px solid silver;
	padding: 3px 7px;
	color: silver;
}

.paging .now {
	border: 1px solid #285A34;
	padding: 3px 7px;
	background-color: #285A34;
}
/*** 페이지 표시 영역 스타일(끝) ***/
</style>
<title>통합검색결과</title>
	</head>

	<body>
		<h6>"${search }"검색결과 입니다.</h6>

		<c:choose>
			<c:when test="${empty list}">
				<p>"${search }"에 대한 검색 결과가 없습니다.</p>
				<button onclick="window.location.href='main.jsp'">검색창으로
					돌아가기</button>
			</c:when>
			<c:otherwise>
				<table class="table table-hover">

					<colgroup>
						<col width="20%">
						<col width="25%">
						<col width="35%">
						<col width="20%">
					</colgroup>

					<tbody>
						<div class="book-info col-md-7 row align-items-center">
							<c:forEach var="vo" items="${list}">
								<tr class="custom-height">
									<td scope="row"><a href="bookListOne?bookId=${vo.bookId}"><img
											class="bookImage"
											src="<c:url value='/upload/${vo.bookImage}' />" alt="Image"></a></td>
									<td class="bookName"><a
										href="bookListOne?bookId=${vo.bookId}">${vo.bookName}</a><br>
									<div class="bookPrice">${vo.price}원</div>카테고리 : ${vo.category}<br>출판사
										: ${vo.publisher}<br>작가 : ${vo.author}</td>
									<td>${vo.details}..</td>

									<td>
										<div class="detailCart p-3">
											<form id="purchaseForm" class="d-flex flex-column "
												method="POST">
												<input type="hidden" name="bookId" value="${list[0].bookId}">
												<div class="numInput d-flex flex-row align-items-center">
													<label class="col" for="quantity">수량:</label> <input
														class="form-control form-control-sm col" type="number"
														id="quantity" name="quantity" value="1" min="1">
												</div>
												<hr class="mt-1 mb-1">
												<div class="orderbtn">
													<button type="button"
														class="btn btn-sm btn-block mt-1 mb-1 one"
														onclick="processAction('orderSelNow')">
														<div class="orderbtn2">바로구매</div>
													</button>
												</div>
												<div class="cartbtn">
													<button type="button"
														class="btn btn-sm btn-block mt-1 mb-1 two"
														onclick="processAction('addToCart')">장바구니 담기</button>
												</div>
												<div class="likebtn">
													<button type="button"
														class="btn btn-light btn-outline-secondary btn-sm btn-block mt-1 mb-1 three"
														onclick="processAction('addToWishlist')">찜하기</button>
												</div>
											</form>
										</div>
									</td>
								</tr>
							</c:forEach>
						</div>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="7">
								<ol class="paging d-flex justify-content-center">
									<%--[이전페이지이동]에 대한 사용여부 처리 --%>
									<c:if test="${pvo.beginPage == 1 }">
										<li class="disable"><<</li>
									</c:if>
									<c:if test="${pvo.beginPage != 1 }">
										<li><a
											href="searchAll?searchOption=${searchOption }&search=${search}&cPage=${pvo.beginPage - 1 }"><<</a>
										</li>
									</c:if>

									<%-- 								[이전으로]에 대한 사용여부 처리
									<c:if test="${cPage == 1 || cPage == null}">
										<li class="disable"><</li>
									</c:if>
									<c:if test="${cPage != 1 && cPage != null}">
										<li><a
											href="searchAll?searchOption=${searchOption }&search=${search}&cPage=${cPage - 1 }"><</a>
										</li>
									</c:if> --%>

									<%--블록내에 표시할 페이지 태그 작성(시작페이지~끝페이지) --%>
									<c:forEach var="pageNo" begin="${pvo.beginPage }"
										end="${pvo.endPage }">
										<c:if test="${pageNo == pvo.nowPage }">
											<li class="now">${pageNo}</li>
										</c:if>
										<c:if test="${pageNo != pvo.nowPage }">
											<li><a
												href="searchAll?searchOption=${searchOption }&search=${search}&cPage=${pageNo }&size=${size}">${pageNo }</a>
											</li>
										</c:if>

									</c:forEach>

									<%-- 					[다음으로]에 대한 사용여부 처리
									<c:if test="${cPage == pvo.totalPage}">
										<li class="disable">></li>
									</c:if>
									<c:if test="${cPage != pvo.totalPage}">
										<li><a
											href="searchAll?searchOption=${searchOption }&search=${search}&cPage=${cPage + 1 }&size=${size}">></a>
										</li>
									</c:if> --%>

									<%--[다음페이지이동]에 대한 사용여부 처리 --%>
									<c:if test="${pvo.endPage >= pvo.totalPage }">
										<li class="disable">>></li>
									</c:if>
									<c:if test="${pvo.endPage < pvo.totalPage }">
										<li><a
											href="searchAll?searchOption=${searchOption }&search=${search}&cPage=${pvo.endPage + 1 }&size=${size}">>></a>
										</li>
									</c:if>
								</ol>

							</td>

						</tr>
					</tfoot>
				</table>
			</c:otherwise>
		</c:choose>

	</body>
	<style>
.bookImage {
	display: block;
	width: 50%;
	margin: 0 auto;
	text-align: center;
}

.btn-block {
	display: block;
	width: 100%;
}

.orderbtn, .cartbtn, .likebtn {
	display: block;
	width: 100%;
}

.btn-group-lg>.btn, .btn-lg {
	padding: 0.5rem 1rem;
	font-size: 0.8rem;
	line-height: 1.5;
	border-radius: 0.3rem;
}

.numInput.d-flex.flex-row {
	width: 100%;
	height: 20px;
	font-size: 0.8em;
	line-height: 1;
}

.table td, .table th {
	padding: 3;
	margin: top;
	vertical-align: middle;
	border-top: 1px solid #dee2e6;
	height: 80px;
	text-align: center;
	.
}

#purchaseForm {
	align-items: center;
}

table a {
	font-size: 1.2em;
	font-weight: 600;
	margin-left: 100;
}

a {
	color: black; /* 링크의 색상을 검정으로 설정 */
}

.bookPrice {
	font-size: 1rem;
	color: dark-red;
	color: darkred;
	font-weight: 600;
}

.h6, h6 {
	font-size: 1.2rem;
	text-align: left;
	margin: 30px;
	margin-top: 50px;
}

button.btn.btn-sm.btn-block.mt-1.mb-1.one {
	background-color: darkred;
	color: white;
}

button.btn.btn-sm.btn-block.mt-1.mb-1.two {
	background-color: #285A34;
	color: white;
}
</style>
</div>
</html>