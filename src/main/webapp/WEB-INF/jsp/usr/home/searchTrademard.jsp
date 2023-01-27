<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="API" />
<%@ include file="../common/head.jsp"%>

<script>
let total = 0;
showButton = false;

function list(){
	let page = ${trademarks[0].page};
	let itemsInAPage = ${trademarks[0].itemsInAPage};
	let itemsTotalCount = ${trademarks[0].itemsTotalCount};
	let pagesCount = ${trademarks[0].pagesCount};
	
	for (var i = 0; i <pagesCount ; i++) {
		  alert(i);
		}

	
}


// const submitForm = function(form) {
	
// 	//수정
	
// 	let numOfRows = form.numOfRows.value.trim();
// 	let searchString = form.searchString.value.trim();
// // 		let searchRecentYear = form.searchRecentYear.value.trim();
// 	let title = form.title.value.trim();
// 	$.get('../home/searchTrademard', {
// 		numOfRows : numOfRows,
// 		searchString: searchString,
// 		title: title,
// 		ajaxMode : 'Y'
// 	}, function(data){
		
// 		console.log(data);
		
// 		total = data[0].totalCount;
// 		$(".hitCount").html(total + '개');
		
// 		let addStoreButtonHtml = `<button class="btn btn-outline btn-accent container justify-center mt-5">저장</button>`;
//     	$(".storeButton").html(addStoreButtonHtml);
    	
// <!-- 	        	// 리스트 부분 비우기 -->
//     	$("#product").empty();
    	
// <!-- 	        	// 리스트 생성 -->
		
// 		let num = 0;
//     	$(data).each(function() {
    		
//     		console.log(data[num]);
// 			let index = data[num].indexNo;
// 			console.log(index);

// //     			<form action="../home/stored" method="POST" onsubmit="storedTradeMark__submitForm(this); return false;">
//     		const html = `
// 	    			<tr class="hover">
// 	    				<td>
// 	    					<input type="checkbox" name="test">
// 	    				</td>
// 						<td >\${index}</td>
// 						<td ><img style="width:150px;" src="\${data[num].bigDrawing}"/></td>
// 						<td >\${data[num].applicationNumber}</td>
// 						<td >\${data[num].applicationDate}</td>
// 						<td >\${data[num].applicationStatus}</td>
// 						<td >\${data[num].applicantName}</td>
// 					</tr>
//     		`
// // 				</form>

//     		$("#product").append(html);
    		
//     		num++;
//     	})
		
//     	//페이지
//     	$(".page-menu").empty();
    	
//     	let pageHtml = `
    	
//    		<div class="btn-group">
//    			<c:set var="pageMenuLen" value="5" />
//    			<c:set var="startPage" value="${page - pageMenuLen >= 1 ? page - pageMenuLen : 1}" />
// 			<c:set var="endPage" value="${page + pageMenuLen <= pagesCount ? page + pageMenuLen : pagesCount}" />
		
			
// 		</div>
		
// 		`
//     	$(".page-menu").append(pageHtml);
//     	console.log(pageMenuLen);	
// 		console.log(startPage);	
		
//     	//페이지 수정 끝
    	
//     	let arr = new Array();

// 		$('input:checkbox[name=test]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
// 		    let a = $(this).closest('form').get(0);
// 			a.no.value = 1;
// 			console.log(a.no.value);
// 		});
		
// 	}, 'json');
	
// 	return false;
	
// }

	

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
								<input maxlength="38" class="input input-ghost w-full text-lg border-gray-400" type="text" name="searchString" placeholder="단어" value="${trademarks[0].searchString}"/>
								<div></div>
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
					<c:if test="${trademarks[0].itemsTotalCount != 0 }">
						<span> ${trademarks[0].itemsTotalCount} </span >
						<c:forEach var="trademarks" items="${trademarks}" begin="0" end="${trademarks[0].itemsInAPage}" step="1" varStatus="status">
								<tr class="hover">
									<td><input type="checkbox" name="test"></td>
									<td>${trademarks.indexNo}</td>
									<td><img style="width:150px;" src="${trademarks.bigDrawing}"/></td>
									<td>${trademarks.applicationNumber}</td>
									<td>${trademarks.applicationDate}</td>
									<td>${trademarks.applicationStatus}</td>
									<td>${trademarks.applicantName}</td>
								</tr>
							</c:forEach>
					</c:if>
				</tbody>
			</table>
			<div class="storeButton"></div>
			<button class="btn btn-outline btn-accent container justify-center mt-5">저장</button>
		</form>
	</div>
	<div class="pageNav flex justify-center mt-5">
			<div class="btn-group">
				<c:set var="maxPageNum" value="5" />
			</div>
		</div>
</section>

<script>
function storedTradeMark__submitForm(form){
	console.log("???????");
}


</script>


<section>
	<div class="page-menu mt-2 flex justify-center">
			<div class="btn-group">
				<c:set var="page" value="${trademarks[0].page}" />
				<c:set var="pagesCount" value="${trademarks[0].pagesCount}" />
				<c:set var="pageMenuLen" value="5" />
				<c:set var="startPage" value="${page - pageMenuLen >= 1 ? page - pageMenuLen : 1}" />
				<c:set var="endPage" value="${page + pageMenuLen <= pagesCount ? page + pageMenuLen : pagesCount}" />
				
				<c:set var="pageBaseUri" value="?boardId=${boardId }&searchKeywordTypeCode=${searchKeywordTypeCode }&searchKeyword=${searchKeyword }" />
				<c:if test="${trademarks[0].totalCount != 0 }">
					<c:if test="${page == 1 }">
						<a class="btn btn-sm btn-disabled">«</a>
						<a class="btn btn-sm btn-disabled">&lt;</a>
					</c:if>
					<c:if test="${page > 1 }">
						<a class="btn btn-sm" href="${pageBaseUri }&page=1">«</a>
						<a class="btn btn-sm" href="${pageBaseUri }&page=${page - 1 }">&lt;</a>
					</c:if>
					<c:forEach begin="${startPage }" end="${endPage }" var="i">
						<a class="btn btn-sm ${page == i ? 'btn-active' : ''}" href="${pageBaseUri }&page=${i }">${i }</a>
					</c:forEach>
					<c:if test="${page < pagesCount }">
						<a class="btn btn-sm" href="${pageBaseUri }&page=${page + 1 }">&gt;</a>
						<a class="btn btn-sm" href="${pageBaseUri }&page=${pagesCount }">»</a>
					</c:if>
					<c:if test="${page == pagesCount }">
						<a class="btn btn-sm btn-disabled">&gt;</a>
						<a class="btn btn-sm btn-disabled">»</a>
					</c:if>
				</c:if>
			</div>
		</div>
</section>



<%@ include file="../common/foot.jsp"%>