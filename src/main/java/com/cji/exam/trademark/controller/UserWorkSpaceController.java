package com.cji.exam.trademark.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cji.exam.trademark.vo.Trademark;

@Controller
public class UserWorkSpaceController {
	@RequestMapping("/usr/workSpace/myWorkSpace")
	public String myWorkspace() {
		return "usr/workSpace/myWorkSpace";
	}
	
//	@RequestMapping("/usr/workSpace/storedTrademark")
//	@ResponseBody
//	public Trademark storedTrademark(Trademark trademark) {
//		
//		System.out.println(trademark);
//		return trademark;
//	}
	
//	@RequestMapping("/usr/workSpace/storedTrademark")
//	@ResponseBody
//	public List<String> storedTrademark(@RequestParam(defaultValue = "") List<String> tradeMark) {
//		
//		/*
//		 * for(String a : tradeMark.split(",")) { System.out.println(a); }
//		 */
//		
//		return tradeMark;
//	}
	@RequestMapping("/usr/workSpace/storedTrademark")
	@ResponseBody
	public Trademark storedTrademark(Trademark trademark) {
		
//		for(String a : trademark.split("|")) {
//			System.out.println(a);
//		}
		System.out.println("=============" + trademark);
		
		String indexNo;
		String applicantName;
		String applicationDate;
		
		indexNo = trademark.getIndexNo();
		applicantName = trademark.getApplicantName();
		applicationDate = trademark.getApplicationDate();
		
		System.out.println(indexNo);
		System.out.println(applicantName);
		System.out.println(applicationDate);
		
		return trademark;
	}
	
}
