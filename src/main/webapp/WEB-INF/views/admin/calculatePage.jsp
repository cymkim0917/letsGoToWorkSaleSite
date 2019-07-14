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
#filterTable td{
	padding-left:20px;
}
.content {
	height: auto;
	min-height: calc(100vh - 20px);
}
#detailModal td{
	padding-bottom:10px;
}
#complateBtn {
	margin-bottom:10px;
}
#addClientTable td {
	padding-left:20px;
}
.modal-footer > button {
	text-align:center !important;
	align:center !important;
	margin-left:auto;
	margin-right:auto;
}
#updateContract td {
	padding-left:20px;
}
body {
	padding-right:0 !important;
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
	<jsp:include page="../common/admin/menubar.jsp" />

	<!-- Content Area -->
	<div class="container content">
	
    <h1 class="mt-4 mb-3">정산관리</h1>
    
    <div class="breadcrumb" style="border:1px solid black;">
    	<div>
    	<form>
	    	<table id="filterTable">
	    		<tr>
	    			<td>기간 : </td>
	    			<td>
	    				<input type="date" id="startDate"> &nbsp;&nbsp;~&nbsp;&nbsp;
	    				<input type="date" id="endDate">
	    			</td>
	    			<td>상태 : </td>
	    			<td>
	    				<select id="option">
	    					<option value="A">전체</option>
	    					<option value="Y">결제완료</option>
	    					<option value="N">대기</option>
	    				</select>
	    			</td>
	    			<td>
	    				<input type="button" value="조회하기" id="search">
	    			</td>
	    		</tr>
	    	</table>
    	</form>
    	</div>
    </div>
	<div>
	<button id="complateBtn" onclick="ok();">일괄처리</button>
		<table class="table table-hover" id="ListTable">
		    <thead>
		      <tr align="center">
		        <th><input type="checkbox" id="allCheck"></th>
		        <th>No.</th>
		        <th>회사명</th>
		        <th>입금자</th>
		        <th>제품</th>
		        <th>금액</th>
		        <th>결제일</th>
		        <th>입금일</th>
		        <th>상태</th>
		      </tr>
		    </thead>
		    <tbody>
		      <c:forEach var="c" items="${ requestScope.list }">
		      	<tr align="center" class="rowTr">
		      		<td><input type="checkbox" class="trCheck"></td>
		      		<td class="click">${ c.calculateNo }</td>
		      		<td class="click">${ c.clientName }</td>
		      		<td class="click">${ c.managerName }</td>
		      		<td class="click">${ c.product }</td>
		      		<td class="click"><fmt:formatNumber type="number" maxFractionDigits="3" value="${c.calculatePrice}"/></td>
		      		<td class="click"><fmt:formatDate value="${c.priceDate}" pattern="yyyy-MM-dd"/></td>
		      		<c:if test="${ c.inputDate == null}">
		      			<td class="click"></td>
		      		</c:if>
		      		<c:if test="${ c.inputDate != null}">
		      			<td class="click"><fmt:formatDate value="${c.inputDate}" pattern="yyyy-MM-dd"/></td>
		      		</c:if>
		      		<c:if test="${ c.calculateType == 'Y'}">
		      			<td class="click">결제완료</td>
		      		</c:if>
		      		<c:if test="${ c.calculateType == 'N'}">
		      			<td class="click">결제대기</td>
		      		</c:if>
		      	</tr>
		      </c:forEach>
		    </tbody>
		  </table>
		  <div class="paging" style="text-align:center">
			<ul class="pagination justify-content-center">
				<c:if test="${ pi.startPage > 1 }">
					<li class="page-item"><a class="page-link" href="${ contextPath }/consulting.ad?currentPage=${ pi.startPage - pi.buttonCount }"><<</a></li>
				</c:if>
				<c:if test="${ pi.startPage <= 1 }">
					<li class="page-item"><a class="page-link" href="#"><<</a></li>
				</c:if>
				<c:if test="${ 1 != pi.currentPage }">
					<li class="page-item"><a class="page-link" href="${ contextPath }/consulting.ad?currentPage=${ pi.currentPage - 1}"><</a></li>
				</c:if>
				<c:if test="${ 1 == pi.currentPage }">
					<li class="page-item"><a class="page-link" href="#"><</a></li>
				</c:if>
				<c:forEach var="pageNum" begin="${ pi.startPage }" end="${ pi.endPage }" step="1">
					<c:if test="${ pageNum == pi.currentPage }">
						<li class="page-item"><a class="page-link">${ pageNum }</a></li>
					</c:if>
					<c:if test="${ pageNum != pi.currentPage }">
						<li class="page-item"><a class="page-link" href="${ contextPath }/consulting.ad?currentPage=${ pageNum }">${ pageNum }</a></li>
					</c:if>
				</c:forEach>
				<c:if test="${ pi.currentPage != pi.maxPage }">
					<li class="page-item"><a class="page-link" href="${ contextPath }/consulting.ad?currentPage=${ pi.currentPage + 1 }">></a></li>
				</c:if>
				<c:if test="${ pi.currentPage == pi.maxPage }">
					<li class="page-item"><a class="page-link" href="#">></a></li>
				</c:if>
				<c:if test="${ pi.endPage != pi.maxPage }">
					<li class="page-item"><a class="page-link" href="${ contextPath }/consulting.ad?currentPage=${ pi.endPage + 1 }">>></a></li>
				</c:if>
				<c:if test="${ pi.endPage == pi.maxPage }">
					<li class="page-item"><a class="page-link" href="#">>></a></li>
				</c:if>
			</ul>
		</div>
	</div>
	
  </div>
	
	<!-- Footer Area -->
	<jsp:include page="../common/admin/footer.jsp" />
	
	
	<!-- 스크립트 영역 -->
	<script>
		$(document).on("click", "#allCheck", function(){
			var check = $(this).is(":checked");
            if(check) {
               $(".trCheck").prop("checked", true);
            } else {
               $(".trCheck").prop("checked", false);
            }
		});
	
		function ok() {
         var result = confirm("정말 승인하시겠습니까?");
         if(result) {
            var no = new Array();
            $(".rowTr").each(function() {
               if($(this).find(".trCheck").is(":checked")) {   
                  console.log($(this).find("td").eq(1).text());
                  no.push($(this).find("td").eq(1).text());
               }
                  
            });
            
            location.href = "${contextPath}/okCalculate.ad?no=" + no;
            
			} else {
				location = location;
			}
		};
		
		$(document).on("click", "#search", function(){
			var startD = $("#startDate").val();
			var endD = $("#endDate").val();
			var option = $("#option").val();
			
			if((startD == "" && endD != "") || (startD > endD)){
				alert("날짜 설정이 잘못되었습니다.");
			}else{
				if(startD == ""){
					startD = "1900-01-01";
					endD = "2200-12-25";
				}
				
				$.ajax({
					url:"searchCalculate/ad/" + startD + "/" + endD + "/" + option,
					type:"get",
					success:function(data){
						$("#ListTable > tbody > tr").remove();
						 var $tbody = $("#ListTable > tbody");
						 
						 for(var key in data.list){
							 var $tr = $("<tr align='center' class='rowTr'>");
							 var $checkTd = $("<td class='click'>").html("<input type='checkbox' class='trCheck'>");
							 var $noTd = $("<td class='click'>").text(data.list[key].calculateNo);
							 var $nameTd = $("<td class='click'>").text(data.list[key].clientName);
							 var $mNameTd = $("<td class='click'>").text(data.list[key].managerName);
							 var $productTd = $("<td class='click'>").text(data.list[key].product);
							 var $calculatePriceTd = $("<td class='click'>").text(comma(data.list[key].calculatePrice));
							 
							 var priceD = new Date(data.list[key].priceDate).format('yyyy-MM-dd');
							 var $priceDateTd = $("<td class='click'>").text(priceD);
							
							 if(data.list[key].inputDate == null){
								 var $inputDateTd = $("<td class='click'>").text("");
							 }else{
								 var inputD = new Date(data.list[key].inputDate).format('yyyy-MM-dd');
								 var $inputDateTd = $("<td class='click'>").text(inputD);
							 }
							 
							 if(data.list[key].calculateType == 'Y'){
								 var $statusTd = $("<td class='click'>").text("결제완료");
							 }else{
								 var $statusTd = $("<td class='click'>").text("결제대기");
							 }
							 
							 $tr.append($checkTd);
							 $tr.append($noTd);
							 $tr.append($nameTd);
							 $tr.append($mNameTd);
							 $tr.append($productTd);
							 $tr.append($calculatePriceTd);
							 $tr.append($priceDateTd);
							 $tr.append($inputDateTd);
							 $tr.append($statusTd);
							 
							 $tbody.append($tr);
						 }
					}
				})
			}
			
			
		});
		
		
		
		
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
     
     function comma(num){
    	    var len, point, str; 
    	       
    	    num = num + ""; 
    	    point = num.length % 3 ;
    	    len = num.length; 
    	   
    	    str = num.substring(0, point); 
    	    while (point < len) { 
    	        if (str != "") str += ","; 
    	        str += num.substring(point, point + 3); 
    	        point += 3; 
    	    } 
    	     
    	    return str;
    	 
    	}
	</script>
	
	
	
	<!-- Bootstrap core JavaScript -->
	<script
		src="${contextPath}/resources/admin/vendor/jquery/jquery.min.js"></script>
	<script
		src="${contextPath}/resources/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>
