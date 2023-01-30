package com.cji.exam.trademark.controller;

import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.cji.exam.trademark.vo.Trademark;

@Controller
public class UserApiController {
	@RequestMapping("/usr/home/trademarkApi2")
	public String trademarkApi2() {
		return "usr/home/trademarkApi2";
	}
	
//	@RequestMapping("/usr/home/test.do")
//	@ResponseBody
//	public String test(String test) {
//		
//		System.out.println(test);
//		
//		return test;
//	}
	@RequestMapping("/usr/home/searchTrademard")
	public String doSearchTrademard(Model model, @RequestParam(defaultValue = "1") int page,int numOfRows, String searchString, String title) {
		List<Trademark> trademarks = new ArrayList<>();
		String totalCount;
		
		try {
			String url = "http://kipo-api.kipi.or.kr/openapi/service/trademarkInfoSearchService/getWordSearch";
//			String serviceKey = "eCIuH7bLNd1BmdIIqpFa2FTMadwqxJ539ME6QtSZmTYlwAsadP88mzc4vBo%2BnxSaE32b6SeLZ7wKfLxE42jSxQ%3D%3D";
//			String serviceKey = "WTh4nA6jgRy5Jxmw4vhBoRbWDJFex7P%2BNr1NnXssp1P6N6NDjsY5hEZnOLCS4NEOpS8SSkrREQp%2FqX%2BsrB42DQ%3D%3D";
			String serviceKey = "sd2%2Fw1FPMP7dCiLT1r8GNJatfwBCKhZfFVQAA3lNV55hr4o2tNP9B0NpNBn7iAGvAN8QwKTBfli73H%2Fdq7xZBw%3D%3D";
			//
//			String searchKeywork = searchString;
			
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document documentInfo = dBuilder.parse(url + "?ServiceKey=" + serviceKey + "&numOfRows=" + numOfRows +"&searchString=" + searchString);
			
			documentInfo.getDocumentElement().normalize();
			System.out.println("root tag : " + documentInfo.getDocumentElement().getNodeName());
			//수정 시작
			
			
			NodeList nCoutnNode = documentInfo.getElementsByTagName("count");
			totalCount = getTotalCount(nCoutnNode);
			System.out.println("totalCount : "+totalCount);
			
			// 수정 끝
			NodeList nList = documentInfo.getElementsByTagName("item");
			System.out.println("파싱할 tag수 : " + nList.getLength());
			System.out.println(nList.getLength());
			for(int temp = 0; temp < nList.getLength(); temp++) {
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE) {
					Element eElement = (Element) nNode;
					
					System.out.println(getTagValue("indexNo", eElement));
					// Trademark 객체 생성 후 저장
					Trademark trademark = new Trademark();
					
					trademark.setSearchString(searchString);
					trademark.setTotalCount(totalCount);
					trademark.setIndexNo(getTagValue("indexNo", eElement));
					trademark.setApplicantName(getTagValue("applicantName", eElement));
					trademark.setApplicationNumber(getTagValue("applicationNumber", eElement));
					trademark.setApplicationDate(getTagValue("applicationDate", eElement));
					trademark.setPublicationNumber(getTagValue("publicationNumber", eElement));
					trademark.setPublicationDate(getTagValue("publicationDate", eElement));
					trademark.setRegistrationNumber(getTagValue("registrationNumber", eElement));
					trademark.setRegDate(getTagValue("registrationDate", eElement));
					trademark.setRegistrationPublicNumber(getTagValue("registrationPublicNumber", eElement));
					trademark.setRegistrationPublicDate(getTagValue("registrationPublicDate", eElement));
					trademark.setPriorityNumber(getTagValue("priorityNumber", eElement));
					trademark.setPriorityDate(getTagValue("priorityDate", eElement));
					trademark.setInternationalRegisterNumber(getTagValue("internationalRegisterNumber", eElement));
					trademark.setInternationalRegisterDate(getTagValue("internationalRegisterDate", eElement));
					trademark.setApplicationStatus(getTagValue("applicationStatus", eElement));
					trademark.setClassificationCode(getTagValue("classificationCode", eElement));
					trademark.setViennaCode(getTagValue("viennaCode", eElement));
					trademark.setAgentName(getTagValue("agentName", eElement));
					trademark.setRegPrivilegeName(getTagValue("regPrivilegeName", eElement));
					trademark.setFullText(getTagValue("fullText", eElement));
					trademark.setDrawing(getTagValue("drawing", eElement));
					trademark.setBigDrawing(getTagValue("bigDrawing", eElement));
					
					// 페이지 정보
					int totalCnt = Integer.parseInt(totalCount);
					int pagesCount = setPage(page, totalCnt, numOfRows);
					
					trademark.setPage(page);
					trademark.setItemsTotalCount(totalCnt);
					trademark.setItemsInAPage(numOfRows);
					trademark.setPagesCount(pagesCount);
					
					System.out.println(trademark);
					
					
					trademarks.add(trademark);
					
//					model.addAttribute("trademark", trademark);
//					System.out.println("indexNo : " + getTagValue("indexNo", eElement));
//					System.out.println("applicationDate : " + getTagValue("applicationDate", eElement));
					
				}
			}
			// ??
			model.addAttribute("trademarks", trademarks);
			System.out.println(trademarks);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "usr/home/searchTrademard";
	}
	
	private int setPage(int page, int totalCnt, int numOfRows) {
		int pagesCount = (int) Math.ceil((double) totalCnt / numOfRows);
		return pagesCount;
	}

	private String getTotalCount(NodeList nCoutnNode) {
		String totalCount="";
		for(int temp = 0; temp < nCoutnNode.getLength(); temp++) {
			Node nCntNode = nCoutnNode.item(temp);
			if(nCntNode.getNodeType() == Node.ELEMENT_NODE) {
				Element eElement = (Element) nCntNode;
				
				totalCount = getTagValue("totalCount", eElement);
				
			}
			
		}		
		
		return totalCount;
	}

	private static String getTagValue(String tag, Element eElement) {
		NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
		Node nValue = (Node) nlList.item(0);
		if(nValue == null) {
			return null;
		}
		return nValue.getNodeValue();
	}
	
	@RequestMapping("/usr/home/stored")
	@ResponseBody
	public List<Trademark> storedTrademark() {
		List<Trademark> trademarks = new ArrayList<>();
		
		
		return trademarks;
	}
}
