package com.isec.pim.common.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


/**
 * Handles requests for the application home page.
 */
@Controller
public class CommonController {
	
	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);
	
	
	/**
	 * Home 
	 * @param locale
	 * @param model
	 * @return
	 */
	@RequestMapping(value = {"/", "/index.do"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome MailPlants Admin! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate);
		
		//Session Check
		return "index";
	}
	
	/**
	 * Login
	 * @param locale
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String login(Locale locale, Model model){
		
		return "common/login";
	}
	
	@RequestMapping(value = "/logout.do", method = RequestMethod.GET)
	public String logout(Locale locale, Model model, HttpServletRequest request){
		
		HttpSession session  = request.getSession(false);
		if(session != null){
			session.removeAttribute("USERINFO");
			session.invalidate(); 
		}
		return "common/login";
	}
	

	/*@RequestMapping(value = "/loginProc", method = RequestMethod.POST)
	public String loginProc(@ModelAttribute("loginForm") UserInfo userInfoForm, BindingResult result, Locale locale, Model model) {
		logger.info("the client locale is "+ locale.toString());
		
		logger.info("Login Start...");
		logger.info("userInfo : " + userInfoForm.toString());
		// Service
		UserInfo userInfo = new UserInfo();
		//userInfo = userInfoServcie.changeInfo(userInfoForm);

		logger.info("controller userInfo : " + userInfo.toString());
		
		model.addAttribute("userInfo", userInfo);
		return "common/loginProc";
	}*/
	
	
	@RequestMapping(value = "/dext5/index.do", method = RequestMethod.GET)
	public String dext5Main(Locale locale, Model model){
		return "/dext5/index";
	}
	
	@RequestMapping(value = "/dext5/write.do", method = RequestMethod.GET)
	public String dext5Write(Locale locale, Model model){
		return "/dext5/write";
	}
	
	@RequestMapping(value = "/dext5/db_task.do", method = RequestMethod.POST)
	public String dext5DbTask(Locale locale, Model model){
		return "/dext5/db_task";
	}
	
	@RequestMapping(value = "/dext5/view.do", method = RequestMethod.GET)
	public String dext5View(@RequestParam String seq, Model model){
		
		model.addAttribute("seq", seq);
		return "/dext5/view";
	}
	
	@RequestMapping(value = "/dext5/view_cont.do", method = RequestMethod.GET)
	public String dext5ViewCont(@RequestParam String seq, Model model){
		
		model.addAttribute("seq", seq);
		return "/dext5/view_cont";
	}
	
	@RequestMapping(value = "/dext5/modify.do", method = RequestMethod.GET)
	public String dext5VModify(@RequestParam String seq, Model model){
		
		model.addAttribute("seq", seq);
		return "/dext5/modify";
	}
}
