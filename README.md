# Alading_Project

## 💁 프로젝트 소개

알라딩은 온라인 서점입니다. 이용자는 원하는 도서를 구매할 수 있고, 판매자는 자신의 도서를 등록해 이용자들에게 판매할 수 있습니다. 그리고 관리자는 사이트를 통합 관리할 수 있습니다.


## ⏰ 개발 기간

23.10.18 ~ 23.11.01


## ⚙️ 개발 환경

- 언어 / 서버 : Java, JavaScript, JSP, HTML, css, Apache Tomcat
- 프레임워크 / 라이브러리 : MyBatis, JQuery, JSTL, Bootstrap
- 데이터베이스 : Oracle DB
- 도구 : Eclipse, SQL Developer


## 👥 역할 분담
 
- **오송민 : 도서 장바구니 담기, 찜 하기, 도서 구매, 구매내역 관리, (관리자)회원별 주문 내역 관리**
- YJU : 공지사항 등록, 삭제, 공지사항 조회
- LMJ : 회원가입, 로그인, 회원탈퇴, 마이페이지 관리
- JUJ : 도서 등록, 도서 카테고리별 조회, 도서 관리, 리뷰 작성


## 🔍 ERD
<img width="990" alt="스크린샷 2024-03-07 130959" src="https://github.com/OHSONGMIN/Alading_Project/assets/143185293/fcd57acf-adfd-4781-89f7-b79cb76d21b4">

## 📋 프로젝트 구조
```
├─src
│  └─com
│      └─project
│          ├─controller
│          │  ├─admin
│          │  ├─cart
│          │  ├─members
│          │  ├─notice
│          │  └─products
│          ├─model
│          │  ├─common
│          │  ├─dao
│          │  └─vo
│          └─mybatis
└─WebContent
    ├─admin
    ├─appdata
    │  ├─appdata
    │  │  ├─css
    │  │  ├─fonts
    │  │  ├─images
    │  │  └─js
    │  ├─cart
    │  ├─css
    │  ├─error
    │  ├─fonts
    │  ├─images
    │  ├─js
    │  ├─members
    │  │  └─include
    │  ├─notice
    │  ├─order
    │  ├─upload
    │  └─user
    ├─error
    ├─members
    │  └─include
    ├─META-INF
    ├─notice
    ├─order
    ├─upload
    ├─user
    └─WEB-INF
        └─lib
```

## 📌 주요 기능

|메인 페이지|도서 상세 페이지|
|---|---|
|<img width="500" src="https://github.com/OHSONGMIN/Alading_Project/assets/143185293/89557285-7848-4845-bd03-6b43e624129e">|<img width="500" src="https://github.com/OHSONGMIN/Alading_Project/assets/143185293/18e8f253-886c-4fb4-9f90-832e9f12c667">|


|장바구니 목록 페이지|찜 목록 페이지|
|---|---|
|<img width="500" src="https://github.com/OHSONGMIN/Alading_Project/assets/143185293/aea6c6c2-a494-45ab-9cc0-542aaa730d9c">|<img width="500" src="https://github.com/OHSONGMIN/Alading_Project/assets/143185293/abdb29c2-e293-43f4-8c6b-eb8faf8e7cf9">|


|주문/결제 페이지|주문/배송 조회 페이지|
|---|---|
|<img width="500" src="https://github.com/OHSONGMIN/Alading_Project/assets/143185293/f2b7c18c-d32a-4189-9ee5-c4033e37d009">|<img width="500" src="https://github.com/OHSONGMIN/Alading_Project/assets/143185293/b90733b6-240a-4051-9c8f-d01881f944cb">|


|회원 가입 페이지|(관리자)회원별 주문 내역 조회|
|---|---|
|<img width="500" src="https://github.com/OHSONGMIN/Alading_Project/assets/143185293/b7443a76-a583-4904-b9a9-c675f1d0c55f">|<img width="500" src="https://github.com/OHSONGMIN/Alading_Project/assets/143185293/ecbf9505-b0e8-48cb-abb1-c3179b237b22">|




