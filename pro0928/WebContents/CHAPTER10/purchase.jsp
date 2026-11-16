<%-- [구매 처리/완료 페이지] detail.jsp에서 POST한 movieId와 amount를 읽어 MovieDao로 영화 가격/포스터를 조회한다. 가격×수량과 구매일을 Purchase 객체에 담아 PurchaseDao.insert로 구매 DB에 저장하고 완료 화면을 표시한다. 현재 구매자 ID는 로그인 세션이 아닌 "yklee"로 고정되어 있다. design.css 사용. --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.*,java.sql.*,my.util.*,my.dao.*,my.model.*,java.util.*" %>    
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>고객등록 신청서</title>
<link href="design.css" rel="stylesheet" type="text/css">

</head>

<body>

  <div class="page_header">
    	<div class="toplogo"><a href="#"><img src="images/top_logo.jpg" width="276" height="40" alt="beautifullife"></a>
      </div>
        <div class="topnav">
        	<ul>
            	<li><a href="#"><img src="images/top_menu1.jpg" width="72" height="24" alt="ArtStory"></a></li>
                <li><a href="#"><img src="images/top_menu2.jpg" width="76" height="24" alt="ArtStory"></a></li>
                <li><a href="#"><img src="images/top_menu3.jpg" width="64" height="24" alt="ArtStory"></a></li>
                <li><a href="#"><img src="images/top_menu4.jpg" width="134" height="24" alt="ArtStory"></a></li>
                <li><a href="#"><img src="images/top_menu5.jpg" width="99" height="24" alt="ArtStory"></a></li>
                <li><a href="#"><img src="images/top_menu6.jpg" width="52" height="24" alt="ArtStory"></a></li>
            </ul>
        </div>
  </div>
     
     <div class="page_subimg">
     	<div class="subimgline"></div>
        <div class="subimg">
        	<div id="apDivSubimg"></div>
       </div>
     </div>

  <div class="page_content">
    	<div class="leftmenu">
   	    	<img src="images/left_title.jpg" width="152" height="24" alt="membership"> 
        	<ul>
            	<li></li>
            	<li><a href="#">회원가입</a></li>
                <li><a href="#">아이디찾기</a></li>
                <li><a href="#">비번찾기</a></li>
                <li><a href="#">마이페이지</a></li>
                <li><a href="#">1:1문의하기</a></li>
                <li><a href="#">질문내역</a></li>
                <li><a href="#">후기내역</a></li>
                <li><a href="#">쿠폰내격</a></li>
                <li><a href="#">적립금내역</a></li>
            </ul>
        
        
        </div>
        <div class="rightcon">
        <% request.setCharacterEncoding("utf-8"); %>
                <img src="images/title1.jpg" width="464" height="58" alt="고객등록">
                <div class="tablestyle">
          <%
          	Connection conn = ConnectionProvider.getConnection();
          	int movieId = Integer.parseInt(request.getParameter("movieId"));
          	int amount = Integer.parseInt(request.getParameter("amount"));
          	String loginId= (String)session.getAttribute("LOGIN");
          	Movie movie = null;
          	
          	try {
          		MovieDao dao = new MovieDao();
          		movie = dao.selectById(conn, movieId);
          		Purchase purchase = new Purchase(loginId, movieId, amount, movie.getPrice()*amount, new java.util.Date());
          		PurchaseDao pDao = new PurchaseDao();
          		dao.updateFreq(conn, movieId);
          		pDao.insert(conn, purchase);
          		
          	}catch(SQLException e){
          		e.printStackTrace(); // 콘솔에 에러 내용 출력
          	    out.println("<script>alert('DB 처리 중 오류가 발생했습니다.');</script>"); // 화면에 알림창
          	}
          	finally{
            	JdbcUtil.close(conn);
            }
          %> 
          <c:set var="movie" value="<%=movie%>"/>     
          
                  <div class="bigposter"><img src="./myimages/${movie.poster}" width="300" height="350"></div>
                  <div class="desc">
                    구매가 완료되었습니다. 감사합니다. 
                  </div>
               
                   
             
                </div>
         </div>
    </div>


</body>
</html>
