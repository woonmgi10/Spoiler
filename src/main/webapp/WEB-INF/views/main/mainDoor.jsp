<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<head>

<link href="../resources/assets/css/bootstrap.min.css" rel="stylesheet" />
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
#container {
	display: grid;
	grid-template-column: repeat(auto-fill, minmax(300px, auto));
}

.card {
	width: 100%;
	height: 99vh;
	background-image: url("/resources/main2.jpg");
	background-repeat: no-repeat;
	background-size: cover;
	background-position: center;
	background-size: cover;
}

.p {
	padding-top: 180px;
	text-align: center;
}

.mainList {
	padding-top: 108px;
	text-align: center;
	font-size: 5.4em;
	font-family: 조선100년체;
	font-weight: bold;
	text-shadow: 3px 3px 3px black;
}
</style>



<body>


	<div id="container">
		<div class="card">
			<div class="mainList" >
				<a href="/free/list" style='color: firebrick;' >Spoiler</a>
			</div>
			<div class="p">
				<div class="d-grid gap-2">
					<button class="btn btn-light" type="button" id="login">Login</button>
					<button class="btn btn-light" type="button">Register</button>
				</div>
			</div>
		</div>
	</div>

	<script>
		$("#login").on("click", function() {
			location = "/customLogin";
		});
	</script>

</body>

</html>