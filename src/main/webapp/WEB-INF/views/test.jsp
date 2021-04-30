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
	
   <div class="header">
      <h5>도서를 검색하세요</h5>
   </div>
   <input id="bookName" placeholder="찾으시는 도서명을 넣어주세요" size="50" type="text">
   <button id="search">검색</button>
   
   <button id='checkBtn'>체크</button>
   
   <p class='result'></p>

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
                  str += "<strong>" + msg.documents[i].title + "</strong>";
                  str += "<img src='" + msg.documents[i].thumbnail +"'>";
               } 
               result.html(str);
            });
         })

      });
      var obj = JSON.parse('{ "이름":"남웅지", "나이":26, "지역":"경기" }')
      document.getElementById("").innerHTML = obj.이름 +","+obj.나이;
      
      
      var input = document.getElementById("bookName");
      input.addEventListener("keyup", function(event) {
          if (event.keyCode === 13) {
              event.preventDefault();
              document.getElementById("search").click();
          }
      });
   </script>
</body>

</body>
</html>