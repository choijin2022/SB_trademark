package com.cji.exam.trademark.controller;

import java.util.ArrayList;
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
	/*
	@RequestMapping("/usr/workSpace/storedTrademark")
	@ResponseBody
	public Trademark storedTrademark(Trademark trademark) {
		
//		for(String a : trademark.split(",")) {
//			System.out.println(a);
//		}
		String [] indexNo = trademark.getIndexNo().split(",");
		String [] applicantName = trademark.getApplicantName().split(",");
		System.out.println(trademark.getApplicantName());
		
		String [] applicationNumber = trademark.getApplicationNumber().split(",");
		String [] applicationDate = trademark.getApplicationDate().split(",");
//		String [] indexNo = trademark.getIndexNo().split(",");
//		String [] indexNo = trademark.getIndexNo().split(",");
//		String [] indexNo = trademark.getIndexNo().split(",");
		
		List<Trademark> trademarks = new ArrayList<>();
		trademarks.add(trademark);
		for(int i = 0; i < indexNo.length ;i++) {
			Trademark td = new Trademark();
			td.setIndexNo(indexNo[i]);
			
			if(i>=applicantName.length) {
				td.setApplicantName(null);
			}else {
				td.setApplicantName(applicantName[i]);
				System.out.println(applicantName[i]);
			}
			if(i>=applicationNumber.length) {
				td.setApplicationNumber(null);
			}else {
				td.setApplicationNumber(applicantName[i]);
			}
			if(i>=applicationDate.length) {
				td.setApplicationDate(null);
			}else {
				td.setApplicationDate(applicantName[i]);
			}
			trademarks.add(trademark);
		}
		
		
		System.out.println("=============" + trademarks);
		
//		System.out.println(trademark.getApplicantName());
		
//		System.out.println(applicationNumber);
		
		return trademark;
	}*/
	
	@RequestMapping("/usr/workSpace/storedTrademark")
	@ResponseBody
	public Trademark storedTrademark(String test) {
		
		System.out.println(test);
		
		String[] testArr = test.split("...");
		
		System.out.println("test1 : " + testArr[0]);
		System.out.println("test2 : " + testArr[1]);
		
//		for(int i = 0; i < testArr.length; i++) {
//			System.out.println(testArr[i]);
//		}
		
//		String[] testArr2 = testArr[0].split(",");
//		
//		for(int i = 0; i < testArr2.length; i++) {
//			System.out.println(testArr2[i]);
//		}
		
//		for() {
//			
//		}
		
		return null;
	}
	
}
