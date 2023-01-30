<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="API" />
<%@ include file="../common/head.jsp"%>

<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
<!-- 		<form action="searchTrademard" method="POST" onsubmit="submitForm(this); return false;"> -->
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
						<tr>
							<th>제목</th>
							<td><input maxlength="800" class="input input-ghost w-full text-lg border-gray-400" type="text" name="title" placeholder="제목" value="${title}" /></td>
						</tr>
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
<!-- 		<form action="../workSpace/storedTrademark" method="POST" onsubmit="submitForm(this); return false;"> -->
			<table class="table table-zebra w-full">
				<thead>
					<tr>
						<th class="text-sm"><input type="checkbox" class="checkbox-all-member-id" onclick='selectAllTrademark(this)'></th>
<!-- 						<th class="text-sm"><input type="checkbox" class="checkbox-all-member-id" ></th> -->
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
						<h2><span class="ml-2 text-base hitCount"> total ${trademarks[0].itemsTotalCount} </span ></h2>
						<c:forEach var="trademark" items="${trademarks}" begin="0" end="${trademarks[0].itemsInAPage}" step="1" varStatus="status">
<%-- 								<input type="hidden" name="${trademark.indexNo}" value="${trademark}"/> --%>
								
								<tr class="hover">
									<td><input type="checkbox" class="checkbox-member-id" value="${trademark.indexNo},${trademark.applicantName},${trademark.applicationDate}" /></td>
<%-- 									<td><input type="checkbox" class="checkbox-member-id" value="${trademark}" /></td> --%>
									<td>${trademark.indexNo}</td>
									<td><img style="width:150px;" src="${trademark.bigDrawing}"/></td>
									<td>${trademark.applicationNumber}</td>
									<td>${trademark.applicationDate}</td>
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

	<input type="hidden" name="indexNo" value="" />
	<input type="hidden" name="applicantName" value="" />
	<input type="hidden" name="applicationDate" value="" />
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
		let valuesArr = values[0].split(',')
// 		console.log(valuesArr);
		$('input[name=indexNo]').val(valuesArr[0]);
		$('input[name=applicantName]').val(valuesArr[1]);
		$('input[name=applicationDate]').val(valuesArr[2]);
// 		$('input[name=trademark]').val(valuesJsonStr);
// 		let selectTrademarks = $('input[name=ids]').val(values.join(','));
// 		console.log($('input[name=trademark]').val());
// 		alert(selectTrademarks);
// 		$('form[name=do-stored-trademark-form]').submit();
// 		console.log($('form[name=do-stored-trademark-form]'));
	})
</script>


<section>
	<div class="page-menu mt-3 flex justify-center">
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