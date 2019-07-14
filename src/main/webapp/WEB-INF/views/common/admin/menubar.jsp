<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LetsGoToWork</title>
<style>
li {
	margin-right:10px;
}
</style>
</head>
<body>
	<nav class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="${contextPath}/admin.ad">Let's Go To Work</a>
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="${contextPath}/consulting.ad">상담</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${contextPath}/client.ad">고객사</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${contextPath}/calculate.ad">정산</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${contextPath}/statistics.ad">통계</a>
          </li>
          <li class="nav-item">
          	<a class="nav-link" href="${contextPath}/index.jsp"><img src="${contextPath}/resources/admin/image/web.png" style="width:25px; height:25px;"></a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</body>
</html>