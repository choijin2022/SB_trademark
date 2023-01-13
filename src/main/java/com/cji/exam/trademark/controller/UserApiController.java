package com.cji.exam.trademark.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UserApiController {
	@RequestMapping("/usr/home/trademarkApi")
	public String showTrademarkApi() {
		return "usr/home/trademarkApi";
	}
	
//	@RequestMapping("/usr/home/test.do")
//	@ResponseBody
//	public String test(String test) {
//		
//		System.out.println(test);
//		
//		return test;
//	}
	
	
}
