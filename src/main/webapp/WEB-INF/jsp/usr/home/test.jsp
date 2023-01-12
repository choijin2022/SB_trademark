<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="TEST" />
<%@ include file="../common/head.jsp"%>

<div>
	<div>${numOfRows }</div>
	<div>${searchString }</div>
	<div>${title }</div>
</div>

<%@ include file="../common/foot.jsp"%>