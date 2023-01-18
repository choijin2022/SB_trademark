package com.cji.exam.trademark.controller;

import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.cji.exam.trademark.vo.Trademark;

@Controller
public class UserApiController {
	@RequestMapping("/usr/home/trademarkApi")
	public String showTrademarkApi() {
		return "usr/home/trademarkApi";
	}
	
	@RequestMapping("/usr/home/trademarkApi2")
	public String list() {
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
	public String doSearchTrademard(Model model,int numOfRows, String searchString, String title) {
		
		
		try {
			String url = "http://kipo-api.kipi.or.kr/openapi/service/trademarkInfoSearchService/getWordSearch";
			String serviceKey = "eCIuH7bLNd1BmdIIqpFa2FTMadwqxJ539ME6QtSZmTYlwAsadP88mzc4vBo%2BnxSaE32b6SeLZ7wKfLxE42jSxQ%3D%3D";
			//
//			String searchKeywork = searchString;
			
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document documentInfo = dBuilder.parse(url + "?ServiceKey=" + serviceKey + "&searchString=" + searchString);
			
			documentInfo.getDocumentElement().normalize();
			System.out.println("root tag : " + documentInfo.getDocumentElement().getNodeName());
			NodeList nList = documentInfo.getElementsByTagName("item");
			System.out.println("파싱할 tag수 : " + nList.getLength());
			List<Trademark> trademarks = new ArrayList<>();
			
			for(int temp = 0; temp < nList.getLength(); temp++) {
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE) {
					Element eElement = (Element) nNode;
					// Trademark 객체 생성 후 저장
					Trademark trademark = new Trademark();
					
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
					trademark.setTotalCount(getTagValue("totalCount", eElement));
					System.out.println(trademark);
					
					trademarks.add(trademark);
					System.out.println("indexNo : " + getTagValue("indexNo", eElement));
					System.out.println("applicationDate : " + getTagValue("applicationDate", eElement));
					
				}
			}
			// ??
			model.addAttribute("trademarks", trademarks);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "usr/home/trademarkApi2";
	}
	
	private static String getTagValue(String tag, Element eElement) {
		NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
		Node nValue = (Node) nlList.item(0);
		if(nValue == null) {
			return null;
		}
		return nValue.getNodeValue();
	}
	
}
