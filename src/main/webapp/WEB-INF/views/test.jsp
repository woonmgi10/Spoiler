<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">

<title>도서검색</title>

</head>

<body>

	<select>
 		<option value="001">국내도서</option>
 		<option value="002">해외도서</option>
 		<option value="003">ebook</option>
 		<option value="004">e러닝</option>
	</select> 
   
   
   
   <div class="container">도서를 검색하세요</div>
   <input id="bookName" placeholder="찾으시는 도서명을 넣어주세요" size="50" type="text">
   <button id="search">검색</button> <button id='checkBtn'>등록</button>
    
    
    <div class="item"></div>    
    <pre class='result'></pre>

	<div class="pageNation-wrapper clearfix">
	<ul class="pagination float--right" id = "pages"></ul>
	</div>
	
	
   <script src="https://code.jquery.com/jquery-3.6.0.js"
      integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
      crossorigin="anonymous"></script>


   <script>
      $(function() {
         
         const result = $(".result")
         
         $("#checkBtn").click(function() {
        	
        	window.opener.setInfo(result.html());
        	
        	self.close();
         });

         $("#search").click(function() {

            $.ajax({

               method: "GET",
               url : "https://dapi.kakao.com/v3/search/book?target=title",
               data : {
                  query: $("#bookName").val()
               },
               headers: {
                  Authorization : "KakaoAK 550a1e8c8dff65e18919a938938dccb2"
               }
            }).done(function (msg) {
               
               let str = "";
               
               for(var i = 0; i < msg.documents.length; i++) {
            	   str += "<img src='" + msg.documents[i].thumbnail +"'>";
            	   str += "<strong>" + msg.documents[i].title + "</strong>";
            	   str += "<strong>" + msg.documents[i].authors + "</strong>";
            	   str += "<strong>" + msg.documents[i].isbn + "</strong>";
            	   str += "<p></p>";
              <!-- str += "<strong>" +'<button id="submit"></button>' + "</strong>"; -->
            	   str += "<p></p>";
            	   } 
               result.html(str);
            });
         })

      });
      
      var input = document.getElementById("bookName");
      input.addEventListener("keyup", function(event) {
          if (event.keyCode === 13) {
              event.preventDefault();
              document.getElementById("search").click();
          }
      });
      
      
      
   </script>
   
</body>
</html>