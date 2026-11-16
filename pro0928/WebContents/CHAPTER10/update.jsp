<%-- [영화 정보 수정 처리] updateform.jsp의 multipart POST를 MultipartRequest로 파싱해 movieId/title/maker/price/poster를 읽고 선택 파일을 CHAPTER10/myimages에 저장한다. Movie 객체에 기존 ID를 설정한 뒤 MovieDao.update로 DB 정보를 갱신한다. 이후 list.jsp/catalog.jsp에서 수정된 목록을 확인할 수 있다. qnadesign.css 사용. 업로드 경로는 프로젝트 절대경로로 고정되어 있다. --%>
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
                MultipartRequest multi = new MultipartRequest(request, "C:\\temp\\ws\\pro0928\\WebContents\\CHAPTER10\\myimages",
                		5*1024*1024, "utf-8", new DefaultFileRenamePolicy());
                int movieId= Integer.parseInt(multi.getParameter("movieId"));
                String title=multi.getParameter("title");
                String maker=multi.getParameter("maker");
                int price=Integer.parseInt(multi.getParameter("price"));
                String poster=multi.getFilesystemName("poster");
                
                Movie movie=new Movie(title,maker,price,new java.util.Date(),poster);
                movie.setMovieId(movieId);
                Connection conn=null;
                
                try{
                	conn= ConnectionProvider.getConnection();
                	MovieDao dao= new MovieDao();
                	dao.update(conn, movie);
                }catch (SQLException e) {
                	e.printStackTrace();
                	out.println("db저장중 오류발생함."+e.getMessage());
                }finally{
                	if(conn!=null){
                		try{conn.close();} catch (SQLException e) {}
                	}
                }

                %>
                수정이 되었습니다
                title:<%= title %><br>
                maker:<%= maker %><br>
                price:<%= price %><br>
                poster:<%= poster %><br>
                파일업로드가 완료되었습니다
                </div>
         </div>
    </div>


</body>
</html>
