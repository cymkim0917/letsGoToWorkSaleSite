<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	
    <h1 class="mt-4 mb-3">상담관리</h1>
    
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
	    			<td>
	    				<input type="button" value="조회하기" onclick="searchDate()">
	    			</td>
	    		</tr>
	    	</table>
    	</form>
    	</div>
    </div>
	<div>
		<table class="table table-hover" id="ListTable">
		    <thead>
		      <tr align="center">
		        <th>No.</th>
		        <th>회사명</th>
		        <th>담당자</th>
		        <th>이메일</th>
		        <th>연락처</th>
		        <th>내용</th>
		        <th>신청일자</th>
		        <th>상태</th>
		      </tr>
		    </thead>
		    <tbody>
		      <c:forEach var="cs" items="${ requestScope.list }">
		      	<tr align="center">
		      		<td>${ cs.requestNo }</td>
		      		<td>${ cs.companyName }</td>
		      		<td>${ cs.managerName }</td>
		      		<td>${ cs.companyMail }</td>
		      		<td>${ cs.managerPhone }</td>
		      		<td>${fn:substring(cs.message,0,7)}...</td>
		      		<td><fmt:formatDate value="${cs.requestDate}" pattern="yyyy-MM-dd"/></td>
		      		<td>${ cs.status }</td>
		      	</tr>
		      </c:forEach>
		    </tbody>
		  </table>
		  <div class="paging" style="text-align:center">
			<ul class="pagination justify-content-center" id="paging">
				<c:if test="${ pi.startPage > 1 }">
					<li class="page-item"><a class="page-link" href="${ contextPath }/consulting.ad?currentPage=${ pi.startPage - pi.buttonCount }"><<</a></li>
				</c:if>
				<c:if test="${ pi.startPage <= 1 }">
					<li class="page-item"><a class="page-link" href="#"><<</a></li>
				</c:if>
				<c:if test="${ 1 != pi.currentPage }">
					<li class="page-item"><a class="page-link" href="${ contextPath }/consulting.ad?currentPage=${ pi.currentPage - 1}"><</a></li>
				</c:if>S
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
	
	<!-- 상담내역 모달 -->
	<button style="display:none" id="chList" data-toggle="modal" data-target="#chModal"></button>
	<div class="modal fade" id="chModal" role="dialog">
	    <div class="modal-dialog">
	    
	      <!-- Modal content-->
	      <div class="modal-content">
	        <div class="modal-header">
	        <h4 class="modal-title">상담이력</h4>
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        <div class="modal-body">
	          <table id="detailModal">
	          	<tr>
	          		<td width="25%"><b>No.</b></td>
	          		<td id="noTd" width="25%"></td>
	          		<td width="25%"><b>회사명</b></td>
	          		<td id="nameTd" width="25%"></td>
				</tr>
				<tr>
					<td><b>담당자</b></td>
	          		<td id="managerTd"></td>
					<td><b>번호</b></td>
					<td id="phoneTd" colspan="2"></td>
				</tr>
				<tr>
					<td ><b>상담내역</b></td>
					<td colspan="3"><button data-dismiss="modal" data-toggle="modal" data-target="#insertCS" onclick="insertHistory();">+ ADD</button></td>
				</tr>
	          </table>
	        </div>
	      </div>
	    </div>
	  </div>
	
    <!-- 상담내역 추가 모달 -->
	<button style="display:none" id="insertConsulting" data-toggle="modal" data-target="#insertCS"></button>
	<div class="modal fade" id="insertCS" role="dialog">
	    <div class="modal-dialog">
	    
	      <!-- Modal content-->
	      <div class="modal-content">
	        <div class="modal-header">
	        <h4 class="modal-title">상담이력 추가</h4>
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        <div class="modal-body">
	          <table id="detailModal">
	          	<tr>
	          		<td width="20%"><b>No.</b></td>
	          		<td width="20%" id="isNo"></td>
	          		<td width="25%"><b>일자</b></td>
	          		<td width="35%"><input type="date" name="chDate" id="isDate"></td>
				</tr>
				<tr>
					<td colspan="4"><b>상담내용</b></td>
				</tr>
				<tr>
					<td colspan="4">
						<textarea cols="60%" rows="10" style="resize: none;" id="isTA">
						
						</textarea>
					</td>
				</tr>
	          </table>
	        </div>
	        <div class="modal-footer">
	          	<button type="button" data-dismiss="modal" onclick="insertCH();">완료</button>
	          	<button type="button" data-dismiss="modal">취소</button>
	          </div>
	      </div>
	    </div>
	  </div>
  </div>
	
	<!-- Footer Area -->
	<jsp:include page="../common/admin/footer.jsp" />
	
	
	<!-- 스크립트 영역 -->
	<script>
		$(document).on("click", "#ListTable > tbody > tr", function(){
			var no = $(this).children().eq(0).text();
			var company = $(this).children().eq(1).text();
			var manager = $(this).children().eq(2).text();
			var phone = $(this).children().eq(4).text();
			
			$.ajax({
				url:"selectDetailCHList/ad/" + no,
				type:"get",
				success:function(data){
					console.log("ajax 성공 영역입니다.");
					console.log(data);
					$("#noTd").text(no);
					$("#nameTd").text(company);
					$("#managerTd").text(manager);
					$("#phoneTd").text(phone);
					
					$(".chTTr").remove();
					$(".chCTr").remove();
					
					var $detailModal = $("#detailModal");
					if(data.length == 0){
						var $nonTr = $("<tr class='chTTr'>");
						var $nonTd = $("<td colspan='4' align='center'>").text("상담 내역이 없습니다.");
						
						$nonTr.append($nonTd);
						$detailModal.append($nonTr);
					}else{
						for(var key in data){
							var date = new Date(data[key].chDate).format("yyyy-MM-dd");
							
							var $titleTr = $("<tr class='chTTr'>");
							var $titleTd = $("<td colspan='3'>").html("<b>" + data[key].chNo + "번            " + date + "</b>");
							$titleTr.append($titleTd);
							
							var $contentTr = $("<tr class='chCTr'>");
							var $contentTd = $("<td colspan='3'>").text(data[key].chContent);
							$contentTr.append($contentTd);
							
							$detailModal.append($titleTr);
							$detailModal.append($contentTr);
						}
					}
					
					$("#chList").trigger("click");
				}
			});
		});
	
		function searchDate(){
			var start = $("#startDate").val();
			var end = $("#endDate").val();
			
			console.log(start);
			console.log(end);
			
			if(start == "" && end == ""){
				location.reload();
			}else if((start == "" && end != "") || end < start){
				alert("날짜 지정이 잘못 되었습니다.");
			}else{
				$.ajax({
					url:"searchConsulting/ad/" + start + "/" + end,
					type:"get",
					success:function(data){
						 console.log(data);
						 $("#ListTable > tbody > tr").remove();
						 var $tbody = $("#ListTable > tbody");
						 
						 for(var key in data.list){
							 var $tr = $("<tr align='center'>");
							 var $noTd = $("<td>").text(data.list[key].requestNo);
							 var $nameTd = $("<td>").text(data.list[key].companyName);
							 var $managerTd = $("<td>").text(data.list[key].managerName);
							 var $mailTd = $("<td>").text(data.list[key].companyMail);
							 var $phoneTd = $("<td>").text(data.list[key].managerPhone);
							 var $contentTd = $("<td>").text(data.list[key].message);
							 var rDate = new Date(data.list[key].requestDate).format("yyyy-MM-dd");
							 var $dateTd = $("<td>").text(rDate);
							 var $statusTd = $("<td>").text(data.list[key].status);
							 
							 $tr.append($noTd);
							 $tr.append($nameTd);
							 $tr.append($managerTd);
							 $tr.append($mailTd);
							 $tr.append($phoneTd);
							 $tr.append($contentTd);
							 $tr.append($dateTd);
							 $tr.append($statusTd);
							 
							 $tbody.append($tr);
						 }
						 
						 
						 
					}
				});
				
				
			}
			
			
		};
		
		function insertHistory(){
			var no = $("#noTd").text();
			console.log(no);
			
			$("#isNo").text(no);
			$("#isDate").val();
			$("#isTA").val();
			
		};
		
		function insertCH(){
			var no = $("#isNo").text();
			var date = $("#isDate").val();
			var content = $("#isTA").val();
			
			console.log(date);
			console.log(content);
			
			location.href = '${contextPath}/insertCH.ad?date=' + date + "&content=" + content + "&no=" + no;
			
		};
		
		
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
	
	
	
	<!-- Bootstrap core JavaScript -->
	<script
		src="${contextPath}/resources/admin/vendor/jquery/jquery.min.js"></script>
	<script
		src="${contextPath}/resources/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>
