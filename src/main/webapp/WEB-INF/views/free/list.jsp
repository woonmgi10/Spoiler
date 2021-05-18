<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<!-- End Navbar -->
<div class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="card">
				<div class="card-header">
					<h4 class="card-title"></h4>
				</div>
				<div class="card-body">

					<table class="table">
						<thead class="">
							<tr>
								<th></th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회</th>
							</tr>
						</thead>

						<c:forEach items="${list }" var="free">
							<tr>
								<td><c:out value="${free.bno }" /></td>
								<td><a class='move' href='<c:out value="${free.bno }"/>'>
										<c:out value="${free.title }" /> <b>[  <c:out value="${free.replyCnt }" /> ]</b>
								</a>
								</td>
								<td><c:out value="${free.writer }" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${free.regDate }" /></td>
										<td><fmt:formatDate pattern="yyyy-MM-dd" value="${free.updateDate }"/>
										</td>
							</tr>
						</c:forEach>
					</table>

		<!-- 			<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
						aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">알림</h5>
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">처리가 완료되었습니다.</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-dismiss="modal">닫기</button>
									<button type="button" class="btn btn-primary">Save changes</button>
								</div>
							</div>
						</div>

					</div>  -->
					<div class='row'>
						<div class="col-lg-12">

							<form id='searchForm' action="/free/list" method='get'>
								<select name='type'>
									<option value=""
									<c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>--</option>
									<option value="t"
									<c:out value="${pageMaker.cri.type eq 't'?'selected':'' }"/>>제목</option>
									<option value="c"
									<c:out value="${pageMaker.cri.type eq 'c'?'selected':'' }"/>>내용</option>
									<option value="w"
									<c:out value="${pageMaker.cri.type eq 'w'?'selected':'' }"/>>작성자</option>
									<option value="tc"
									<c:out value="${pageMaker.cri.type eq 'tc'?'selected':'' }"/>>제목+내용</option>
									<option value="tw"
									<c:out value="${pageMaker.cri.type eq 'tw'?'selected':'' }"/>>제목+작성자</option>
									<option value="tcw"
									<c:out value="${pageMaker.cri.type eq 'tcw'?'selected':'' }"/>>제목+내용+작성자</option>
								</select> <input type='text' name='keyword' value=' <c:out value="${pageMaker.cri.keyword }"/>' />
								<input type='hidden' name='pageNum'
								value=' <c:out value="${pageMaker.cri.pageNum }"/>' />
								<input type='hidden' name='amount'
								value=' <c:out value="${pageMaker.cri.amount }"/>' />
								<button class='btn btn-default'>검색</button>
							</form>
						</div>
					</div>
				</div>

			</div>

			<button id='regBtn' type="button" class="btn btn-xs pull-right">글쓰기</button>
		</div>

	</div>
	<div class='centered'>
		<ul class='pagination justify-content-center'>
			<c:if test="${pageMaker.prev }">
				<li class="page-item previous"><a class="page-link"
					href="${pageMaker.startPage -1}">이전</a></li>
			</c:if>

			<c:forEach var="num" begin="${pageMaker.startPage }"
				end="${pageMaker.endPage }">
				<li class='page-item ${pageMaker.cri.pageNum == num ? "active":""} '>
					<a class="page-link" href="${num }">${num } </a>
				</li>
			</c:forEach>

			<c:if test="${pageMaker.next }">
				<li class="page-item next"><a class="page-link"
					href="${pageMaker.endPage +1 }">다음</a></li>
			</c:if>
		</ul>
	</div>
</div>


<form id='actionForm' action="/free/list" method='get'>
	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
	<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
	<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type }"/>'>
	<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'>
</form>

<script type="text/javascript">


	$(document).ready(function() {
		var result = '<c:out value="${result}"/>';

		checkModal(result);

		history.replaceState({}, null, null);

		function checkModal(result) {
		if (result === '' || history.state) {
			return;
			}
		if (parseInt(result) > 0) {
			$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
			}
		$("#myModal").modal("show");
		}
		
		$("#regBtn").on("click", function() {
			self.location = "/free/register";
			});

		var actionForm = $("#actionForm");

		$(".page-item a").on("click", function(e) {
			e.preventDefault();

			console.log('click');

			actionForm.find("input[name='pageNum']").val($(this).attr("href"));

			actionForm.submit();
			
		});

		$(".move").on("click", function(e) {
			e.preventDefault();
			actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
			actionForm.attr("action", "/free/get");
			actionForm.submit();
			});
						
			var searchForm = $("#searchForm");
			$("#searchForm button").on("click", function(e) {
				if(!searchForm.find("option:selected").val()) {
					alert("검색종류를 선택하세요");
					return false;
					}
				if(!searchForm.find("input[name='keyword']").val()) {
					alert("키워드를 입력하세요");
					return false;
					}
				searchForm.find("input[name='pageNum']").val("1");
				e.preventDefault();
				searchForm.submit();
				});
			});
</script>


<%@include file="../includes/footer.jsp"%>