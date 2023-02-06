package com.cji.exam.trademark.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cji.exam.trademark.service.StoredTrademarkService;
import com.cji.exam.trademark.vo.Trademark;

@Controller
public class UserWorkSpaceController {
	
	private StoredTrademarkService storedTrademarkService;
	
	@Autowired
	UserWorkSpaceController(StoredTrademarkService storedTrademarkService){
		this.storedTrademarkService = storedTrademarkService;
	}
	
	@RequestMapping("/usr/workSpace/myWorkSpace")
	public String myWorkspace() {
		return "usr/workSpace/myWorkSpace";
	}
	

	@RequestMapping("/usr/workSpace/storedTrademark")
	@ResponseBody
	public int storedTrademark(String test) {
//		System.out.println(test);
		String[] testArr = test.split("!");
//		System.out.println("test1 : " + testArr[0]);
//		System.out.println("test2 : " + testArr[1]);
		
		/*
		//리스트맵  -> 메소드
		
		List<Map<String, String>> listMap =  SetListMap(testArr);
		
		System.out.println("List Map Insert : " + listMap.toString());
		System.out.println("");
		
		*/
		//List<Trademark> list = new ArrayList<>();
		
		int totalSelectedTrademark = testArr.length;
		
		for(int i = 0; i < testArr.length; i++) {
			System.out.println(testArr[i]);
			String[] testArr2 = testArr[i].split(",",-1);
			
			Trademark trademark = new Trademark();
			trademark.setIndexNo(testArr2[0]);
			trademark.setTitle(testArr2[1]);
			trademark.setApplicantName(testArr2[2]);
			trademark.setApplicationNumber(testArr2[3]);
			trademark.setApplicationDate(testArr2[4]);
			trademark.setPublicationNumber(testArr2[5]);
			trademark.setPublicationDate(testArr2[6]);
			trademark.setRegistrationNumber(testArr2[7]);
			trademark.setRegistrationDate(testArr2[8]);
			trademark.setRegistrationPublicNumber(testArr2[9]);
			trademark.setRegistrationPublicDate(testArr2[10]);
			trademark.setPriorityNumber(testArr2[11]);
			trademark.setPriorityDate(testArr2[12]);
			trademark.setInternationalRegisterNumber(testArr2[13]);
			trademark.setInternationalRegisterDate(testArr2[14]);
			trademark.setApplicationStatus(testArr2[15]);
			trademark.setClassificationCode(testArr2[16]);
			trademark.setViennaCode(testArr2[17]);
			trademark.setAgentName(testArr2[18]);
			trademark.setRegPrivilegeName(testArr2[19]);
			trademark.setFullText(testArr2[20]);
			trademark.setDrawing(testArr2[21]);
			trademark.setBigDrawing(testArr2[22]);
//			int rowNum = Integer.parseInt(testArr2[23]);
//			trademark.setNumOfRows(rowNum);
			
			storedTrademarkService.storedTrademark(trademark);
			System.out.println(trademark);
//			list.add(trademark);
//			for(int j = 0; j < testArr2.length; j++) {
//				System.out.println(testArr2[j]);
//				
//				
////				list.add(testArr2[j]);
//				
//			}
		}
		
		/*
		System.out.println("list : " + list);
		storedTrademarkService.storedTrademark(list);
		*/
		return totalSelectedTrademark;
	}
/*
	private List<Map<String, String>> SetListMap(String[] testArr) {
		List<Map<String, String>> ListMap = new ArrayList<>();
		
		for(int i = 0; i < testArr.length; i++) {
			String[] testArr2 = testArr[i].split(",",-1);
			Map<String, String> map = new HashMap<>();
			map.put("indexNo", testArr2[0]);
			map.put("applicantName", testArr2[1]);
			map.put("applicationNumber", testArr2[2]);
			map.put("applicationDate", testArr2[3]);
			map.put("publicationNumber", testArr2[4]);
			map.put("publicationDate", testArr2[5]);
			map.put("registrationNumber", testArr2[6]);
			map.put("registrationDate", testArr2[7]);
			map.put("registrationPublicNumber", testArr2[8]);
			map.put("registrationPublicDate", testArr2[9]);
			map.put("priorityNumber", testArr2[10]);
			map.put("priorityDate", testArr2[11]);
			map.put("internationalRegisterNumber,", testArr2[12]);
			map.put("internationalRegisterDate", testArr2[13]);
			map.put("applicationStatus", testArr2[14]);
			map.put("classificationCode", testArr2[15]);
			map.put("viennaCode", testArr2[16]);
			map.put("agentName", testArr2[17]);
			map.put("regPrivilegeName", testArr2[18]);
			map.put("fullText", testArr2[19]);
			map.put("drawing", testArr2[20]);
			map.put("bigDrawing", testArr2[21]);
			
			ListMap.add(map);
			for (String mapKey : map.keySet()) {
				System.out.println("key : " + mapKey + " / " + "value : " + map.get(mapKey));
			}
		}
		return ListMap;
	}
	*/
}
