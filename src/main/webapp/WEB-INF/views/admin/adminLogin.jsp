<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>LGTW - ADMIN</title>

<style>
.content {
	height: auto;
	min-height: calc(100vh - 20px);
}
body {
	padding-right:0 !important;
}
#loginTable td {
	padding-bottom:5px;
}

</style>
<!-- Bootstrap core CSS -->
<link href="${contextPath}/resources/admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="${contextPath}/resources/admin/css/modern-business.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>


</head>

<body>

	<!-- MenuBar Area -->

	<!-- Content Area -->
	<div class="container content" align="center">
		
    	<h1 class="mt-4 mb-3" align="center"><b>로그인</b></h1>
			<form id="loginForm" action="${ contextPath }/admin.ad" method="post">
				<table id="loginTable">
					<tr id="idTr">
						<td><b>아이디</b></td>
						<td>
							<input type="text" name="empId" id="inputId" placeholder="아이디를 입력하주세요" class="form-control" value="admin"/>
							<input type="hidden" id="hiddenId" value="admin">	
						</td>
					</tr>			
					<tr id="pwdTr">
						<td><b>비밀번호</b></td>
						<td>
							<input type="password" name="empPwd" id="inputPwd" placeholder="비밀번호를 입력해주세요" class="form-control" value="admin"/>
							<input type="hidden" id="hiddenPwd" value="admin">
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center"><button id="loginBtn" onclick="return login();">로그인</button></td>
					</tr>
				</table>
			</form>
    
    </div>
	
	<!-- Footer Area -->
	<jsp:include page="../common/admin/footer.jsp" />
	
	<script>
		function login(){
			var inputId = $("#inputId").val();
			var inputPwd = $("#inputPwd").val();
			var hiddenId = $("#hiddenId").val();
			var hiddenPwd = $("#hiddenPwd").val();
			
			console.log(inputId);
			console.log(hiddenId);
			
			if(inputId != hiddenId){
				alert("아이디가 잘못 되었습니다.");
				return false;
			}else if(inputPwd != hiddenPwd){
				alert("비밀번호가 잘못 되었습니다.");
				return false;
			}
			
		}
	
	</script>
	
	<!-- Bootstrap core JavaScript -->
	<script
		src="${contextPath}/resources/admin/vendor/jquery/jquery.min.js"></script>
	<script
		src="${contextPath}/resources/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>
