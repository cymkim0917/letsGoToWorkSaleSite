<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>LGTW - ADMIN</title>

<!-- Bootstrap core CSS -->
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
#filterYear {
	width: 55px !important;
}
#titleLi {
	margin-top: 3px !important;
	color:black !important;
}
.breadcrumb {
	border: 1px solid black !important;
}

</style>
</head>

<body>

	<!-- MenuBar Area -->
	<jsp:include page="../common/admin/menubar.jsp" />

    <div class="container content">
		<h1 class="mt-4 mb-3">통계관리</h1>

        <!-- Breadcrumbs-->
        <ol class="breadcrumb">
          <li class="breadcrumb-item active" id="titleLi"><b>년도 : </b></li> &nbsp;&nbsp;&nbsp;&nbsp;
          <li><select id="filterSelect">
          	
          </select></li> &nbsp;&nbsp;&nbsp;&nbsp;
          <li><button onclick="filterDate()">조회하기</button></li>
        </ol>

        <!-- Area Chart Example-->
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-chart-area"></i>
            <b>매출</b></div>
          <div class="card-body">
            <canvas id="myAreaChart" width="100%" height="30"></canvas>
          </div>
        </div>

        <div class="row">
          <div class="col-lg-8">
            <div class="card mb-3">
              <div class="card-header">
                <i class="fas fa-chart-bar"></i>
                <b>상담</b></div>
              <div class="card-body">
                <canvas id="myBarChart" width="100%" height="50"></canvas>
              </div>
            </div>
          </div>
          <div class="col-lg-4">
            <div class="card mb-3">
              <div class="card-header">
                <i class="fas fa-chart-pie"></i>
                <b>제품 별 고객사</b></div>
              <div class="card-body">
                <canvas id="myPieChart" width="100%" height="100"></canvas>
              </div>
            </div>
          </div>
        </div>

      </div>
    <!-- /.content-wrapper -->
	
	<!-- Footer Area -->
	<jsp:include page="../common/admin/footer.jsp" />
	
	<script>
	
	$(function(){
		var date = new Date().format("yyyy");
		
		for(var i = date; i >= 2017; i--){
			$("#filterSelect").append($("<option value='" + i + "'>").text(i));	
		}
		
		selectDate(date);
	});
	
	function selectDate(date){
		
		$.ajax({
			url:"selectChartList/ad/" + date,
			type:"get",
			success:function(data){
				
				/* 월별 매출 */
				var money = new Array();
				for(var i = 0; i < 12; i++) {
					for(var key in data.money){
						if(i < 10) {
							if('0' + (i + 1) == data.money[key].month) {
								console.log(data.money[key].price);
								money[i] = data.money[key].price;
							}
						}else {
							if((i + 1) == data.money[key].month) {
								console.log(data.money[key].price);
								money[i] = data.money[key].price;
							}
						}
						if(money[i] == null) {
							money[i] = 0;
						}
					}					
				}
				
				var maxP = 0;
				for(var i = 1; i <= money.length; i++){
					if(money[i] > money[i - 1]){
						maxP = money[i];
					}
				}
				
				console.log(money);
				
				myLineChart.config.data.datasets[0].data = money;
				myLineChart.config.options.scales.yAxes[0].ticks.max = maxP + 100000;
				myLineChart.update();
				
				
				/* 월별 상담 건수 */
				var consulting = new Array();
				for(var i = 0; i < 12; i++) {
					for(var key in data.consulting){
						if(i < 10) {
							if('0' + (i + 1) == data.consulting[key].month) {
								console.log(data.consulting[key].consulting);
								consulting[i] = data.consulting[key].consulting;
							}
						}else {
							if((i + 1) == data.money[key].month) {
								console.log(data.consulting[key].consulting);
								consulting[i] = data.consulting[key].consulting;
							}
						}
						if(consulting[i] == null) {
							consulting[i] = 0;
						}
					}					
				}
				
				var maxC = 0;
				for(var i = 1; i <= consulting.length; i++){
					if(consulting[i] > consulting[i - 1]){
						maxC = consulting[i];
					}
				}
				
				myBarChart.config.data.datasets[0].data = consulting;
				myBarChart.config.options.scales.yAxes[0].ticks.max = maxC + 10;
				myBarChart.update();
				
				/* 월별 제품 */
				var client = new Array();
				for(var i = 0; i < 3; i++) {
					for(var key in data.client){
						if(data.client[key].product == '베이직'){
							client[0] = data.client[key].clientCount;
						}else if(data.client[key].product == '프리미엄'){
							client[1] = data.client[key].clientCount;
						}else{
							client[2] = data.client[key].clientCount;
						}
						if(client[i] == null) {
							client[i] = 0;
						}
					}					
				}
				console.log(client);
				myPieChart.config.data.datasets[0].data = client;
				myPieChart.update();
				
			}
		});
		
	};
	
	function filterDate(){
		var date = $("#filterSelect").val();
		
		selectDate(date);
	}
	
	
	Date.prototype.format = function(f) {
  	    if (!this.valueOf()) return " ";
  	 
  	    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
  	    var d = this;
  	     
  	    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
  	        switch ($1) {
  	            case "yyyy": return d.getFullYear();
  	            case "yy": return (d.getFullYear() % 1000).zf(2);
  	            case "MM": return (d.getMonth() + 1).zf(2);
  	            case "dd": return d.getDate().zf(2);
  	            case "E": return weekName[d.getDay()];
  	            case "HH": return d.getHours().zf(2);
  	            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
  	            case "mm": return d.getMinutes().zf(2);
  	            case "ss": return d.getSeconds().zf(2);
  	            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
  	            default: return $1;
  	        }
  	    });
  	};
  	 
  	String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
  	String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
  	Number.prototype.zf = function(len){return this.toString().zf(len);
 };
	</script>






  <script
		src="${contextPath}/resources/admin/vendor/jquery/jquery.min.js"></script>
  <script
		src="${contextPath}/resources/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Page level plugin JavaScript-->
  <script src="${ contextPath }/resources/admin/vendor/chart.js/Chart.min.js"></script>

  <!-- Demo scripts for this page-->
  <script src="${ contextPath }/resources/admin/js/demo/chart-area-demo.js"></script>
  <script src="${ contextPath }/resources/admin/js/demo/chart-bar-demo.js"></script>
  <script src="${ contextPath }/resources/admin/js/demo/chart-pie-demo.js"></script>

</body>

</html>
