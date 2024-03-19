<%@page import="com.project.model.vo.MembersVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<%-- 신간도서카테고리를 눌렀을 때 나오는 카테고리와 책리스트--%>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
#book {
	margin-right: auto;
}

td {
	padding: 5px;
}
</style>
<script>
   $(document).ready(function(){
      // 페이지가 로드될 때 "종합" 카테고리의 데이터를 처음부터 로드
       ajaxGetSelectNewAll();
      
    // 버튼 클릭 이벤트 핸들러 등록
       $("#getDataBtn").on("click", function() {
           ajaxGetSelectNewAll();
       });
   });

   function ajaxGetSelectNewAll() {
      //alert(">> ajaxGetSelectBestBook() 실행~~");
      
      $.ajax("getSelectBook?type=new", {
         type : "get",
         dataType : "json", //응답 받을 데이터 타입(형식)
         success : function(respData){
            //alert(">> Ajax 처리 성공 - 응답받은 데이터 : " + respData);
            console.log(respData);
            console.log(respData.list);
            
            //전달받은 JSON 데이터 사용 tr 태그 만들고 화면출력
            let htmlTag = "";
            let alist = respData.list; //JSON 객체의 속성명 "list"의 값 추출
            $.each(alist, function(index, book){
               //console.log("this.name : " + this.name);
               //console.log("member.name : " + member.name);
                // 이미지 크기 변경
                  
                   let isSoldOut = (this.bookCnt == 0);
                   let buttonText = isSoldOut ? "품절" : "장바구니";
                   let isDisabled = isSoldOut ? "disabled" : ""; // 품절 시 버튼을 비활성화 상태로 설정
                   
                   let imageTag = "<img src='../upload/" + this.bookImage + "' alt='Image' >";
               htmlTag += "<tr>";
               htmlTag += "<td>" + imageTag + "</td>";
               htmlTag += "<td><a href='bookListOne?bookId=" + this.bookId + "'>" + this.bookName + "</td>";
               htmlTag += "<td>" + this.publisher + "</td>";
               htmlTag += "<td>" + this.author + "</td>";
               htmlTag += "<td><div class=priceColor>" + this.price + " 원 </div><button type='button' id='inprice' class='btn btn-primary btn-block' onclick='addLike(" + this.bookId + ")'>찜</button><button type='button' id='inprice2' class='btn btn-secondary btn-block' " + isDisabled + " onclick='if(!$(this).is(\":disabled\")) { addCart(" + this.bookId + "); }'>" + buttonText + "</button></td>";
                   
               htmlTag += "</tr>";
            });
            $("#dispData").html(htmlTag);
         },
         error : function(jqXHR, textStatus, errorThrown){
            alert(">> Ajax 처리 실패 : \n"
                  + "jqXHR.readyState : " + jqXHR.readyState + "\n"
                  + "textStatus : " + textStatus + "\n"
                  + "errorThrown : " + errorThrown);
         }
      });
   }
   
   function ajaxGetSelectNewOne(category) {
      //alert(">> getJsonMembersName 실행~~ 이름 : " + category);
      //alert(">> encodeURIComponent(name) : " + encodeURIComponent(category));
      
      $.ajax("getSelectBestOne?type=new", {
         type : "get",
         data : "category=" + encodeURIComponent(category), //서버로 전달하는 데이터
         dataType : "json", //응답 받는 데이터 타입
         success : function(data) {
            
            //alert("Ajax 처리 성공 - 응답받은 데이터 : " + data);
            let htmlTag = "";
            let alist = data.list; 
            $.each(alist, function(index, category){
               //console.log("this.name : " + this.name);
               //console.log("member.name : " + member.name);
               
                   
                   let isSoldOut = (this.bookCnt == 0);
                   let buttonText = isSoldOut ? "품절" : "장바구니";
                   let isDisabled = isSoldOut ? "disabled" : ""; // 품절 시 버튼을 비활성화 상태로 설정
                   
                   let imageTag = "<img src='../upload/" + this.bookImage + "' alt='Image'>";
               console.log(this.bookId);
               htmlTag += "<tr>";
               htmlTag += "<td>" + imageTag + "</td>";
               htmlTag += "<td><a href='bookListOne?bookId=" + this.bookId + "'>" + this.bookName + "</a></td>";
               htmlTag += "<td>" + this.publisher + "</td>";
               htmlTag += "<td>" + this.author + "</td>";
               htmlTag += "<td><div class=priceColor>" + this.price + " 원 </div><button type='button' id='inprice' class='btn btn-primary btn-block' onclick='addLike(" + this.bookId + ")'>찜</button><button type='button' id='inprice2' class='btn btn-secondary btn-block' " + isDisabled + " onclick='if(!$(this).is(\":disabled\")) { addCart(" + this.bookId + "); }'>" + buttonText + "</button></td>";

               htmlTag += "</tr>";
            });
            $("#dispData").html(htmlTag);
         },
         error : function(jqXHR, textStatus, errorThrown){
            alert(">> Ajax 처리 실패 : \n"
                  + "jqXHR.readyState : " + jqXHR.readyState + "\n"
                  + "textStatus : " + textStatus + "\n"
                  + "errorThrown : " + errorThrown);
         }
      });
   }
   <%
   
   HttpSession session1 = request.getSession();
   MembersVO membersVO = (MembersVO)session.getAttribute("loginUser");
   
   %>


   function addCart(bookId){    
    // bookId를 사용하여 원하는 작업을 수행
    alert("장바구니에 추가 버튼을 클릭했습니다. bookId: " + bookId);

   <%
   try {
        if (membersVO.getMemId() == null) {
    %>
         alert("로그인 후 이용해주세요");
         window.location.href = '../members/02_login.jsp'
   <%
      
   }else {%>
        $.ajax({
          type : "get",
          url : "addCart",
          dataType : "json",
          data : {"bookId": bookId}, //나중에 1대신 bookId로 변경해서 addCartController로 전달함을 표현
          success : function(respData){
         console.log("받은 데이터 " + respData);
            console.log(respData.list);
            

            if(confirm("도서를 장바구니에 담았습니다. 장바구니로 이동하시겠습니까?")) {
                location.href = "cart.jsp";
         } else {
             
         }
      },
      error : function(request, status, error){
         alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
          }   
       })
<%  }
        // 로그인한 사용자일 경우 원하는 작업을 수행
        // memId 변수에 로그인한 사용자의 아이디가 저장됨
    } catch (NullPointerException e) {
%>
      alert("로그인 후 이용해주세요");
      window.location.href = '../members/02_login.jsp'
<%
        
    }
%>
   
}


   function addLike(bookId){    
       // bookId를 사용하여 원하는 작업을 수행
       alert("찜 버튼을 클릭했습니다. bookId: " + bookId);

      <%
      try {
           if (membersVO.getMemId() == null) {
       %>
            alert("로그인 후 이용해주세요");
            window.location.href = '../members/02_login.jsp'
      <%
         
      }else {%>
         $.ajax({
            type : "get",
            url : "addLike",
            dataType : "json",
            data : {"bookId": bookId}, 
            success : function(respData){
               console.log("받은 데이터 " + respData);
                  console.log(respData.list);
               if (respData.count >= 1) {
                  if(confirm("이미 찜 목록에 등록된 도서입니다. 찜 목록으로 이동하시겠습니까?")) {
                     location.href = "like.jsp";
                  } else { }
                    } else {
                     if(confirm("찜 목록에 등록되었습니다. 찜 목록으로 이동하시겠습니까?")) {
                     location.href = "like.jsp";
                  } else { }
                  }
            },
            error : function(request, status, error){
                 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }   
         })
   <%  }
           // 로그인한 사용자일 경우 원하는 작업을 수행
           // memId 변수에 로그인한 사용자의 아이디가 저장됨
       } catch (NullPointerException e) {
   %>
         alert("로그인 후 이용해주세요");
         window.location.href = '../members/02_login.jsp'
   <%
           
       }
   %>
      
   };
</script>

<title>베스트 도서 카테고리</title>

</head>
<style>
button:hover {
	background-color: #285a34;
	color: #eee;
}

table {
	text-align: center;
}
</style>
<body>

	<%@ include file="category.jsp"%>

	<div class="inner mt-5">

		<div class="row">
			<div class="col-3">
				<ul class="nav nav-pills nav-fill flex-column"
					style="background-color: #f7f8f9;" id="myTab" role="tablist">
					<li class="nav-item" role="presentation">
						<button class="nav-link active btn-lg btn-block">신간도서
							TOP</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link btn-lg btn-block" id="getDataBtn">종합</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link btn-lg btn-block"
							onclick="ajaxGetSelectNewOne('인문과학')">인문과학</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link btn-lg btn-block"
							onclick="ajaxGetSelectNewOne('소설')">소설</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link btn-lg btn-block"
							onclick="ajaxGetSelectNewOne('어린이')">어린이</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link btn-lg btn-block"
							onclick="ajaxGetSelectNewOne('경제경영')">경제경영</button>
					</li>
				</ul>
			</div>
			<table class="table table-hover col-9" border="1">
				<colgroup>
					<col width="10%">
					<col width="20%">
					<col width="20%">
					<col width="20%">
					<col width="20%">
				</colgroup>
				<thead>
					<tr class="thead-light">
						<th>책이미지</th>
						<th>책이름</th>
						<th>출판사</th>
						<th>작가</th>
						<th>가격</th>
					</tr>
				</thead>
				<tbody id="dispData"></tbody>



			</table>
		</div>
	</div>

	<style>
.nav-pills .nav-link.active {
	background-color: #285a34;
}

.table td {
	vertical-align: middle;
}

#inprice {
	font-size: 12px;
	padding: 5px 5px 5px 5px;
	margin-top: 10px;
}

.table img {
	display: block;
	max-width: 110px;
}

#inprice {
	font-size: 12px;
	padding: 5px 5px 5px 5px;
	margin-top: 10px;
}

#inprice2 {
	font-size: 12px;
	padding: 5px 5px 5px 5px;
	margin-top: 10px;
}

.table img {
	display: block;
	max-width: 110px;
}

#inprice {
	background-color: #285A34;
	border: none;
}

#inprice2 {
	background-color: white;
	color: black;
}

table a {
	color: black;
	font-weight: bold;
}

.priceColor {
	color: darkred;
	font-weight: bold;
}
</style>
</body>
</html>