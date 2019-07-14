<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>LGTW - ADMIN</title>

  <link href="${contextPath}/resources/admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<!-- Custom styles for this template -->
	<link href="${contextPath}/resources/admin/css/modern-business.css" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<style>
.content {
	height: auto;
	min-height: calc(100vh - 20px);
}
body {
	padding-right:0 !important;
}
.my-4{
	padding-bottom:20px !important;
}
</style>
</head>

<body>

  <!-- Navigation -->
  <jsp:include page="../common/admin/menubar.jsp"/>


  <!-- Page Content -->
  <div class="container content">

		<!-- <h1 class="my-4" align="center"><b>구현이 불가능한 코드는 없다..다만 수명이 줄어들 뿐이다..</b></h1> -->
		<h1 class="my-4" align="center"><b>10000줄치면 퇴사 가능!!</b></h1>

	    <!-- Marketing Icons Section -->
	    <div class="row">
	      <div class="col-lg-4 mb-4">
	        <div class="card h-100">
	          <h4 class="card-header">상담</h4>
	          <div class="card-body" align="center">
	            <p class="card-text"><b>상담은 항상 친절히 최선을 다해서!</b></p><br>
	            <table class="table table">
	            	<tr align="center">
	            		<th>대기</th>
	            		<th>진행</th>
	            		<th>완료</th>
	            	</tr>
	            	<tr id="consultingTr" align="center">
	            		<td></td>
	            		<td></td>
	            		<td></td>
	            	</tr>
	            </table>
	          </div>
	          <div class="card-footer">
	            <a href="${ contextPath }/consulting.ad" class="btn btn-primary">+ More</a>
	          </div>
	        </div>
	      </div>
	      <div class="col-lg-4 mb-4">
	        <div class="card h-100">
	          <h4 class="card-header">거래처</h4>
	          <div class="card-body" align="center">
	            <p class="card-text"><b>고객사는 갑은 아니지만 을도 아닙니다.</b></p><br>
	            <table class="table table">
	            	<tr align="center">
	            		<th>계약중</th>
	            		<th>계약종료</th>
	            	</tr>
	            	<tr id="clientTr" align="center">
	            		<td>0건</td>
	            		<td>0건</td>
	            	</tr>
	            </table>
	          </div>
	          <div class="card-footer">
	            <a href="${ contextPath }/client.ad" class="btn btn-primary">+ More</a>
	          </div>
	        </div>
	      </div>
	      <div class="col-lg-4 mb-4">
	        <div class="card h-100">
	          <h4 class="card-header">정산</h4>
	          <div class="card-body" align="center">
	            <p class="card-text"><b>받을 돈은 확실하게 받자!</b></p><br>
	            <table class="table table">
	            	<tr align="center">
	            		<th>입금대기</th>
	            	</tr>
	            	<tr id="calculateTr" align="center">
	            		<td>0건</td>
	            	</tr>
	            </table>
	          </div>
	          <div class="card-footer">
	            <a href="${ contextPath }/client.ad" class="btn btn-primary">+ More</a>
	          </div>
	        </div>
	      </div>
	    <!-- /.row -->
	</div>
  </div>
  <!-- /.container -->
  <jsp:include page="../common/admin/footer.jsp"/>
  
  <script>
  	$(function(){
  		$.ajax({
  			url:"selectMainList/ad",
  			success:function(data){
  				for(var key in data.consulting){
  					if(data.consulting[key].status == '대기'){
  						$("#consultingTr").children().eq(0).text(data.consulting[key].count + "건");
  					}
  					if(data.consulting[key].status == '진행'){
  						$("#consultingTr").children().eq(1).text(data.consulting[key].count + "건");
  					}
  					if(data.consulting[key].status == '완료'){
  						$("#consultingTr").children().eq(2).text(data.consulting[key].count + "건");
  					}
  				}
  				
  				for(var key in data.client){
  					if(data.client[key].status == 'Y'){
  						$("#clientTr").children().eq(0).text(data.client[key].count + "개");
  					}
  					if(data.client[key].status == 'N'){
  						$("#clientTr").children().eq(1).text(data.client[key].count + "개");
  					}
  				}
  				
  				$("#calculateTr").children().eq(0).text(data.calculate + "건");
  			}
  		});	
  	});
  
 </script>
 <!-- Bootstrap core JavaScript -->
 <script src="${contextPath}/resources/admin/vendor/jquery/jquery.min.js"></script>
 <script src="${contextPath}/resources/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>