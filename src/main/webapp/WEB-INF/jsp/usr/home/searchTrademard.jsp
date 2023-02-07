<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="API" />
<%@ include file="../common/head.jsp"%>

<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
			<form>
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
<!-- 						<tr> -->
<!-- 							<th>제목</th> -->
<%-- 							<td><input maxlength="800" class="input input-ghost w-full text-lg border-gray-400" type="text" name="title" placeholder="제목" value="${title}" /></td> --%>
<!-- 						</tr> -->
						<tr>
							<td colspan="2"><button class="btn btn-outline btn-accent w-full ">검색</button></td>
						</tr>
						
					</tbody>
				</table>
			</div>
		</form>
	</div>
</section>


<script>
$('.checkbox-all-member-id').change(function() {
	const allCheck = $(this);
	const allChecked = allCheck.prop('checked');
	$('.checkbox-member-id').prop('checked', allChecked);
	$('.checkbox-member-id:is(:disabled)').prop('checked', false)
})
$('.checkbox-member-id').change(function() {
	const checkboxMemberIdCount = $('.checkbox-member-id').length;
	const checkboxMemberIdCheckedCount = $('.checkbox-member-id:checked').length;
	const checkboxDisabledCount = $('.checkbox-member-id:is(:disabled)').length;
	const allChecked = (checkboxMemberIdCount - checkboxDisabledCount) == checkboxMemberIdCheckedCount;
	$('.checkbox-all-member-id').prop('checked', allChecked);
})
function selectAllTrademark(selectAll)  {
	  const checkboxes 
	     = document.querySelectorAll('input[type="checkbox"]');
	  
	  checkboxes.forEach((checkbox) => {
	    checkbox.checked = selectAll.checked
	  })
}
</script>


<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
			<table class="table table-zebra w-full">
				<thead>
					<tr>
						<th class="text-sm"><input type="checkbox" class="checkbox-all-member-id" onclick='selectAllTrademark(this)'></th>
<!-- 						<th class="text-sm"><input type="checkbox" class="checkbox-all-member-id" ></th> -->
						<th class="text-sm">No</th>
						<th class="text-sm">이미지</th>
						<th class="text-sm">출원번호</th>
						<th class="text-sm">출원일자</th>
						<th class="text-sm">상품분류</th>
						<th class="text-sm">법적상태</th>
						<th class="text-sm">출원인 이름</th>
					</tr>
				</thead>
	
				<tbody id="product">
					<c:if test="${trademarks[0].itemsTotalCount != 0 }">
						<h2><span class="ml-2 text-base hitCount"> total ${trademarks[0].itemsTotalCount} </span ></h2>
						<c:forEach var="trademark" items="${trademarks}" begin="0" end="${trademarks[0].numOfRows}" step="1" varStatus="status">
<%-- 								<input type="hidden" name="${trademark.indexNo}" value="${trademark}"/> --%>
								
							<tr class="hover">
								<td><input type="checkbox" class="checkbox-member-id" value="${trademark.indexNo},${trademark.title},${trademark.applicantName},${trademark.applicationNumber},${trademark.applicationDate},${trademark.publicationNumber},${trademark.publicationDate},${trademark.registrationNumber},${trademark.registrationDate},${trademark.registrationPublicNumber},${trademark.registrationPublicDate},${trademark.priorityNumber},${trademark.priorityDate},${trademark.internationalRegisterNumber},${trademark.internationalRegisterDate},${trademark.applicationStatus},${trademark.classificationCode},${trademark.viennaCode},${trademark.agentName},${trademark.regPrivilegeName},${trademark.fullText},${trademark.drawing},${trademark.bigDrawing}" /></td>
								<td>${trademark.indexNo}</td>
								<td><img style="width:150px;" src="${trademark.bigDrawing}"/></td>
								<td>${trademark.applicationNumber}</td>
								<td>${trademark.applicationDate}</td>
								<td>${trademark.classificationCode}</td>
								<td>${trademark.applicationStatus}</td>
								<td>${trademark.applicantName}</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
			
<!-- 		</form> -->
	</div>
	<div class="pageNav flex justify-center mt-5">
			<div class="btn-group">
				<c:set var="maxPageNum" value="5" />
			</div>
		</div>
</section>

<div class="storeButton mt-2 flex justify-end">
	<button class="btn btn-outline btn-accent container justify-center mt-5 btn-stored-selected-trademark" >저장</button>
</div>

<!-- <form method="POST" name="do-stored-trademark-form" action="../workSpace/storedTrademark" onsubmit="return false;"> -->
<form method="POST" name="do-stored-trademark-form" action="../workSpace/storedTrademark" >
<!-- <form id = "checkedTd" name="do-stored-trademark-form"  > -->

<!-- 	<input type="hidden" name="trademark" value="" /> -->
<%-- 	<input type="hidden" name="numOfRows" value="#{numOfRows}" /> --%>
	<input type="hidden" name="test" value="" />
<!-- 	<input type="hidden" name="indexNo" value="" /> -->
<!-- 	<input type="hidden" name="applicantName" value="" /> -->
</form>
		
<script>
	$('.btn-stored-selected-trademark').click(function() {
		const values = $('.checkbox-member-id:checked').map((index, el) => el.value).toArray();
		if (values.length == 0) {
			alert('선택한 상표가 없습니다');
			return;
		}
		if (confirm('선택한 상표를 저장하시겠습니까?') == false) {
			return;
		}
		
// 		let valuesJsonStr = JSON.stringify(values);
		console.log(values);
// 		console.log('=============' + values.length);
// 		console.log(valuesArr);
// 		let valuesArr;
// 		for(let i = 0; i < values.length; i++){
// 			valuesArr = values[i].split(',');
// 			console.log(valuesArr);
// 			$('input[name=indexNo]').val(valuesArr.join(','));
// 			$('input[name=applicantName]').val(valuesArr[1]);
// 			$('input[name=applicationNumber]').val(valuesArr[2]);
// 			$('input[name=applicationDate]').val(valuesArr[3]);
// 		}
		
		let valuesArr = values.join('!');
		console.log(valuesArr)
		
		$('input[name=test]').val(valuesArr);
		
		$('form[name=do-stored-trademark-form]').submit();
	})
	
// function pageUrl(pageNo){

	
	
// 	return false;
// }

	function pageUrl(pageNo) {
	 	let numOfRows = ${trademarks[0].numOfRows};
	 	let searchString = "${trademarks[0].searchString}";
		
		
		$('input[name=numOfRows]').val(numOfRows);
		$('input[name=searchString]').val(searchString);
		$('input[name=pageNo]').val(pageNo);
		console.log(pageNo);
// 		return false;
		$('form[name=paging-form]').submit();
		
		
	}

</script>

<form name="paging-form" action="searchTrademard" method="POST" >
	<input type="hidden" name="numOfRows" value="">
	<input type="hidden" name="searchString" value="">
	<input type="hidden" name="pageNo" value="">
</form>

<section>
	<div class="page-menu mt-3 flex justify-center">
			<div class="btn-group">
				<c:set var="pageNo" value="${trademarks[0].pageNo}" />
				<c:set var="pagesCount" value="${trademarks[0].pagesCount}" />
				<c:set var="pageMenuLen" value="5" />
				
				<c:set var="startPage" value="${pageNo - pageMenuLen >= 1 ? pageNo - pageMenuLen : 1}" />
				<c:set var="endPage" value="${pageNo + pageMenuLen <= pagesCount ? pageNo + pageMenuLen : pagesCount}" />
<%-- 				<c:set var="ServiceKey" value="WTh4nA6jgRy5Jxmw4vhBoRbWDJFex7P%2BNr1NnXssp1P6N6NDjsY5hEZnOLCS4NEOpS8SSkrREQp%2FqX%2BsrB42DQ%3D%3D" /> --%>
				<c:set var="numOfRows" value="${trademarks[0].numOfRows}" />
				<c:set var="searchString" value="${trademarks[0].searchString}" />
<%-- 				<c:set var="url" value="http://kipo-api.kipi.or.kr/openapi/service/trademarkInfoSearchService/getWordSearch" /> --%>
				
<%-- 				<c:set var="pageBaseUri" value="${url}?ServiceKey=${ServiceKey}&numOfRows=${numOfRows}&searchKeyword=${searchKeyword }" /> --%>
<%-- 				<c:set var="pageBaseUri" value="${url}?ServiceKey=${ServiceKey}&searchString=${searchString}" /> --%>
				<c:set var="pageBaseUri" value="&searchString=${searchString}" />
			
				<c:if test="${trademarks[0].totalCount != 0 }">
					<c:if test="${pageNo == 1 }">
						<a class="btn btn-sm btn-disabled">«</a>
						<a class="btn btn-sm btn-disabled">&lt;</a>
					</c:if>
					<c:if test="${pageNo > 1 }">
						<a class="btn btn-sm" onclick="pageUrl(1)">«</a>
						<a type="button" class="btn btn-sm" onclick="pageUrl(${pageNo-1})">&lt;</a>
<%-- 						<a class="btn btn-sm" onclick="${pageBaseUri }&pageNo=${pageNo-1}">&lt;</a> --%>
					</c:if>
					<c:forEach begin="${startPage }" end="${endPage }" var="i">
						<a class="btn btn-sm ${pageNo == i ? 'btn-active' : ''}" onclick="pageUrl(${i })">${i }</a>
					</c:forEach>
					<c:if test="${pageNo < pagesCount }">
						<a class="btn btn-sm" onclick="pageUrl(${pageNo + 1 })">&gt;</a>
						<a class="btn btn-sm" onclick="pageUrl(${pagesCount })">»</a>
					</c:if>
					<c:if test="${pageNo == pagesCount }">
						<a class="btn btn-sm btn-disabled">&gt;</a>
						<a class="btn btn-sm btn-disabled">»</a>
					</c:if>
				</c:if>
			</div>
		</div>
	
</section>

<%@ include file="../common/foot.jsp"%>