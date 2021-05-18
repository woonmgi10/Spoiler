<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8" />
<link rel="apple-touch-icon" sizes="76x76"
	href="../resources/assets/img/apple-icon.png">
<link rel="icon" type="image/png"
	href="../resources/assets/img/favicon.png">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>도서정보</title>
<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'
	name='viewport' />
<!--     Fonts and icons     -->
<link
	href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200"
	rel="stylesheet" />
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css"
	rel="stylesheet">
<!-- CSS Files -->
<link href="../resources/assets/css/bootstrap.min.css" rel="stylesheet" />
<link href="../resources/assets/css/paper-dashboard.css?v=2.0.1"
	rel="stylesheet" />
<!-- CSS Just for demo purpose, don't include it in your project -->
<link href="../resources/assets/demo/demo.css" rel="stylesheet" />

<!--   Core JS Files   -->
<!--  <script src="../resources/assets/js/core/jquery.min.js"></script> -->
<script src="../resources/assets/js/core/popper.min.js"></script>
<script src="../resources/assets/js/core/bootstrap.min.js"></script>
<!-- Chart JS -->
<script src="../resources/assets/js/plugins/chartjs.min.js"></script>
<!--  Notifications Plugin    -->
<script src="../resources/assets/js/plugins/bootstrap-notify.js"></script>
<!-- Control Center for Now Ui Dashboard: parallax effects, scripts for the example pages etc -->

<script src="../resources/assets/demo/demo.js"></script>

</head>

<body class="">
	<div class="wrapper ">
		<div class="sidebar" data-color="white" data-active-color="danger">
			<div class="logo">
				<a href="https://www.creative-tim.com" class="simple-text logo-mini">
					<div class="logo-image-small">
						<img src="../resources/assets/img/logo-small.png">
					</div> <!-- <p>CT</p> -->
				</a> <a href="/main/mainDoor"
					class="simple-text logo-normal"> Spoiler <!-- <div class="logo-image-big">
            <img src="../assets/img/logo-big.png">
          </div> -->
				</a>
			</div>
			<div class="sidebar-wrapper">
				<ul class="nav">
					<li><a href="./dashboard.html"> <i
							class="nc-icon nc-book-bookmark"></i>
							<p>Review Board</p>
					</a></li>
					<li><a href="./icons.html"> <i class="nc-icon nc-chat-33"></i>
							<p>Free Board</p>
					</a></li>
					<li><a href="./icons.html"> <i class="nc-icon nc-bell-55"></i>
							<p>Report Board</p>
					</a></li>
					<li><a href="./icons.html"> <i class="nc-icon nc-alert-circle-i"></i>
							<p>Book Information</p>
					</a></li>

				</ul>
			</div>
		</div>

		<div class="main-panel">
			<!-- Navbar -->
			<nav
				class="navbar navbar-expand-lg navbar-absolute fixed-top navbar-transparent">
				<div class="container-fluid">
					<div class="navbar-wrapper">
						<div class="navbar-toggle">
							<button type="button" class="navbar-toggler">
								<span class="navbar-toggler-bar bar1"></span> <span
									class="navbar-toggler-bar bar2"></span> <span
									class="navbar-toggler-bar bar3"></span>
							</button>
						</div>
						<a class="navbar-brand" href="/free/list">도서정보</a>
					</div>
					<button class="navbar-toggler" type="button" data-toggle="collapse"
						data-target="#navigation" aria-controls="navigation-index"
						aria-expanded="false" aria-label="Toggle navigation">
						<span class="navbar-toggler-bar navbar-kebab"></span> <span
							class="navbar-toggler-bar navbar-kebab"></span> <span
							class="navbar-toggler-bar navbar-kebab"></span>
					</button>
					<div class="collapse navbar-collapse justify-content-end"
						id="navigation">
						
						
						<ul class="navbar-nav">
						<li class="dropdown">
						<a class="dropdown-toggle" id="navbarDropdownMenuLink" data-toggle="dropdown" href="#"  aria-haspopup="true" aria-expanded="false">
						<i class="nc-icon nc-circle-10"></i>
						
						</a>
							<ul class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">
								<li class="dropdown-item"><a href="#"><i class="nc-icon nc-circle-10" ></i>   User
										Profile</a></li>
								<li class="dropdown-item"><a href="#"><i class="nc-icon nc-settings-gear-65"></i>   Settings</a></li>


								<li class="divider"></li>
								<sec:authorize access="isAuthenticated()">

									<li class="dropdown-item"><a href="/customLogout"><i
											class="nc-icon nc-lock-circle-open"></i>Logout</a></li>
								</sec:authorize>

								<sec:authorize access="isAnonymous()">

									<li class="dropdown-item"><a href="/customLogin"><i class="nc-icon nc-key-25"></i>   Login</a></li>
								</sec:authorize>
							</ul> <!-- /.dropdown-user -->
							</li>
							</ul>

						
					</div>
				</div>
			</nav>