<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../../../resources/css/search.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"
   integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
   crossorigin="anonymous"></script>

<style type="text/css">
/* 상품 표 */
	.list_search_result{
		width: 90%;
	    margin: auto;	
	}
	.type_list{
	    width: 100%;
	    border-bottom: 1px solid #e7e7e7;
	    border-collapse: collapse;	
	}
	.type_list tr{
		height:200px;
		border-bottom: 1px solid #e7e7e7;
	}
	.detail div{
		margin-bottom: 5px;
	}
	.title{
	    font-size: 20px;
	    color: #3a60df;

		margin-left: 100px
}
	.price{
		text-align: center;
	}

/* 페이지 버튼 인터페이스 */
	.pageMaker_wrap{
		text-align: center;
	    margin-top: 30px;
	    margin-bottom: 40px;
	}
	.pageMaker{
	    list-style: none;
	    display: inline-block;
	}	
	.pageMaker_btn {
	    float: left;
	    width: 40px;
	    height: 40px;
	    line-height: 40px;
	    margin-left: 20px;
	}
	.active{
		border : 2px solid black;
		font-weight:400;
	}
	.next, .prev {
	    border: 1px solid #ccc;
	    padding: 0 10px;
	}
	.pageMaker_btn a:link {color: black;}
	.pageMaker_btn a:visited {color: black;}
	.pageMaker_btn a:active {color: black;}
	.pageMaker_btn a:hover {color: black;}
	.next a, .prev a {
	    color: #ccc;
	}
	
	
	/* 상품 이미지 관련 */
		.image_wrap {
		    width: 130%;
		    height: 130%;
		}	
		.image_wrap img {
		    max-width: 130%;
		    height: auto;
		    display: block;
		}
</style>
</head>
<body>

<div class="wrapper">
	<div class="wrap">
			<div class="search_area">
                	<div class="search_wrap">
                		<form id="searchForm" action="/search" method="get">
                			<div class="search_input">
                				<select name="type">
                					<option value="T">책 제목</option>
                					<option value="A">작가</option>
                				</select>
                				<input class="searchInput" type="text" name="keyword" value="<c:out value="${pageMaker.cri.keyword}"/>">
                    			<button class='searchBtn'>검 색</button>       		
                			</div>
                		</form>
                	</div>
			</div>
		<div class="content_area">
			<!-- 게시물 o -->
			<c:if test="${listcheck != 'empty'}">
				<div class="list_search_result">
					<table class="type_list">
						<colgroup>
							<col width="110">
							<col width="*">
							<col width="120">
							<col width="120">
							<col width="120">
						</colgroup>
						<tbody id="searchList>">
							<c:forEach items="${list}" var="list">
								<tr>
									<td class="image">
									<div class="image_wrap" data-shipid="${list.imageList[0].shipId}" data-path="${list.imageList[0].uploadPath}" data-uuid="${list.imageList[0].uuid}" data-filename="${list.imageList[0].fileName}">
										<img>
									</div>
									</td>
									<td class="detail">
										
										<div class="title">
										<a href="/goodsDetail/${list.shipId}">
											${list.shipName}</a>
										</div>
							
									</td>
									<td class="info">
										<div class="rating">
											평점(추후 추가)
										</div>
									</td>
									<td class="price">
										<div class="org_price">
											
												${list.shipPrice} $
											
										</div>
									</td>
									<td class="option"></td>
								</tr>
							</c:forEach>
						</tbody>
					
					</table>
				</div>
				<!-- 페이지 이동 인터페이스 -->
				<div class="pageMaker_wrap">
					<ul class="pageMaker">
	                			
						<!-- 이전 버튼 -->
						<c:if test="${pageMaker.prev }">
	               			<li class="pageMaker_btn prev">
	               				<a href="${pageMaker.pageStart -1}">이전</a>
	               			</li>
						</c:if>
	               			
	               		<!-- 페이지 번호 -->
	               		<c:forEach begin="${pageMaker.pageStart }" end="${pageMaker.pageEnd }" var="num">
	               			<li class="pageMaker_btn ${pageMaker.cri.pageNum == num ? 'active':''}">
	               				<a href="${num}">${num}</a>
	               			</li>	
	               		</c:forEach>
	               		
	                   	<!-- 다음 버튼 -->
	                   	<c:if test="${pageMaker.next}">
	                   		<li class="pageMaker_btn next">
	                   			<a href="${pageMaker.pageEnd + 1 }">다음</a>
	                   		</li>
	                   	</c:if>
					</ul>
				</div>	
				
				<form id="moveForm" action="/search" method="get" >
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
					<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
		

				</form>
			</c:if>
			<!-- 게시물 x -->
			<c:if test="${listcheck == 'empty'}">
				<div class="table_empty">
					검색결과가 없습니다.
				</div>
			</c:if>
		</div>
	</div>	
</div>

<script type="text/javascript">
$(document).ready(function(){
	
	// 검색 타입 selected
	const selectedType = '<c:out value="${pageMaker.cri.type}"/>';
	if(selectedType != ""){
		$("select[name='type']").val(selectedType).attr("selected", "selected");	
	}
	
	/* 이미지 삽입 */
	$(".image_wrap").each(function(i, obj){
		
		const bobj = $(obj);
		
		if(bobj.data("shipid")){
			const uploadPath = bobj.data("path");
			const uuid = bobj.data("uuid");
			const fileName = bobj.data("filename");
			
			const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
			
			$(this).find("img").attr('src', '/display?fileName=' + fileCallPath);
			
		} else {
			
			$(this).find("img").attr('src', '/resources/image/goodsNoImage.png');
			
		}
		
	});		
	
});
/* 페이지 이동 버튼 */
const moveForm = $('#moveForm');

$(".pageMaker_btn a").on("click", function(e){
	
	e.preventDefault();
	
	moveForm.find("input[name='pageNum']").val($(this).attr("href"));
	
	moveForm.submit();
	
});






</script>


</body>
</html>