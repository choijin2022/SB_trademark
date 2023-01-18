<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="API" />
<%@ include file="../common/head.jsp"%>

<script>

 const submitForm = function(form) {
<!-- 		유효성 검사는 하지않았습니다. -->
		
<!-- 		폼에 입력된 내용을 변수로 저장 -->
		let numOfRows = form.numOfRows.value.trim();
		let searchString = form.searchString.value.trim();
// 		let searchRecentYear = form.searchRecentYear.value.trim();
		let title = form.title.value.trim();
		
<!-- 		입력을 안했을 경우 기본 값 설정 -->
// 		if (searchRecentYear.length == 0) {
// 			searchRecentYear = 0;
// 		}
		if (title.length == 0) {
			title = "";
		}
		
<!-- 		받은 내용을 토대로 AJAX 함수 실행 -->
		getData(numOfRows, searchString, title);
		
		return false;
	};
	let total = 0;
	showButton = false;
	
<!-- 	AJAX 함수 -->
	const getData = function(numOfRows, searchString, title) {
<!-- 		// CORS 우회를 위한 프록시 사이트, 해당 사이트에 들어가서 체크 버튼을 누르고 사용 -->
		const proxy = "https://cors-anywhere.herokuapp.com/";
<!-- 		// 공공데이터포탈 XML 을 받아오는 URL -->
		const url = "http://kipo-api.kipi.or.kr/openapi/service/trademarkInfoSearchService/getWordSearch";
<!-- 		// 공공데이터포탈 API Key -->
		const API_KEY = "eCIuH7bLNd1BmdIIqpFa2FTMadwqxJ539ME6QtSZmTYlwAsadP88mzc4vBo%2BnxSaE32b6SeLZ7wKfLxE42jSxQ%3D%3D";
		
<!-- 		// 파라미터 정리 -->
		let queryParams  = "?" + encodeURIComponent("serviceKey") + "=" + API_KEY;
			queryParams += "&" + encodeURIComponent("numOfRows") + "=" + encodeURIComponent(numOfRows);
			queryParams += "&" + encodeURIComponent("searchString") + "=" + encodeURIComponent(searchString);
			queryParams += "&" + encodeURIComponent("title") + "=" + encodeURIComponent(title);
			
<!-- 		// AJAX 실행 부분 -->
		$.ajax({
	        url: proxy + url + queryParams,	// URL
	        cache: false,					// CACHE 저장 여부
	        dataType: "xml",				// 데이터 타입
	        success: function(data) {
 	        	console.log(data);
 	        	total = $(data).find("totalCount").text();
 	        	$(".hitCount").html(total + '개');
 	        	
<!-- 	        	// XML을 불러왔으나 성공적으로 못불러온 경우 -->
	        	let successYN = $(data).find("successYN").text();
	        	let resultMsg = $(data).find("resultMsg").text();
	        	
	        	if(successYN == "N" ) {
	        		alert(resultMsg);
	        		return false;
	        	}
	        	
	        	let addStoreButtonHtml = `<button class="btn btn-outline btn-accent container justify-center mt-5">저장</button>`;
	        	$(".storeButton").empty();
	        	$(".storeButton").append(addStoreButtonHtml);
	        	
<!-- 	        	// 리스트 부분 비우기 -->
	        	$("#product").empty();
	        	
<!-- 	        	// 리스트 생성 -->
	        	$(data).find("item").each(function() {
	        		const html = `
	        			<tr class="hover" id="\${$(this).find("indexNo").text() }">
	        				<td>
	        					<input type="checkbox" name="test">
	        				</td>
							<td >\${$(this).find("indexNo").text() }</td>
							<td ><img style="width:150px;" src="\${$(this).find("bigDrawing").text()}"/></td>
							<td >\${ $(this).find("applicationNumber").text() }</td>
							<td >\${ $(this).find("applicationDate").text() }</td>
							<td >\${ $(this).find("applicationStatus").text() }</td>
							<td >\${ $(this).find("applicantName").text() }</td>
						</tr>
	        		`
	        		
	        		$("#product").append(html)
	        		
	        	})
	        	let arr = new Array();

				$('input:checkbox[name=test]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
				    let a = $(this).closest('form').get(0);
					a.no.value = 1;
					console.log(a.no.value);
				});
	        },
	        error: function(){
<!-- 	        	// XML 로딩 실패 -->
	        	
	            alert('Error loading XML document');
	        }
	
	    })
	};
	

	function selectAll(selectAll)  {
		  const checkboxes 
		     = document.querySelectorAll('input[type="checkbox"]');
		  
		  checkboxes.forEach((checkbox) => {
		    checkbox.checked = selectAll.checked
		  })
		}
	
// 	function test(){
// 		$('input:checkbox[name=test]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
// 		    let a = $(this).closest('form').get(0);
// 			a.no.value = 1;
// 			console.log(a.no.value);
// 		});
// 		return false;
// 	}
				
// 	$("#arrayParam").val(array);
		
// 	$("#form").attr("action", "/test/test.do");  
// 	$("#form").submit();
	
</script>

<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
		<form onsubmit="return submitForm(this);">
			<div class="table-box-type-1">
				<table class="table table-zebra w-full">
<%-- 					<colgroup> --%>
<%-- 						<col width="200" /> --%>
<%-- 					</colgroup> --%>

					<tbody>
						<tr>
							<th>보기</th>
							<td>
								<select name="numOfRows" class="select select-bordered w-full">
									<option value="10">10개씩 보기</option>
									<option value="20">20개씩 보기</option>
									<option value="50">50개씩 보기</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>단어</th>
							<td>
								<input maxlength="38" class="input input-ghost w-full text-lg border-gray-400" type="text" name="searchString" placeholder="단어" />
							</td>
						</tr>
<!-- 						<tr> -->
<!-- 							<th>년도</th> -->
<!-- 							<td><input maxlength="4" class="input input-ghost w-full text-lg border-gray-400" type="text" name="searchRecentYear" placeholder="년도" /></td> -->
<!-- 						</tr> -->
						<tr>
							<th>제목</th>
							<td><input maxlength="800" class="input input-ghost w-full text-lg border-gray-400" type="text" name="title" placeholder="제목" /></td>
						</tr>
						<tr>
							<td colspan="2"><button class="btn btn-outline btn-accent w-full">검색</button></td>
						</tr>
						
					</tbody>
				</table>
			</div>
		</form>
	</div>
</section>

<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
		<h2>total<span class="ml-2 text-base hitCount"></span></h2>
		<form >
			<input type="hidden" name="no"/>
			<input type="hidden" name="img"/>
			<input type="hidden" name="an"/>
			<input type="hidden" name="ad"/>
			<input type="hidden" name="as"/>
			<input type="hidden" name="aname"/>
			<table class="table table-zebra w-full">
				<thead>
					<tr>
						<th class="text-sm"><input type="checkbox" onclick='selectAll(this)'></th>
						<th class="text-sm">No</th>
						<th class="text-sm">이미지</th>
						<th class="text-sm">출원번호</th>
						<th class="text-sm">출원일자</th>
						<th class="text-sm">법적상태</th>
						<th class="text-sm">출원인 이름</th>
					</tr>
				</thead>
	
				<tbody id="product">
					
				</tbody>
			</table>
			<div class="storeButton"></div>
		</form>
		<a href="/usr/home/test" class="btn btn-active btn-ghost btn-sm mr-2">test</a>
	</div>
	<div class="pageNav flex justify-center mt-5">
			<div class="btn-group">
				<c:set var="maxPageNum" value="5" />
			</div>
		</div>
</section>


<%@ include file="../common/foot.jsp"%>