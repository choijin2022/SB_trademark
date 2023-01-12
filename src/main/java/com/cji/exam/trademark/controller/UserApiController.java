package com.cji.exam.trademark.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserApiController {
	@RequestMapping("/usr/home/trademarkApi")
	public String showTrademarkApi() {
		return "usr/home/trademarkApi";
	}
	
}
