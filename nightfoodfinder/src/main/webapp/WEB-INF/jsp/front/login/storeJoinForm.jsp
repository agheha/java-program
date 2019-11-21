<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="/WEB-INF/jsp/include/head.jsp">
	<c:param name="msg" value="회원가입" />
</c:import>
<style>
.lModal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
.modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 50%; /* Could be more or less, depending on screen size */                          
        }
 /* The Close Button */
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        
.memSel span {
	float : left;
}        
.memInput {
	display : none;
}
</style>
<meta charset="UTF-8">
<title>Store Join Page</title>
</head>
<body>
  <%
    String clientId = "VudeSYc56HfJGEFd5VnK";//애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://localhost:8000/nightfoodfinder/front/login/ncallback.do", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
    apiURL += "&client_id=" + clientId;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&state=" + state;
    session.setAttribute("state", state);
 %>
	<div class="wrapper sJoin_wrap">
		<c:import url="/WEB-INF/jsp/include/header.jsp" />
		<div class="content">
		
		<div><button id="lBtn" class="lBtn">login</button></div>
		<div id="lModal" class="lModal" >
			<div class="modal-content">
		        <span id="close" class="close">&times;</span>
		        <h1>NFF</h1>                                                               
				<p class="memSel">
					<span>
						<input type="radio" id="userType1" name="r" checked>
						<label for="userType1" id="userLabel1">개인회원</label>
					</span>
				</p>
				<p>
					<span>
						<input type="radio" id="userType2" name="r">
						<label for="userType2" id="userLabel2">점주회원</label>
					</span>
				</p>
				<div class="memInput" id="memInput">
					<form id="memForm" action="" onsubmit="return memChk()">
						<p>
							<input type="text" name="storeEmail" id="storeEmail" placeholder="이메일을 입력해주세요"/>
						</p>
						<p>
							<input type="password" name="storePass" id="storePass" placeholder="비밀번호를 입력해주세요"/>
						</p>
						<p><button>로그인</button></p>
					</form>
				</div>
				<div class="snsBox" id="snsBox">
					<ul>
						<li>
							 <a href="<%=apiURL%>" target="_blank"><img height="50" src="${pageContext.request.contextPath}/resources/images/nLoginIcon.PNG"/></a>
						</li>
						<li></li>
					</ul>
				</div>
	      	</div>
		</div>
		<div id="storeJoinForm">
			<form name="form" id="form" method="post" onsubmit="">
			<table>
				<tr>
					<th>가게 이름</th>
					<td><input type="text" name="storeName" /></td>
				</tr>
				<tr>
					<th>사업자 번호</th>
					<td><input type="text" name="businessNum" /></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="text" id="storeEmail" name="storeEmail" placeholder="이메일을 입력해주세요"/>
						<div id="emailChk"></div>
					</td>
				</tr>
				
				<tr>
					<th>비밀번호</th>
					<td><input type="text" name="storePass" />
						<div id="pwChk"></div>
					</td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="text" name="storePass2" />
						<div id="pwChk2"></div>
					</td>
				</tr>
				<tr>
					<th>가게 전화번호</th>
					<td><input type="text" name="storeTell" /></td>
				</tr>
				<tr><th rowspan="4">주소</th></tr>
					<tr>
						<td><input type="text" id="zipNo" name="zipNo" readOnly/>
							<input type="hidden" id="sggNm" name="sggNm"/>
							<input type="button" onClick="goPopup();" value="주소찾기"/>
						</td>
					</tr>
					<tr><td><input type="text" style="width:300px;" id="roadFullAddr"  name="roadFullAddr" readOnly/></td></tr>
					<tr><td><input type="text" style="width:300px;" id="addrDetail"  name="addrDetail" readOnly/></td></tr>
				
				<tr>
					<th>영업 시간</th>
					<td><select>
							<c:forEach begin="0" end="24" var="i">
								<option name="openH" value="${i}">${i}</option>
							</c:forEach>
					</select>시 
					<select>
							<c:forEach begin="0" end="59" var="i">
								<option name="openM" value="${i}">${i}</option>
							</c:forEach>
					</select>분 - 
					<select>
							<c:forEach begin="0" end="24" var="i">
								<option name="closeH" value="${i}">${i}</option>
							</c:forEach>
					</select>시 
					<select>
							<c:forEach begin="0" end="59" var="i">
								<option name="closeM" value="${i}">${i}</option>
							</c:forEach>
					</select>분</td>
				</tr>
				<tr>
					<th>휴무일</th>
					<td>
						<input type="checkbox" name="day1" value="1"/>월
						<input type="checkbox" name="day2" value="2"/>화
						<input type="checkbox" name="day3" value="3"/>수
						<input type="checkbox" name="day4" value="4"/>목
						<input type="checkbox" name="day5" value="5"/>금
						<input type="checkbox" name="day6" value="6"/>토
						<input type="checkbox" name="day7" value="7"/>일
						
					</td>
				</tr>
				<tr>
					<th>가게 분류</th>
					<td>
						<select name="category">
							<option value="1" >한식</option>
							<option value="2" >양식</option>
							<option value="3" >중식</option>
							<option value="4" >세계음식</option>
							<option value="5" >카페</option>
							<option value="6" >주점</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>대표자 이름</th>
					<td><input type="text" name="storeOwner" /></td>
				</tr>
				<tr>
					<th>대표자 휴대폰 번호</th>
					<td><input type="text" name="storeOwnerPh" /></td>
				</tr>
			</table>
			<button id="reg_submit">가입하기</button>
			</form>	
		</div>
		</div>
	</div>
<script>
//로그인모달 임시
var uType1 = document.getElementById("userType1");
var uType2 = document.getElementById("userType2");
var mInput = document.getElementById("memInput");
var snsBox = document.getElementById("snsBox");
uType1.onclick = function() {
	mInput.style.display = "none";
	snsBox.style.display = "block";
}
uType2.onclick = function() {
	snsBox.style.display = "none";
	mInput.style.display = "block";
}


var btn = document.getElementById("lBtn");
var modal = document.getElementById("lModal");
var span = document.getElementById("close");

btn.onclick = function () {
	modal.style.display = "block";
}
span.onclick = function () {
	modal.style.display = "none";
}
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}




//주소입력 팝업부분
function goPopup(){
	var pop = window.open("/nightfoodfinder/api/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
}

function jusoCallBack(roadFullAddr,zipNo,addrDetail,sggNm){
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		document.form.roadFullAddr.value = roadFullAddr;
		document.form.addrDetail.value = addrDetail;
		document.form.zipNo.value = zipNo;
		document.form.sggNm.value = sggNm;
	
}
//이메일 검사 정규식
var idJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;





//이메일 중복체크
$("#storeEmail").blur(function() {
		var storeEmail = $('#storeEmail').val();
		$.ajax({
			url : '${pageContext.request.contextPath}/front/login/storeEmailChk.do?storeEmail='+ storeEmail,
			success : function(data) {
				console.log("1 = 중복o / 0 = 중복x : "+ data);							
				
				if (data == 1) {
						// 1 : 아이디가 중복되는 문구
						$("#emailChk").text("사용중인 이메일입니다");
						$("#emailChk").css("color", "red");
						$("#reg_submit").attr("disabled", true);
					} 
				else {
						if(idJ.test(storeEmail)){
							// 0 : 아이디 길이 / 문자열 검사
							$("#emailChk").text("");
							$("#reg_submit").attr("disabled", false);
				
						} else if(storeEmail == ""){
							
							$('#emailChk').text('이메일을 입력해주세요');
							$('#emailChk').css('color', 'red');
							$("#reg_submit").attr("disabled", true);				
							
						} else {
							
							$('#emailChk').text("올바른 형식의 이메일을 입력해주세요.");
							$('#emailChk').css('color', 'red');
							$("#reg_submit").attr("disabled", true);
						}
						
					} 
				}, error : function() {
						console.log("실패");
						console.log(data);
				}
			});
		});




</script>	
</body>
</html>