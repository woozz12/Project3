<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- css 가져오기 -->
<link href="${pageContext.request.contextPath}/css/style.css"
	rel="stylesheet">
<!-- reset css -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	rel="stylesheet">

<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/commons.js" defer></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/spotifyApi.js" defer></script>

</head>

<body>

	<!-- 왼쪽 고정 menu, controller -->
	<div class="side">

		<!-- 페이지 넘어갈 곳 -->
		<div class="menu">
			<!-- 로그아웃상태에선 로그인, 회원가입 넣기 -->
			<c:if test="${accessToken == null}">
				<div>
					<a href="/mrs/login" class="spotify-login-button">
						<img src="${pageContext.request.contextPath}/img/Spotify_Logo_RGB_Black.png" alt="Spotify Logo" class="spotify-logo"> 
						<span class="login-text">로그인</span>
					</a>
					<h3 id="test_text"></h3>
				</div>
			</c:if>
			<!-- 로그인 되어있으면 환영인사. -->
			<c:if test="${accessToken != null}">
				<h1></h1>
				<h3 class="testCl">환영합니다.</h3>
				<a href="/mrs/logOut" class="logOut">log out</a>
			</c:if>

			<a class="mainBtn" href="#">main page</a>
			<a class="videoBtn" href="#">video page</a>
		</div>

		<!-- 에어팟 이미지 -->
		<div class="imgDiv">
			<img id="airImg"
				src="${pageContext.request.contextPath }/img/air.png" alt="#">
		</div>
		<section id="controller">
		<div class="display">
			<div class="flex">
				<div class="image">
					<img>
				</div>
				<div class="title"></div>
				<div class="artists"></div>
			</div>
			<ul class="play-lists">

			</ul>
		</div>
		<input type="hidden" value="${accessToken}" name="token">
		<div class="btns">
			<button id="test-btn" class="hidden">아이디 받아오기</button>
			<button id="test-btn2">재생해보기</button>
			<button id="test-btn3">재생중인 트랙확인</button>
			<button id="test-btn31">재생중인 리스트확인</button>
			<button id="test-btn5">곡 추가</button>
			<button id="previousTrack">이전 곡</button>
			<button id="nextTrack">다음 곡</button>
			<button id="togglePlay">Play</button>
		</div>
	</section>
	</div>
</body>
</html>

<script>


const $testCl = document.querySelector(".testCl");
let tokenChe = 1;

	window.onload = function() {
	let myAccessToken = `${accessToken}`;
	if(myAccessToken != ``) {
		let display_name = '';
		let display_email = '';
		/* 닉네임 받아와서 사용 */
			fetch('https://api.spotify.com/v1/me', {headers : {"Authorization" : `Bearer ${accessToken}`}})
				.then(res => res.json())
				.then(data => {
					console.log(data);
					console.log(data.display_name);
					console.log(data.email);
					display_name = data.display_name;
					display_email = data.email;
					document.querySelector('.menu>h1').textContent = display_name + ' 님';
					document.querySelector('.menu>h1').name = display_name;
					console.log(document.querySelector('.menu>h1').name);
					tokenChe =2;
				});
		}
	}
	/* 로그인 안하고 다른거 눌렀을 시 */
/* 	const $main = document.querySelector(".main");
	
	if(tokenChe == 1) {
	$main.onclick = function(e) {
		console.log(e.target);
		if(!e.target.parentNode.classList.contains('spotify-login-button')) {
				alert('로그인은 필수 입니다.');
				return location.href="${pageContext.request.contextPath }/login";
			}
		}
	} */
	
	// 에어팟 클릭시 이미지 변경 및 컨트롤러 변경${pageContext.request.contextPath }

	document.getElementById('nextTrack').addEventListener('click',e=>{
		skipToNext();
	})
	document.getElementById('previousTrack').addEventListener('click',e=>{
		skipToPrevious();
	})


</script>