<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<%@include file="../includes/header.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>


<script src="/ckeditor/ckeditor.js"></script>

<div class="content">
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading"></div>

				<div class="panel-body">

					<form role="form" action="/free/modify" method="post">
					
					<input type='hidden' name="${_csrf.parameterName}" value="${_csrf.token }"/>
					
					<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
					<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
					<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
					<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
						
						<div class="form-group">
							
							<input class="form-control" name='bno' type="hidden"
								value='<c:out value="${free.bno }"/>'>
						</div>
					
						<div class="form-group">
							<label>제목</label> <input class="form-control" name='title'
								value='<c:out value="${free.title }"/>'>
						</div>

						<div class="form-group">
							<label>글쓴이</label> <input class="form-control" name='writer'
								value='<c:out value="${free.writer }"/>' readonly="readonly">
						</div>

						<div style = "width:800px;">내용<textarea id = "content" name='content' rows = "5" cols = "80"
						placeholder = "상품설명을 입력하세요"><c:out value="${free.content}" /></textarea>
						
						<script>
						CKEDITOR.replace("content");
						
						</script>
						</div> 

						<div class="form-group">
							<input class="form-control" name='regDate' type="hidden"
								value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${free.regDate }" />'
								readonly="readonly">
						</div>

						<div class="form-group">
							<input class="form-control" name='updateDate' type="hidden"
								value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${free.updateDate }" />'
								readonly="readonly">
						</div>
						
						<sec:authentication property="principal" var="pinfo"/>
						<sec:authorize access="isAuthenticated()">
						<c:if test="${pinfo.username eq free.writer }">
						
						<button type="submit" data-oper='modify' class="btn btn-default" id="btnModifyClick">수정</button>
						<button type="submit" data-oper='remove' class="btn btn-danger" id="btnRemoveClick">삭제</button>
						
						</c:if>
						</sec:authorize>



						<button type="submit" data-oper='list' class="btn btn-info">목록</button>

					</form>

				</div>

			</div>
		</div>

	</div>
</div>

<div class='bigPictureWrapper'>
	<div class='bigPicture'></div>
</div>

<style>
.uploadResult {
	width: 100%;
	background-color:gray;
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
				<div class="uploadDiv">
					<input type="file" name='uploadFile' multiple="multiple">
				</div>

				<div class='uploadResult'>
				<ul>
				</ul>				
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		
		var formObj = $("form");
		
		$('button').on("click", function(e) {
		
			e.preventDefault();
			
			var operation = $(this).data("oper");
			
			console.log(operation);

			if(operation === 'remove') {
				formObj.attr("action", "/free/remove");
			} else if (operation === 'list') {
				formObj.attr("action", "/free/list").attr("method", "get");
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var typeTag = $("input[name='type']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				
				formObj.empty();
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(typeTag);
				formObj.append(keywordTag);
			} else if (operation === 'modify') {
				console.log("submit clicked");
				var str = "";
				$(".uploadResult ul li").each(function(i, obj) {
					var jobj = $(obj);
					console.dir(jobj);
					
					str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
					str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
					str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
					str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
				});
				formObj.append(str);
				setTimeout(() => {
					formObj.submit();	
				}, 1000);
				
			}
			setTimeout(()=> {formObj.submit()}, 1000);
		});
	});
	
	$('#btnModifyClick').on('click', function(e) {
		Swal.fire({
			position: 'center',
			  icon: 'success',
			  title: '수정완료',
			  showConfirmButton: false
		})
	});
	
	$('#btnRemoveClick').on('click', function(e) {
		Swal.fire({
			position: 'center',
			  icon: 'success',
			  title: '삭제완료',
			  showConfirmButton: false
		})
	});
	

</script>

<script>
var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
var maxSize = 5242880;

function checkExtension(fileName, fileSize) {
	if(fileSize >= maxSize) {
		alert("파일 사이즈 초과");
		return false;
	}
	if(regex.test(fileName)) {
		alert("해당 종류의 파일은 업로드 할 수 없습니다.");
		return false;
	}
	return true;
}
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

	$("input[type='file']").change(function(e) {
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		
		for(var i = 0; i < files.length; i++) {
			
			if(!checkExtension(files[i].name, files[i].size) ) {
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
			url: '/uploadAjaxAction',
			processData: false,
			contentType: false,
			data:formData,
			type: 'POST',
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
			dataType: 'json',
			success: function(result) {
				console.log(result);
				showUploadResult(result);
				}
		});
	});

function showUploadResult(uploadResultArr) {
	
	if (!uploadResultArr || uploadResultArr.length == 0) {return; }
	
	var uploadUL = $(".uploadResult ul");
	var str = "";
	
	$(uploadResultArr).each(function (i,obj) {
		
		//image type
		if (obj.image) {
			
			var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_"+obj.uuid+"_"+obj.fileName);
			
			/* str += "<li><div>"*/
			str += "<li data-path='"+obj.uploadPath+"'";													
			str += "data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'";	
			str += " ><div>";																				
			str += "<span> "+obj.fileName+"</span>"  	
			/* str += 	"<button type='button' 													class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"; */
			/* str += 	"<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"; */			
			str += "<button type='button' data-file=\'"+fileCallPath+"\' "
			str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			str += "<img src='/display?fileName="+fileCallPath+"'>";
			str += "</div>";
			str +"</li>";
			
		}else{
			
			var fileCallPath = encodeURIComponent(obj.uploadPath + "/"+obj.uuid+"_"+obj.fileName);
			var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/")
			
			/* str += "<li><div>" */			
			str += "<li "
			str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
			str += "<span> "+obj.fileName+"</span>" 
			/* str += 	"<button type='button' 													class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"; */
			/* str += 	"<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"; */
			str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' "
			str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			str += "<img src='/resources/img/attach.png'></a>";
			str += "</div>";
			str +"</li>";
			
		}//if
		
	})//function
			
	uploadUL.append(str);
	
}//showUploadResult 559
</script>

<script>
$(document).ready(function() {
	(function() {
		var bno = '<c:out value="${free.bno}"/>';
		$.getJSON("/free/getAttachList", {bno:bno}, function(arr) {
			console.log(arr);
			var str = "";
			$(arr).each(function(i, attach) {
				//image type
				if(attach.fileType) {
					var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
					
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' "
					str += "data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
					str += "<span>"+attach.fileName+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image'"
					str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/display?fileName="+fileCallPath+"'>";
					str += "</div>";
					str + "</li>";
				}else {
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' "
					str += "data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
					str += "<span>"+attach.fileName+"</span><br/>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file'"
					str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/resources/img/attach.png'></a>";
					str += "</div>";
					str + "</li>";
				}
			});
			$(".uploadResult ul").html(str);
		});
	})();
})

</script>

<script>
$(".uploadResult").on("click", "button", function(e) {
	console.log("delete file");
	if(confirm("remove this file?")) {
		var targetLi = $(this).closest("li");
		targetLi.remove();
	}
});
</script>

<%@include file="../includes/footer.jsp"%>