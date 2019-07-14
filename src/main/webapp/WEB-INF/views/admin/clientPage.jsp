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
#addClient {
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
	
    <h1 class="mt-4 mb-3">고객사관리</h1>
    
    <div class="breadcrumb" style="border:1px solid black;">
    	<div>
    	<form>
	    	<table id="filterTable">
	    		<tr>
	    			<td>구분</td>
	    			<td>
	    				<select id="filterSelect">
	    					<option value="A">전체</option>
	    					<option value="Y">계약중</option>
	    					<option value="N">게약종료</option>
	    				</select>
	    			</td>
	    			<td>
	    				<button type="button" id="search">조회하기</button>
	    			</td>
	    		</tr>
	    	</table>
    	</form>
    	</div>
    </div>
	<div>
		<button id="addClient" data-toggle="modal" data-target="#addClientModal">ADD+</button>
		<table class="table table-hover" id="ListTable">
		    <thead>
		      <tr align="center">
		        <th>No.</th>
		        <th>회사명</th>
		        <th>담당자</th>
		        <th>이메일</th>
		        <th>연락처</th>
		        <th>제품</th>
		        <th>서비스 시작일</th>
		        <th>상태</th>
		        <th>계약서</th>
		      </tr>
		    </thead>
		    <tbody>
		      <c:forEach var="c" items="${ requestScope.list }">
		      	<tr align="center">
		      		<td class="click">${ c.clientNo }</td>
		      		<td class="click">${ c.clientName }</td>
		      		<td class="click">${ c.managerName }</td>
		      		<td class="click">${ c.managerMail }</td>
		      		<td class="click">${ c.managerPhone }</td>
		      		<td class="click">${ c.product }</td>
		      		<td class="click"><fmt:formatDate value="${c.startDate}" pattern="yyyy-MM-dd"/></td>
		      		<c:if test="${ c.status == 'Y'}">
		      			<td class="click">계약중</td>
		      		</c:if>
		      		<c:if test="${ c.status != 'Y'}">
		      			<td class="click">계약종료</td>
		      		</c:if>
		      		<td class="download">
		      			<button>다운로드</button>
		      		</td>
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
	
	<!-- 상담내역 모달 -->
	<button style="display:none" id="cList" data-toggle="modal" data-target="#cModal"></button>
	<div class="modal fade" id="cModal" role ="dialog">
	    <div class="modal-dialog">
	    
	      <!-- Modal content-->
	      <div class="modal-content">
	        <div class="modal-header">
	        <h4 class="modal-title">거래처 상세보기</h4>
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
					<td><b>이메일</b></td>
					<td colspan="3" id="mainTd"></td>
				</tr>
				<tr>
					<td><b>제품</b></td>
					<td id="productTd"></td>
					<td><b>결제단위</b></td>
					<td id="payTd"></td>
				</tr>
				<tr>
					<td><b>시작일</b></td>
					<td id="startTd"></td>
					<td class="end"><b>종료일</b></td>
					<td class="end" id="endTd"></td>
				</tr>
				<tr>
					<td><b>도메인</b></td>
					<td id="domainTd"></td>
					<td><b>DB</b></td>
					<td id="dbTd"></td>
				</tr>
				<tr>
					<td><b>인원제한</b></td>
					<td id="userTd"></td>
					<td><b>상태</b></td>
					<td id="statusTd"></td>
				</tr>
	          </table>
	        </div>
	        <div class="modal-footer">
	          	<button data-dismiss="modal" onclick="reContract();">갱신</button>
	          	<button data-dismiss="modal" onclick="endContract();">종료</button>
	          	<button data-dismiss="modal">취소</button>
	          </div>
	      </div>
	    </div>
	  </div>
	  
	  <!-- 계약갱신 모달 -->
		<button style="display:none" id="updateContractBtn" data-toggle="modal" data-target="#reContract"></button>
		<div class="modal fade" id="reContract" role ="dialog">
		    <div class="modal-dialog modal-lg">
		    
		      <!-- Modal content-->
		      <div class="modal-content">
		        <div class="modal-header">
		        <h4 class="modal-title">재계약 정보</h4>
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        <form action="updateContract.ad" method="post" encType="multipart/form-data">
		        <div class="modal-body">
		          <table id="updateContract">
		          	<tr>
		          		<td width="20%"><b>No.</b></td>
		          		<td id="reNoTd" width="30%"><input type="text" name="clientNo" readonly></td>
		          		<td width="20%"><b>회사명</b></td>
		          		<td width="30%" id="reNameTd"><input type="text" name="clientName"></td>
					</tr>
					<tr>
						<td><b>담당자</b></td>
		          		<td id="reManagerTd"><input type="text" name="managerName"></td>
						<td><b>번호</b></td>
						<td id="rePhoneTd" colspan="2"><input type="text" name="managerPhone"></td>
					</tr>
					<tr>
						<td><b>이메일</b></td>
						<td colspan="3" id="reMailTd"><input type="text" name="managerMail"></td>
					</tr>
					<tr>
						<td><b>제품</b></td>
						<td id="reProductTd">
							<select name="product" id="updateSelect">
								<option value="베이직">베이직</option>
								<option value="프리미엄">프리미엄</option>
								<option value="커스텀">커스텀</option>
							</select>
						</td>
						<td><b>결제단위</b></td>
						<td id="rePayTd"><input type="text" name="paymentType"></td>
					</tr>
					<tr>
						<td class="end"><b>종료일</b></td>
						<td colspan="3" class="end" id="reEndTd"><input type="date" name="endDate"></td>
					</tr>
					<tr>
						<td><b>도메인</b></td>
						<td id="reDomainTd"><input type="text" name="domainUrl"></td>
						<td><b>인원제한</b></td>
						<td id="reUserTd"><input type="text" name="maxUser"></td>
					</tr>
					<tr>
						<td><b>계약서</b></td>
						<td colspan="3">
							<input type="file" name="contract">
						</td>
					</tr>
		          </table>
		        </div>
		        <div class="modal-footer">
		          	<button type="submit">확인</button>
		          	<button data-dismiss="modal" type="reset">취소</button>
		        </div>
		        </form>
		      </div>
		    </div>
		  </div>
	  
	  <!-- 거래처 추가 모달 -->
	  <div class="modal fade" id="addClientModal" role="dialog">
	    <div class="modal-dialog modal-lg">
	    
	      <!-- Modal content-->
	      <div class="modal-content">
	        <div class="modal-header">
	        <h4 class="modal-title">거래처 추가</h4>
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        <div class="modal-body">
	        <form action="insertClient.ad" method="post" encType="multipart/form-data">
	          <table id="addClientTable">
	          	<tr>
	          		<td width="20%"><b>회사명</b></td>
	          		<td width="30%"><input type="text" name="clientName"></td>
	          		<td width="20%"><b>담당자</b></td>
	          		<td width="30%"><input type="text" name="managerName"></td>
				</tr>
				<tr>
					<td><b>번호</b></td>
					<td colspan="3"><input type="text" name="managerPhone"></td>
				</tr>
				<tr>
					<td><b>이메일</b></td>
					<td colspan="3"><input type="text" name="managerMail"></td>
				</tr>
				<tr>
					<td><b>제품</b></td>
					<td>
						<select name="product" id="insertSelect">
							<option value="베이직">베이직</option>
							<option value="프리미엄">프리미엄</option>
							<option value="커스텀">커스텀</option>
						</select>
					</td>
					<td><b>결제단위</b></td>
					<td><input type="text" name="paymentType"></td>
				</tr>
				<tr>
					<td><b>시작일</b></td>
					<td><input type="date" name="startDate"></td>
					<td><b>종료일</b></td>
					<td><input type="date" name="endDate"></td>
				</tr>
				<tr>
					<td><b>도메인</b></td>
					<td><input type="text" name="domainUrl"></td>
					<td><b>DB</b></td>
					<td><input type="text" name="clientDB"></td>
				</tr>
				<tr>
					<td><b>인원제한</b></td>  
					<td colspan="3"><input type="text" name="maxUser"></td>
				</tr>
				<tr>
					<td><b>계약서</b></td>
					<td colspan="3"><input type="file" name="contract"></td>
				</tr>
	          </table>
	          <div align="center">
	          	<button type="submit">확인</button>
	          	<button type="reset">취소</button>
	          </div>
	          </form>
	        </div>
	      </div>
	    </div>
	  </div>
	
    
  </div>
	
	<!-- Footer Area -->
	<jsp:include page="../common/admin/footer.jsp" />
	
	
	<!-- 스크립트 영역 -->
	<script>
		$(document).on("click", ".click", function(){
			var no = $(this).parent().children().eq(0).text();
			
			$.ajax({
				url:"selectDetailcList/ad/" + no,
				type:"get",
				success:function(data){
					console.log("ajax 성공 영역입니다.");
					console.log(data);
					
					$("#noTd").text();
					$("#nameTd").text();
					$("#managerTd").text();
					$("#phoneTd").text();
					$("#mainTd").text();
					$("#productTd").text();
					$("#payTd").text();
					$("#startTd").text();
					$("#endTd").text();
					$("#domainTd").text();
					$("#dbTd").text();
					$("#userTd").text();
					
					$("#endTd").text(data[0].endDate);
					$("#noTd").text(data[0].clientNo);
					$("#nameTd").text(data[0].clientName);
					$("#managerTd").text(data[0].managerName);
					$("#phoneTd").text(data[0].managerPhone);
					$("#mainTd").text(data[0].managerMail);
					$("#productTd").text(data[0].product);
					$("#payTd").text(data[0].paymentType);
					$("#startTd").text(data[0].startDate);
					if(data[0].endDate == null){
						$(".end").css("display","none");
					}else{
						$(".end").removeAttr("display");
						$("#endTd").text(data[0].endDate);
					}
					$("#domainTd").text(data[0].domainUrl);
					$("#dbTd").text(data[0].clientDB);
					$("#userTd").text(data[0].maxUser);
					if(data[0].status == 'Y'){
						$("#statusTd").text("계약중");
					}else{
						$("#statusTd").text("계약종료");
					}
				
					$("#cList").trigger("click");
				}
			});
		});
		
		function reContract(){
			var no = $("#noTd").text();
			var cName = $("#nameTd").text();
			var mName = $("#managerTd").text();
			var mPhone = $("#phoneTd").text();
			var mMail = $("#mainTd").text();
			var product = $("#productTd").text();
			var pay = $("#payTd").text();
			var end = $("#endTd").text();
			var domain = $("#domainTd").text();
			var user = $("#userTd").text();
			
			$("#reNoTd").children().val(no);
			$("#reNameTd").children().val(cName);
			$("#reManagerTd").children().val(mName);
			$("#rePhoneTd").children().val(mPhone);
			$("#reMailTd").children().val(mMail);
			$("#reProductTd").children().val(product);
			$("#rePayTd").children().val(pay);
			$("#reEndTd").children().val(end);
			$("#reDomainTd").children().val(domain);
			$("#reUserTd").children().val(user);
			
			$("#updateContractBtn").trigger("click");
		};
		
		function endContract(){
			var no = $("#noTd").text();
			
			if (!confirm("정말로 변경 하시겠습니까?")) {
      	      
	      	}else{
	          location.href = '${contextPath}/updateStatus.ad?no=' + no;
	      	}
		};
		
		$(document).on("click", ".download", function(){
			var no = $(this).parent().children().eq(0).text();
			
			location.href="${contextPath}/downloadFile.ad?no=" + no;
		});
		
		$(document).on("click", "#search", function(){
			var option = $("#filterSelect").val();
			console.log(option);
			
			$.ajax({
				url:"searchClient/ad/" + option,
				type:"get",
				success:function(data){
					$("#ListTable > tbody > tr").remove();
					 var $tbody = $("#ListTable > tbody");
					 
					 for(var key in data.list){
						 var $tr = $("<tr align='center'>");
						 var $noTd = $("<td>").text(data.list[key].clientNo);
						 var $nameTd = $("<td>").text(data.list[key].clientName);
						 var $mNameTd = $("<td>").text(data.list[key].managerName);
						 var $mailTd = $("<td>").text(data.list[key].managerMail);
						 var $phoneTd = $("<td>").text(data.list[key].managerPhone);
						 var $productTd = $("<td>").text(data.list[key].product);
						 
						 var sDate = new Date(data.list[key].startDate).format("yyyy-MM-dd");
						 var $startDateTd = $("<td>").text(sDate);
						 if(data.list[key].status == 'Y'){
							 var $statusTd = $("<td>").text("계약중");
						 }else{
							 var $statusTd = $("<td>").text("계약종료");
						 }
						 var $downloadTd = $("<td>");
						 var $downloadBtn = $("<button>").text("다운로드");
						 
						 $tr.append($noTd);
						 $tr.append($nameTd);
						 $tr.append($mNameTd);
						 $tr.append($mailTd);
						 $tr.append($phoneTd);
						 $tr.append($productTd);
						 $tr.append($startDateTd);
						 $tr.append($statusTd);
						 $downloadTd.append($downloadBtn);
						 $tr.append($downloadTd);
						 $tbody.append($tr);
						 
					 }
					 
				}
			});
		});
		
		$("#insertSelect").change(function(){
			if($(this).val() == "커스텀"){
				var $tr = $("<tr id='priceTr'>")
				var $td = $("<td>").html("<b>구축비용</b>");
				var $priceTd = $("<td>");
				var $priceIn = $("<input type='text' name='price'>");
				
				$priceTd.append($priceIn);
				
				$tr.append($td);
				$tr.append($priceTd);
				
				$("#addClientTable").append($tr);
			}else{
				$("#priceTr").remove();
			}
		});
		
		$("#updateSelect").change(function(){
			if($(this).val() == "커스텀"){
				var $tr = $("<tr id='rePriceTr'>")
				var $td = $("<td>").html("<b>구축비용</b>");
				var $priceTd = $("<td>");
				var $priceIn = $("<input type='text' name='price'>");
				
				$priceTd.append($priceIn);
				
				$tr.append($td);
				$tr.append($priceTd);
				
				$("#updateContract").append($tr);
			}else{
				$("#rePriceTr").remove();
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
	</script>
	
	
	
	<!-- Bootstrap core JavaScript -->
	<script
		src="${contextPath}/resources/admin/vendor/jquery/jquery.min.js"></script>
	<script
		src="${contextPath}/resources/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>
