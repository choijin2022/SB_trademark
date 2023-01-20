<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="API" />
<%@ include file="../common/head.jsp"%>

<script>
let total = 0;
showButton = false;

const submitForm = function(form) {
	console.log("??");
	//수정
	
	let numOfRows = form.numOfRows.value.trim();
		let searchString = form.searchString.value.trim();
// 		let searchRecentYear = form.searchRecentYear.value.trim();
		let title = form.title.value.trim();
	$.get('../home/searchTrademard', {
		numOfRows : numOfRows,
		searchString: searchString,
		title: title,
		ajaxMode : 'Y'
	}, function(data){
		
		console.log(data);
		console.log(data[0]);
		total = $(data).find("totalCount").text();
		$(".hitCount").html(total + '개');
		
		let addStoreButtonHtml = `<button class="btn btn-outline btn-accent container justify-center mt-5">저장</button>`;
    	$(".storeButton").empty();
    	$(".storeButton").append(addStoreButtonHtml);
    	
<!-- 	        	// 리스트 부분 비우기 -->
    	$("#product").empty();
    	
<!-- 	        	// 리스트 생성 -->
		let i  = 0;
		
    	$(data).each(function() {
    		let index = $(this).find("indexNo");
    		console.log(index);
    		const html = `
    			<tr class="hover" id="$(this).find("indexNo").text()">
    				<td>
    					<input type="checkbox" name="test">
    				</td>
					<td >$(this).find("indexNo")</td>
					<td ><img style="width:150px;" src="\${$(this).find("bigDrawing").text()}"/></td>
					<td >\${ $(this).find("applicationNumber").text() }</td>
					<td >\${ $(this).find("applicationDate").text() }</td>
					<td >\${ $(this).find("applicationStatus").text() }</td>
					<td >\${ $(this).find("applicantName").text() }</td>
				</tr>
    		`
    		
    		$("#product").append(html);
    		
    		
    	})
		
    	let arr = new Array();

		$('input:checkbox[name=test]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
		    let a = $(this).closest('form').get(0);
			a.no.value = 1;
			console.log(a.no.value);
		});
		
	}, 'json');
	
	return false;
	
}

	

	
// 	const getData = function(numOfRows, searchString, title) {
// 		console.log("getData");
// 		total = $(data).find("totalCount").text();
// 		$(".hitCount").html(total + '개');
		
// 		let addStoreButtonHtml = `<button class="btn btn-outline btn-accent container justify-center mt-5">저장</button>`;
//     	$(".storeButton").empty();
//     	$(".storeButton").append(addStoreButtonHtml);
    	
// <!-- 	        	// 리스트 부분 비우기 -->
//     	$("#product").empty();
    	
// <!-- 	        	// 리스트 생성 -->
//     	$(data).find("item").each(function() {
//     		const html = `
//     			<tr class="hover" id="\${$(this).find("indexNo").text() }">
//     				<td>
//     					<input type="checkbox" name="test">
//     				</td>
// 					<td >\${$(this).find("indexNo").text() }</td>
// 					<td ><img style="width:150px;" src="\${$(this).find("bigDrawing").text()}"/></td>
// 					<td >\${ $(this).find("applicationNumber").text() }</td>
// 					<td >\${ $(this).find("applicationDate").text() }</td>
// 					<td >\${ $(this).find("applicationStatus").text() }</td>
// 					<td >\${ $(this).find("applicantName").text() }</td>
// 				</tr>
//     		`
    		
//     		$("#product").append(html)
    		
//     	})
//     	let arr = new Array();

// 		$('input:checkbox[name=test]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
// 		    let a = $(this).closest('form').get(0);
// 			a.no.value = 1;
// 			console.log(a.no.value);
// 		});

// 	};
	
// 	끝
	function selectAll(selectAll)  {
		  const checkboxes 
		     = document.querySelectorAll('input[type="checkbox"]');
		  
		  checkboxes.forEach((checkbox) => {
		    checkbox.checked = selectAll.checked
		  })
		}
	

	
	function test(){
		$('input:checkbox[name=test]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
		    let a = $(this).closest('form').get(0);
			a.no.value = 1;
			console.log(a.no.value);
		});
		return false;
	}
				
// 	$("#arrayParam").val(array);
		
// 	$("#form").attr("action", "/test/test.do");  
// 	$("#form").submit();
	
</script>

<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
<!-- 		<form action="searchTrademard" method="POST" onsubmit="submitForm(this); return false;"> -->
			<form onsubmit="return submitForm(this);">
<%-- 			<input type="hidden" name="numOfRows" value="${numOfRows }" /> --%>
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
								<input maxlength="38" class="input input-ghost w-full text-lg border-gray-400" type="text" name="searchString" placeholder="단어" value="${searchKeyword }"/>
							</td>
						</tr>
<!-- 						<tr> -->
<!-- 							<th>년도</th> -->
<!-- 							<td><input maxlength="4" class="input input-ghost w-full text-lg border-gray-400" type="text" name="searchRecentYear" placeholder="년도" /></td> -->
<!-- 						</tr> -->
						<tr>
							<th>제목</th>
							<td><input maxlength="800" class="input input-ghost w-full text-lg border-gray-400" type="text" name="title" placeholder="제목" value="${title}" /></td>
						</tr>
						<tr>
							<td colspan="2"><button class="btn btn-outline btn-accent w-full do-search-form">검색</button></td>
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