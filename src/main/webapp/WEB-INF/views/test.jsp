<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">

<title>API 연습</title>
</head>

<body>
	<h1>책 제목 검색해</h1>
	<input id="bookName" type="text">
	<button id="search">검색</button>
	<p></p>

	<script src="https://code.jquery.com/jquery-3.6.0.js"
		integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
		crossorigin="anonymous"></script>

	<script>
		$(function() {

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
					
					$("p").append("<strong>" + msg.documents[0].title + "</strong>");
					$("p").append("<img src='" + msg.documents[0].thumbnail +"'>");
				});
			})

		});
	</script>
</body>

</body>
</html>