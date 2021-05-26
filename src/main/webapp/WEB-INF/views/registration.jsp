<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<title>Insert title here</title>
</head>

<style>
body {
background-color : green;
background-color : rgba(0, 151, 19, 0.3);
}

*[role="form"] {
    max-width: 530px;
    padding: 15px;
    margin: 0 auto;
    background-color: #fff;
    border-radius: 0.3em;
}

*[role="form"] h2 {
    margin-left: 5em;
    margin-bottom: 1em;
}

</style>

<body>

<div class="container">
            <form class="form-horizontal" role="form">
                <h2>회원가입</h2>
                <div class="form-group">
                    <label for="id_name" class="col-sm-3 control-label">아이디</label>
                    <div class="col-sm-9">
                        <input type="text" id="id_Name" placeholder="ID" class="form-control" autofocus>
                        
                    </div>
                </div>
                <div class="form-group">
                    <label for="pw_name" class="col-sm-3 control-label">비밀번호</label>
                    <div class="col-sm-9">
                        <input type="password" id="pw_Name" placeholder="Password" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                   <label for="password" class="col-sm-4 control-label">비밀번호 확인</label>
                    <div class="col-sm-9">
                        <input type="password" id="pwck_Name" placeholder="PasswordCheck" class="form-control">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="birthDate" class="col-sm-3 control-label">Date of Birth</label>
                    <div class="col-sm-9">
                        <input type="date" id="birthDate" class="form-control">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="email" class="col-sm-3 control-label">이메일</label>
                    <div class="col-sm-9">
                        <input type="email" id="email" placeholder="Email" class="form-control">
                    </div>
                </div> <!-- /.form-group -->
                <div class="form-group">
                    <label class="control-label col-sm-3">Gender</label>
                    <div class="col-sm-6">
                        <div class="row">
                            <div class="col-sm-4">
                                <label class="radio-inline">
                                    <input type="radio" id="femaleRadio" value="Female">남</label>
                            </div>
                            <div class="col-sm-4">
                                <label class="radio-inline">
                                    <input type="radio" id="maleRadio" value="Male">여</label>
                            </div>
                        </div>
                    </div>
                </div> <!-- /.form-group -->
                
                <div class="form-group">
                    <div class="col-sm-9 col-sm-offset-3">
                        <button type="submit" class="btn btn-primary btn-block">Register</button>
                    </div>
                </div>
            </form> <!-- /form -->
        </div> <!-- ./container -->

</body>
</html>