<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<head>
<c:import url="/WEB-INF/jsp/include/head.jsp">
	<c:param name="msg" value="상세페이지" />
</c:import>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
</head>
<body>
	<div class="wrapper detail_wrap">
		<c:import url="/WEB-INF/jsp/include/header.jsp" />
		
		<div id="storedetail" class="content clearboth">
			<div class="slick" style="width: 100%">
			<c:choose>
				<c:when test="${empty imgList}">
						<div>
		   					<img src="https://365psd.com/images/istock/previews/1005/100574873-dish-fork-and-knife-icons-cutlery-sign.jpg" />
						</div>
						<div>
		   					 <img src="https://365psd.com/images/istock/previews/1005/100574873-dish-fork-and-knife-icons-cutlery-sign.jpg" />
						</div>
						<div>
						    <img src="https://365psd.com/images/istock/previews/1005/100574873-dish-fork-and-knife-icons-cutlery-sign.jpg" />
						</div>
				</c:when>
				<c:otherwise>
				 <c:set value="${fn:length(imgList)}" var="size" />
					<c:forEach items="${imgList}" var="img" varStatus="i" end="${size}">
					<c:choose>
					<c:when test="${size < 2}">
							<div>
								<img src="${pageContext.request.contextPath}/front/store/getByteImage.do?name=${img.sysName}&path=${img.path}" />
							</div>
							<div>
			   					 <img src="https://365psd.com/images/istock/previews/1005/100574873-dish-fork-and-knife-icons-cutlery-sign.jpg" />
							</div>							
							<div>
			   					 <img src="https://365psd.com/images/istock/previews/1005/100574873-dish-fork-and-knife-icons-cutlery-sign.jpg" />
							</div>							
					</c:when>
					<c:otherwise>
								<div>
									<img src="${pageContext.request.contextPath}/front/store/getByteImage.do?name=${img.sysName}&path=${img.path}" />
								</div>
					</c:otherwise>
					</c:choose>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			</div>
					
			</div>	
			

			<div id="detaillistjs">
				<div id="storeinfo">
					<div id="stinfo">
						<div id="star">
							<div>
								<img src="${pageContext.request.contextPath}/resources/images/star.png"	alt="별" />
							</div>
							<div id="scopescore"></div>
						</div>
						<div id="stTitle">
							<h2>${store.storeName}</h2>
							<ul>
								<li><a href="#" class="frequent"><i
										class="fa fa-bookmark-o" aria-hidden="true"></i>단골</a></li>
								<li class="tab_share"><a href="#"><i
										class="fa fa-share-square-o" aria-hidden="true"></i>공유</a> <!-- 공유 팝업 -->
									<div class="sharePop hidden">
										<ul class="clearboth">
											<li><a
												href="https://twitter.com/intent/tweet?text=심야식당 서울 강동구 강동대로 205 (출처 : 심야식당)&url=http://www.naver.com"
												target="_blank"><img
													src="${pageContext.request.contextPath }/resources/images/f_twitter.png" /></a></li>
											<li><a
												href="http://www.facebook.com/sharer/sharer.php?u=http://naver.com"
												target="_blank"><img
													src="${pageContext.request.contextPath }/resources/images/icon_facebookS.png" /></a></li>
											<li><a href="#" id="kakao-link-btn" href="javascript:;"><img
													src="${pageContext.request.contextPath }/resources/images/icon_kakao.png" />카카오톡</a></li>
										</ul>
										<div class="clearboth">
											<p class="ellipsis">https://app.slack.com/client/TPPHA763F/CPPH24F16/files/FPJQPCU4R</p>
											<a href="#" id="copyclip">복사</a>
										</div>
									</div></li>
								<!-- 맨 아래 지도로 보내는 a링크 -->
								<li><a href="#"><i class="fa fa-car" aria-hidden="true"></i>길찾기</a></li>
							</ul>
						</div>
						<table>
							<tbody>
								<tr>
									<th rowspan="2"><i class="fa fa-phone iicon"
										aria-hidden="true"></i></th>
									<td class="tabletitlefont">Tel</td>
								</tr>
								<tr>
									<td class="tabletdfont">${store.storeTell}</td>
								</tr>
							</tbody>
						</table>
						<table>
							<tbody>
								<tr>
									<th rowspan="2"><i class="fa fa-map-marker iicon"
										aria-hidden="true"></i></th>
									<td class="tabletitlefont">Location</td>
								</tr>
								<tr>
									<td class="tabletdfont">${store.streetLoad}</td>
								</tr>
							</tbody>
						</table>
						<table>
							<tbody>
								<tr>
									<th rowspan="4" id="clock"><i class="fa fa-clock-o iicon"
										aria-hidden="true"></i></th>
									<td class="tabletitlefont">Time</td>
								</tr>
								<tr>
									<td class="tabletdfont" id="operatingtime">${store.openTime} ~ ${store.closeTime}</td>

								</tr>
								<tr>
									<td class="tabletitlefont">Holiday</td>
								</tr>
								<tr>
									<td class="tabletdfont"><c:forEach items="${holidaylist}"
											var="h" varStatus="comma">
											${h.weekName}
										<c:if test="${not comma.last}">,</c:if>
										</c:forEach></td>
								</tr>
							</tbody>
						</table>
						<table>
							<tbody>
								<tr>
									<th><i class="fa fa-file-text-o iicon" aria-hidden="true"></i></th>
									<td class="tabletitlefont">Menu</td>
								</tr>
							</tbody>
						</table>
						<div class="menulist" class="tabletdfont">
							<c:forEach items="${menu}" var="m">
								${m.menu} : ${m.price} <br>
							</c:forEach>
						</div>
						<table>
							<tbody>
								<tr>
									<th><i class="fa fa-cutlery iicon" aria-hidden="true"></i></th>
									<td class="tabletitlefont">Introduce</td>
								</tr>
						</table>
						<div class="menulist" id="introduce"></div>
						<div id="btdiv">
						</div>


					</div> 

					<!-- 댓글  -->

					<div id="commentplace">
						<div class="commentwrap">
							<ul class="clearboth">
								<li class="float_l">Review</li>
								<li id="btn_leave_rv" class="float_r"><a
									href="${pageContext.request.contextPath}/front/store/storeReviewRegistForm.do?storeNo=${store.storeNo}">
										<i class="fa fa-plus-circle" aria-hidden="true"></i>리뷰남기기
								</a></li>
							</ul>
							<div id="targetContainer"></div>
						
							<!-- 페이징 -->
							<div id="paginationBox"></div>

						</div>
					</div>
					<!-- // 댓글 끝 -->

				</div>
			</div>
		</div>

		<!-- 푸터 -->
<%-- 		<%-- <c:import url="/WEB-INF/jsp/include/footer.jsp" /> --%> --%>

		<!-- 팝업 백그라운드  -->
		<div class="bgbox"></div>
		<!-- 신고팝업 -->
		<div id="rmyModal" class="rmodal" style="display: none"></div>
	<script src="${pageContext.request.contextPath}/resources/js/slick.min.js"></script>
	<script type="text/javascript">
		let imglist = `${imgList}`;
		console.log("imglist", imglist.size);
		console.dir(imglist);
		let no = ${store.storeNo};
		let scope = ${store.scope};
		let openTime = '${store.openTime}';
		let closeTime = '${store.closeTime}';
		let context = '${pageContext.request.contextPath}';
		let storeNo = '${store.storeNo}';
		let storeName = '${store.storeName}';
		let storeScope = "";
		let fileGroupCode = null;
		let userNo = '${user.userNo}';
		if(userNo === ""){
			userNo = 0;
		}
		let loginStore = "";
		if('${loginStore.storeNo}' === ""){
			loginStore = 0;
		} else {
			loginStore = '${loginStore.storeNo}';
		}
		console.log("storeNo: ", storeNo);
		if(loginStore === storeNo){
	        $("#btdiv").append(
	                `<span id="updatebutton" onclick="location.href='${pageContext.request.contextPath}/front/store/storecontentupdateForm.do?no=${store.storeNo}'">수정하기</span>`
	                    );
	    }
		
		let content = `${storeContent.storeContent}`;
		if(content === ""){
			$("#introduce").append("소개글을 입력해주세요");
		} else {
			$("#introduce").append(content);
			
		}
// 		console.dir(`${imgList}`);
/*slick*/

$(".slick").slick(
  { infinite: true , /* 맨끝이미지에서 끝나지 않고 다시 맨앞으로 이동 */ 
    slidesToShow: 2, /* 화면에 보여질 이미지 갯수*/
    slidesToScroll: 1, /* 스크롤시 이동할 이미지 갯수 */
    autoplay: false, /* 자동으로 다음이미지 보여주기 */
    arrows: true, /* 화살표 */
    dots:false, /* 아래점 */ 
    autoplaySpeed:10000,/* 다음이미지로 넘어갈 시간 */ 
    speed:1000 , /* 다음이미지로 넘겨질때 걸리는 시간 */
    pauseOnHover:false, /* 마우스 호버시 슬라이드 이동 멈춤 */ 
    //vertical:true,/* 세로방향으로 슬라이드를 원하면 추가하기// 기본값 가로방향 슬라이드*/
     
  }
  );
  
  if(${store.status} != 1){
	  $("#storedetail").html('<div>가입승인 대기를 기다려주세요</div>');
  }


 




	</script>
	<script src="<c:url value='/resources/js/storedetail.js' />"></script>
	<script type='text/javascript'>
		//<![CDATA[
		// // 사용할 앱의 JavaScript 키를 설정해 주세요.
		Kakao.init('1a3bc389425e8dd17496e8a2a68ed3a4');
		// // 카카오링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.
		Kakao.Link.createCustomButton({
			container : '#kakao-link-btn',
			templateId : 19523,
			templateArgs : {
				'title' : '제목 영역입니다.',
				'description' : '설명 영역입니다.'
			}
		});
		//]]>
	</script>
	<script src="<c:url value='/resources/js/storage.js' />"></script>
</body>
</html>
