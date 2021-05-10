<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
	
<%@include file="../includes/header.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script src="/ckeditor/ckeditor.js"></script>

<div class="content">
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading"></div>

				<div class="panel-body">

					<form role="form" action="/free/register" method="post">
					<input type='hidden' name="${_csrf.parameterName}" value="${_csrf.token }"/>

						<div class="form-group">
							<label>제목</label> <input class="form-control" name='title'>
						</div>


						<div class="form-group">
							<label>글쓴이</label> <input class="form-control" name='writer'
							value='<sec:authentication property="principal.username"/>' readonly="readonly">
						</div>

						<div style = "width:800px;">내용<textarea id ="content" name='content' rows = "5" cols = "80"
						placeholder = "상품설명을 입력하세요"></textarea>
						
						<button class="popup.html" onclick="window.open(/test/,'_blank','width=600,height=400'); return false">도서정보 검색</button>						
						
						<script>
						
						CKEDITOR.replace("content");
						
						</script>
						</div>
						
						<button type="submit" class="btn btn-default">등록</button>
						<button type="reset" class="btn btn-default">취소</button>
					
					</form>

				</div>

			</div>
		</div>

	</div>
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">파일첨부</div>
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
</div>



<script>
	$(document).ready(function(e) {

		let searchResult = "";
		
		const editor = $("#content");

		function setContent(htmlCode) {
			
			searchResult = htmlCode;

			editor.val(htmlCode);
			
			CKEDITOR.instances['content'].insertHtml(htmlCode);

		}

		window.setInfo = setContent;
		
		var formObj = $("form[role='form']");
		$("button[type='submit']").on("click",function(e) {
			e.preventDefault();
			console.log("submit clicked");
			var str = "";
			$(".uploadResult ul li").each(function(i, obj) {
				var jobj = $(obj);
				console.dir(jobj);
				str += "<input type='hidden' name='attachList["+ i + "].fileName' value='" + jobj.data("filename") + "'>";
				str += "<input type='hidden' name='attachList["+ i + "].uuid' value='"+ jobj.data("uuid") + "'>";
				str += "<input type='hidden' name='attachList["+ i + "].uploadPath' value='"+ jobj.data("path") + "'>";
				str += "<input type='hidden' name='attachList["+ i + "].fileType' value='"+ jobj.data("type") + "'>";
				});
			/* formObj.append(str); */
			console.log(str);
			console.log(formObj);
			
			formObj.append(str);
			setTimeout(() => {
				formObj.submit();	
			}, 1000);
			
		})//function 564
	})//function 556
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880;

	function checkExtension(fileName, fileSize) {
		if (fileSize >= maxSize) {
			alert("파일 사이즈 초과");
			return false;
		}
		if (regex.test(fileName)) {
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

			for (var i = 0; i < files.length; i++) {
				
				if (!checkExtension(files[i].name, files[i].size)) {
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url : '/uploadAjaxAction',
				processData : false,
				contentType : false,
				beforeSend : function(xhr) { xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); },
				data : formData,
				type : 'POST',
				dataType : 'json',
				success : function(result) {
					console.log(result);
					showUploadResult(result);
				}
			});
		});

	function showUploadResult(uploadResultArr) {

		if (!uploadResultArr || uploadResultArr.length == 0) {
			return;
		}

		var uploadUL = $(".uploadResult ul");
		var str = "";

		$(uploadResultArr).each(function(i, obj) {
			//image type
			if (obj.image) {
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);

			/* str += "<li><div>"*/
			str += "<li data-path='"+obj.uploadPath+"'";													
			str += "data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'";	
			str += " ><div>";
			str += "<span> " + obj.fileName + "</span>"
			/* str += 	"<button type='button' 													class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"; */
			/* str += 	"<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"; */
			str += "<button type='button' data-file=\'"+fileCallPath+"\' "
			str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			str += "<img src='/display?fileName=" + fileCallPath + "'>";
			str += "</div>";
			str + "</li>";
			} else {
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
				var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/")
				
				/* str += "<li><div>" */
				str += "<li "
				str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
				str += "<span> " + obj.fileName + "</span>"
				/* str += 	"<button type='button' 													class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"; */
				/* str += 	"<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"; */
				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' "
				str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/resources/img/attach.png'></a>";
				str += "</div>";
				str + "</li>";
				}//if
				})//function
				uploadUL.append(str);
		}//showUploadResult 559
	
	$(".uploadResult").on("click", "button", function(e) {
		
		console.log("delete file");
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		
		var targetLi = $(this).closest("li");
		
		$.ajax({
			url: '/deleteFile',
			data: {fileName: targetFile, type: type},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			dataType: 'text',
			type: 'POST',
			 success: function(result) {
				 alert(result);
				 targetLi.remove();
			 }
		});
	});
	
	$("button[type='submit']").on('click', function(e) {
		
		Swal.fire({
			position: 'center',
			  icon: 'success',
			  title: '등록완료',
			  showConfirmButton: false
		});
	});
	

	
</script>


<%@include file="../includes/footer.jsp"%>