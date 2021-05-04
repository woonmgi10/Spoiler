<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<%@include file="../includes/header.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>

<div class="content">
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading"></div>

				<div class="panel-body">

					<div class="form-group">
						<input class="form-control" name='bno' type="hidden"
							value='<c:out value="${free.bno }"/>' readonly="readonly">
					</div>

					<div class="form-group">
						<label>제목</label> <input class="form-control" name='title'
							value='<c:out value="${free.title }"/>' readonly="readonly">
					</div>

					<div class="form-group">
						<label>글쓴이</label> <input class="form-control" name='writer'
							value='<c:out value="${free.writer }"/>' readonly="readonly">
					</div>

					<div class="form-group">
					 
						<label for="checkYn">내용 열람</label>
						<input type="checkbox" id="checkYn" name="checkYn" onclick="myFunction()" ${free.checkBox==false?"checked":""}>
						
						<pre id="text" style="display:none" class="content" style="padding:1rem;">${free.content}</pre>

					</div>


					<sec:authentication property="principal" var="pinfo" />

					<sec:authorize access="isAuthenticated()">

						<c:if test="${pinfo.username eq free.writer }">

							<button data-oper='modify' class="btn btn-default">수정</button>

						</c:if>

					</sec:authorize>

					<button data-oper='list' class="btn btn-info">목록</button>

					<form id='operForm' action="/free/modify" method="get">
						<input type='hidden' id='bno' name='bno'
							value='<c:out value="${free.bno }"/>'> <input
							type='hidden' name='pageNum'
							value='<c:out value="${cri.pageNum }"/>'> <input
							type='hidden' name='amount'
							value='<c:out value="${cri.amount }"/>'> <input
							type='hidden' name='keyword'
							value='<c:out value="${cri.keyword }"/>'> <input
							type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="panel-heading">
		<sec:authorize access="isAuthenticated()">
			<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>댓글작성</button>
		</sec:authorize>
	</div>
</div>

<div class='bigPictureWrapper'>
	<div class='bigPicture'></div>
</div>

<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadReuslt ul {
	display: flex;
	felx-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}

.uploadResult ul li img {
	width: 100px;
}

.uploadResult ul li span {
	color: white;
}

.bigPictureWrapper {
	position: absoulute;
	display: none;
	justfy-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255, 255, 255, 0.5);
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width: 600px;
}
</style>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading">Files</div>
			<div class="panel-body">

				<div class='uploadResult'>
					<ul>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

<div class='row'>
	<div class="col-lg-12">
		<!-- /.panel -->
		<div class="panel panel-default">

			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i>Reply
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<ul class="chat">
					<!-- start reply -->
					<li class="left clearfix" data-rno='12'>
						<div>
							<div class="header">
								<strong class="primary-font"></strong> <small
									class="pull-right text-muted"></small>
							</div>
							<p></p>
						</div>
					</li>
					<!-- end reply -->
				</ul>
				<!-- ./ end ul -->
			</div>
			<!-- /. panel .chat-panel 추가-->
			<div class="panel-footer"></div>
		</div>
	</div>
	<!-- ./ end row -->
</div>


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>Reply</label> <input class="form-control" name='reply'
						value='New Reply!!!!'>
				</div>
				<div class="form-group">
					<label>Replyer</label> <input class="form-control" name='replyer'
						value='replyer' readonly="readonly">
				</div>
				<div class="form-group">
					<label>Reply Date</label> <input class="form-control"
						name='replyDate' value=''>
				</div>
			</div>
			<div class="modal-footer">
				<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
				<button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
				<button id='modalRegisterBtn' type='button' class='btn btn-default'
					data-dismiss='modal'>Register</button>
				<button id='modalCloseBtn' type="button" class="btn btn-default"
					data-dismiss="modal">Close</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->


<script src="/resources/assets/js/reply.js"></script>

<script>

$(document).ready(function() {
		var bnoValue = '<c:out value="${free.bno}"/>';
		var replyUL = $(".chat");

		showList(1);

		function showList(page) {
			
			freeReplyService.getList(
					{bno : bnoValue,page : page || 1},
					
					function(replyCnt, list) {
								
						if (page == -1) {
							pageNum = Math.ceil(replyCnt / 10.0);
			
							showList(pageNum);
							return;
						}

					var str = "";

					if (list == null
							|| list.length == 0) {
						return;
					} else
					for (var i = 0, len = list.length || 0; i < len; i++) {
						str += "<li class='left clearfix' data-rno='"+list[i].rno+"'>";
						str += " <div><div class='header'><strong class='primary-font'>"
								+ list[i].replyer
								+ "</strong>";
						str += "   <small class='pull-right text-muted'>"
								+ freeReplyService
										.displayTime(list[i].replyDate)
								+ "</small></div>";
						str += " <p>"
								+ list[i].reply
								+ "</p></div></li>";

					}
					replyUL.html(str);
					showReplyPage(replyCnt);
					
				});//end function
		}//end showList
		
		
		var modal = $(".modal");
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");

		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");
		
		var replyer = null;
		
		<sec:authorize access="isAuthenticated()">
		
		replyer='<sec:authentication property="principal.username"/>';

		var csrfHeaderName="${_csrf.headerName}";
		var csrfTokenValue="${_csrf.token}";

		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});	 

		</sec:authorize>
		
		
 		$("#addReplyBtn").on("click", function(e) {
			
			modal.find("input").val("");
			modal.find("input[name='replyer']").val(replyer);
			
			
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id != 'modalCloseBtn']").hide();
			
			modalRegisterBtn.show();

			$(".modal").modal("show");
			
		});
		

 		modalRegisterBtn.on("click", function(e) {
		var reply = {
			reply : modalInputReply.val(),
			replyer : modalInputReplyer.val(),
			bno : bnoValue
		};
		
		freeReplyService.add(reply, function(result) {
			
			alert(result);
			modal.find("input").val("");
			modal.modal("hide");
			
			showList(-1);
		});	
	});
 		
		//댓글등록버튼 함수 
		$("#addReplyBtn").on("click", function(e) {
			
			modal.find("input").val("");
			modal.find("input[name='replyer']").val(replyer);
			
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id != 'modalCloseBtn']").hide();
			
			modalRegisterBtn.show();

			$(".modal").modal("show");
			
		});
		
		//등록버튼
 		modalRegisterBtn.on("click", function(e) {
			var reply = {
				reply : modalInputReply.val(),
				replyer : modalInputReplyer.val(),
				bno : bnoValue
			};

		});

		$(".chat").on("click","li",function(e) {
			var rno = $(this).data("rno");
			freeReplyService.get(rno,function(reply) {
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalInputReplyDate.val(freeReplyService.displayTime(reply.replyDate)).attr("readonly","readonly");
				modal.data("rno",reply.rno);
				modal.find("button[id != 'modalCloseBtn']").hide();
				modalModBtn.show();
				modalRemoveBtn.show();
				$(".modal").modal("show");
			});
		});

		//
		modalModBtn.on("click", function(e) {
			
			var originalReplyer = modalInputReplyer.val();
			
			var reply = {
				rno : modal.data("rno"),
				reply : modalInputReply.val(),
				replyer : originalReplyer
			};
			
			if(!replyer) {
				alert("로그인 후 수정이 가능합니다.");
				modal.modal("hide");
				return;
			}
			
			console.log("Original Replyer: " + originalReplyer);
			
			if(replyer != originalReplyer) {
				alert("자신이 작성한 댓글만 수정이 가능합니다.");
				modal.modal("hide");
				return;
			}
			
			freeReplyService.update(reply, function(result) {
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});
		});

		
		modalRemoveBtn.on("click", function(e) {
			var rno = modal.data("rno");
			
			console.log("RNO: " + rno);
			console.log("REPLYER: " + replyer);
			
			if(!replyer) {
				alert("로그인 후 삭제가 가능합니다.");
				modal.modal("hide");
				return;
			}
			
			var originalReplyer = modalInputReplyer.val();
			
			console.log("Original Replyer: " + originalReplyer);
			
			if(replyer != originalReplyer) {
				alert("자신이 작성한 댓글만 삭제가 가능합니다.");
				modal.modal("hide");
				return;
			}
			
			freeReplyService.remove(rno, originalReplyer, function(result) {
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});
		});

		var pageNum = 1;
		var replyPageFooter = $(".panel-footer");

		function showReplyPage(replyCnt) {
			var endNum = Math.ceil(pageNum / 10.0) * 10;
			var startNum = endNum - 9;

			var prev = startNum != 1;
			var next = false;

			if (endNum * 10 >= replyCnt) {
				endNum = Math.ceil(replyCnt / 10.0);
			}
			if (endNum * 10 < replyCnt) {
				next = true;
			}

			var str = "<ul class='pagination pull-right'>";
			if (prev) {
				str += "<li class='page-item'><a class='page-link' href='"
						+ (startNum - 1)
						+ "'>Previous</a></li>";
			}

			for (var i = startNum; i <= endNum; i++) {
				var active = pageNum == i ? "active" : "";
				str += "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"
						+ i + "</a></li>";
			}

			if (next) {
				str += "<li class='page-item'><a class='page-link' href='"
						+ (endNum + 1) + "'>Next</a></li>";
			}
			str += "</ul></div>";
			console.log(str);
			replyPageFooter.html(str);
		}

		replyPageFooter.on("click", "li a", function(e) {
			e.preventDefault();
			console.log("page click");
			var targetPageNum = $(this).attr("href");
			console.log("targetPageNum" + targetPageNum);
			pageNum = targetPageNum;
			showList(pageNum);
		});
		
});

$("#modalRegisterBtn").on('click', function(e) {
	Swal.fire({
		position: 'center',
		  icon: 'success',
		  title: '댓글작성완료',
		  showConfirmButton: false
	})
});


</script>


<script>
$(document).ready(function() {
	(function() {
		var bno = '<c:out value="${free.bno}"/>';
		
		$.getJSON("/free/getAttachList", {bno : bno},
			function(arr) {console.log(arr);
				var str = "";
				$(arr).each(function(i, attach) {
						if (attach.fileType) {
							var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid
									+ "_" + attach.fileName);

							str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
							str += "<img src='/display?fileName="+fileCallPath+"'>";
							str += "</div>";
							str + "</li>";
						} else {

							str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
							str += "<span> "+attach.fileName+ "</span><br/>";
							str += "<img src='/resources/img/attach.png'>";
							str += "</div>";
							str + "</li>";
						}
					});
				$(".uploadResult ul").html(str);
			});
	})();
});


</script>



<script type="text/javascript">
	$(document).ready(function() {
		var operForm = $("#operForm");
		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "/free/modify").submit();
		});

		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#bno").remove();
			operForm.attr("action", "/free/list")
			operForm.submit();
		});
	});
</script>

<script>
$(".uploadResult").on("click","li",function(e){
	console.log("view Image");
	
	var liObj = $(this);
	
	var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_"+ liObj.data("filename"));
	
	if(liObj.data("type")){
		showImage(path.replace(new RegExp(/\\/g),"/"));
		
	}else {
		//download
		self.location = "/download?fileName="+path
	}
});

function showImage(fileCallPath) {
	$(".bigPictureWrapper").css("display", "flex").show();
	
	$(".bigPictureWrapper").on("click", function(e) {
		$(".bigPicture").animate({width:'0%', height:'0%'}, 1000);
		setTimeout(function() {
			$('.bigPictureWrapper').hide();
		}, 1000);
	});
	
	$(".bigPicture")
	.html("<img src='/display?fileName="+fileCallPath+"'>")
	.animate({width:'100%', height:'100%'}, 1000);
}


</script>

<script>


function myFunction() {
	
  var checkBox = document.getElementById("checkYn");
  var text = $("#text");
  
  //alert("checked: " + checkBox.checked);
  
  if (checkBox.checked == true){
    text.show();
  } else {
    text.hide();
  }
}

myFunction();

</script>

<%@include file="../includes/footer.jsp"%>