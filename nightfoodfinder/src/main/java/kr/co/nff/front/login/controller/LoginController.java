package kr.co.nff.front.login.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.JsonNode;
import com.github.scribejava.core.model.OAuth2AccessToken;

import kr.co.nff.front.login.service.LoginService;
import kr.co.nff.login.kakao.oauth.KakaoLogin;
import kr.co.nff.login.naver.oauth.bo.NaverLoginBO;
import kr.co.nff.login.naver.oauth.model.JsonParser;
import kr.co.nff.repository.vo.Store;
import kr.co.nff.repository.vo.User;


@Controller("kr.co.nff.front.login.LoginController")
//@RequestMapping("/front/login")
public class LoginController {
	
//	@Autowired
	
	//유저 상세 내용
	@RequestMapping("/userdetail.do")
	public void userDetail() {}
	
//카카오 로그인
	private KakaoLogin kakao;
	
//네이버 로그인

	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	/* NaverLoginBO */
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO){
		this.naverLoginBO = naverLoginBO;
	}
	
	 //로그인 첫 화면 요청 메소드
    @RequestMapping(value = "/front/login/userLoginForm.do", method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView login(Model model, HttpSession session) {
    	ModelAndView mav = new ModelAndView();
        /* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
        /* 카카오 로그인 URL 가져오기*/
        //String kakaoAuthUrl = kakao.getAuthorizationUrl(session);
        
        mav.setViewName("front/login/userLoginForm");
        
        //네이버 
        mav.addObject("naver_url", naverAuthUrl);
        //카카오
       // mav.addObject("kakao_url", kakaoAuthUrl);
        /* 생성한 인증 URL을 View로 전달 */
        return mav;
    }

    //네이버 로그인 성공시 callback호출 메소드
    @RequestMapping(value = "/front/login/ncallback.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String callback(Model model, 
    				@RequestParam String code, @RequestParam String state, 
    				HttpSession session, User vo)
            throws Exception {
    	
    	//System.out.println("여기는 callback");
    	OAuth2AccessToken oauthToken;
    	oauthToken = naverLoginBO.getAccessToken(session, code, state);
    	
    	//1. 로그인 사용자 정보를 읽어온다.
    	apiResult = naverLoginBO.getUserProfile(oauthToken); //String형식의 json데이터
    	JsonParser json = new JsonParser();
    	vo = json.changeJson(apiResult);
    	
    	
    	if (loginservice.selectNaver(vo) > 0) { // 세션만들기
			session.setAttribute("loginUser", loginservice.selectLoginOneUser(vo));
			
			// 로그인되는 유저 
//			User loginUser = (User)loginservice.selectLoginOneUser(vo.getUserId());
//			session.setAttribute("loginUser", loginUser);
			
			// 로그인된 유저의 알림리스트, 안읽은 알림 갯수 가져와서 같이 세션에 올린다.
//			Notice notice = new Notice();
//			notice.setUserNo(loginUser.getUserNo());
//			List<Notice> noticeList = noticeService.selectNotice(notice);
//			int numOfNotice = noticeService.countNewNotice(notice);
//			session.setAttribute("noticeList", noticeList);
//			session.setAttribute("countNotice", numOfNotice);
			
//			System.out.println(noticeList.toString());
//			System.out.println(numOfNotice + "알림 갯수");
			
			
			System.out.println(loginservice.selectLoginOneUser(vo));
		} else {
			loginservice.insertNaverUser(vo);
			System.out.println("첫로그인 유저"+vo);
			session.setAttribute("loginUser", loginservice.selectLoginOneUser(vo));
		}
    	
    	//"front/login/ncallback"
		//new ModelAndView("front/login/ncallback", "naverUserVO",vo)
        return "front/login/ncallback";
    }
    
    
    @RequestMapping(value = "/front/login/kakaologin.do", produces = "application/json", method = { RequestMethod.GET,
			RequestMethod.POST })
	public ModelAndView kakaoLogin(@RequestParam("code") String code, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		// 결과값을 node에 담아줌
		JsonNode node = kakao.getAccessToken(code);
		// accessToken에 사용자의 로그인한 모든 정보가 들어있음
		JsonNode accessToken = node.get("access_token");
		// 사용자의 정보
		JsonNode userInfo = kakao.getKakaoUserInfo(accessToken);
		String kemail = null;
		String kname = null;
		String kgender = null;
		String kbirthday = null;
		String kage = null;
		String kimage = null;
		// 유저정보 카카오에서 가져오기 Get properties
		JsonNode properties = userInfo.path("properties");
		JsonNode kakao_account = userInfo.path("kakao_account");
		kemail = kakao_account.path("email").asText();
		kname = properties.path("nickname").asText();
		kimage = properties.path("profile_image").asText();
		kgender = kakao_account.path("gender").asText();
		kbirthday = kakao_account.path("birthday").asText();
		kage = kakao_account.path("age_range").asText();
		session.setAttribute("kemail", kemail);
		session.setAttribute("kname", kname);
		session.setAttribute("kimage", kimage);
		session.setAttribute("kgender", kgender);
		session.setAttribute("kbirthday", kbirthday);
		session.setAttribute("kage", kage);
		mav.setViewName("main");
		return mav;
	}// end kakaoLogin()
    
    
    
    
  //로그아웃
    @RequestMapping(value = "/front/login/logout.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String logout(HttpSession session)throws IOException {
    //System.out.println("여기는 logout");
    session.invalidate();
    System.out.println("로그아웃");
    return "redirect:/front/main/main.do";
    }

    
   
//---------------------------------------------	
	@Autowired
	LoginService loginservice;
	
	
	//스토어 가입
	@RequestMapping("/front/login/storejoin.do")
	public String storeJoin(Store store) {
		System.out.println(store);
		loginservice.joinStore(store);
		return "redirect:/front/main/main.do";
	}
	// 스토어 가입폼
	@RequestMapping("/front/login/storeJoinForm.do") 
	 public void storeJoinForm(){}
	 
	//스토어 중복이메일 체크
	@RequestMapping(value="/front/login/storeEmailChk.do")
	@ResponseBody
	public int storeEmailChk(String storeEmail) {
		System.out.println("email중복체크 컨트롤러 ");
		return loginservice.storeEmailChk(storeEmail);
	}
	
	
	//스토어 로그인
	@RequestMapping("/front/login/storelogin.do")
	public String storeLogin(Store s, HttpSession session) {
		Store store = loginservice.storeLogin(s);
		if(store == null) {
			return "redirect:/front/login/userLoginForm.do";
		}
		session.setAttribute("loginStore", store);
		System.out.println(store);
		return "redirect:/front/main/main.do";
		
	}
	
	
	//스토어 로그아웃
	@RequestMapping("/storelogout.do")
	public String storeLogout(HttpSession session) {
		session.invalidate();
		return "redirect:/front/main/main.do";
	}
	//스토어 아이디찾기
	@RequestMapping("/storeidfind.do")
	public void storeIdFind() {}
	//스토어 비번찾기
	@RequestMapping("/storepassfind.do")
	public void storePassFind() {}
	
	
}

