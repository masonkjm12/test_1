<%-- [영화 정보 삭제 처리] list.jsp가 전달한 GET movieId를 정수로 읽어 MovieDao.deleteById로 해당 영화 레코드를 DB에서 삭제하고 완료 문구를 출력한다. qnadesign.css 사용. 현재 코드는 영화 DB 레코드 삭제를 처리하며 myimages의 포스터 파일 삭제는 수행하지 않는다. --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.*"%>
<%@page import="com.oreilly.servlet.multipart.*"%>
<%@page import="java.util.*" %>
<%@page import="java.io.*,java.sql.*,my.util.*,my.dao.*,my.model.*" %><!-- my.~java 리소스 연결 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>1:1문의하기</title>
<link href="qnadesign.css" rel="stylesheet" type="text/css">

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
            	<li><a href="#">고객등록</a></li>
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
                <img src="images/title2.jpg" width="464" height="58" alt="고객등록">
                <div class="tablestyle"><!-- myimages에 poster사진 업로드 하는 로직, 궁금한점 딕렉토리 설정시 \\ 두번 입력하는 이유? -->
                <%
                
                int movieId= Integer.parseInt(request.getParameter("movieId"));
                Connection conn=null;
                
                try{
                	conn= ConnectionProvider.getConnection();
                	MovieDao dao= new MovieDao();
                	dao.deleteById(conn, movieId);
                }catch (SQLException e) {
                	e.printStackTrace();
                	out.println("db저장중 오류발생함."+e.getMessage());
                }finally{
                	if(conn!=null){
                		try{conn.close();} catch (SQLException e) {}
                	}
                }

                %>
                삭제 되었습니다
                </div>
         </div>
    </div>


</body>
</html>
