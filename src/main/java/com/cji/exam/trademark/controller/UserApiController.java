package com.cji.exam.trademark.controller;

import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.cji.exam.trademark.vo.Trademark;

@Controller
public class UserApiController {
//	private static final int numOfRows = 50;
			
	@RequestMapping("/usr/home/trademarkApi2")
	public String trademarkApi2() {
		return "usr/home/trademarkApi2";
	}
	
	@RequestMapping("/usr/home/searchTrademard")
	public String doSearchTrademard(Model model, int numOfRows, @RequestParam(defaultValue = "1") String searchString, @RequestParam(defaultValue = "1") int pageNo) {
		List<Trademark> trademarks = new ArrayList<>();
		String totalCount;
		
		try {
			String url = "http://kipo-api.kipi.or.kr/openapi/service/trademarkInfoSearchService/getWordSearch";
			String serviceKey = "WTh4nA6jgRy5Jxmw4vhBoRbWDJFex7P%2BNr1NnXssp1P6N6NDjsY5hEZnOLCS4NEOpS8SSkrREQp%2FqX%2BsrB42DQ%3D%3D";
//			String serviceKey = "sd2%2Fw1FPMP7dCiLT1r8GNJatfwBCKhZfFVQAA3lNV55hr4o2tNP9B0NpNBn7iAGvAN8QwKTBfli73H%2Fdq7xZBw%3D%3D";
			//
//			String searchKeywork = searchString;
			
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document documentInfo = dBuilder.parse(url + "?ServiceKey=" + serviceKey + "&numOfRows=" + numOfRows +"&searchString=" + searchString+"&pageNo=" + pageNo );
			
			documentInfo.getDocumentElement().normalize();
			System.out.println("root tag : " + documentInfo.getDocumentElement().getNodeName());
			//수정 시작
			
			
			NodeList nCoutnNode = documentInfo.getElementsByTagName("count");
			totalCount = getCountItem(nCoutnNode,"totalCount");
			int setPageNo = Integer.parseInt(getCountItem(nCoutnNode,"pageNo"));
			System.out.println("totalCount : "+totalCount);
			System.out.println("setPageNo : "+setPageNo);
			System.out.println("pageNo : " + pageNo);
			
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
					if(getTagValue("title", eElement) == null || getTagValue("title", eElement) == "") {
						trademark.setTitle("(없음)");
					}else {
						trademark.setTitle(getTagValue("title", eElement));
					}
					if(getTagValue("applicationNumber", eElement) == null || getTagValue("applicationNumber", eElement) == "") {
						trademark.setApplicationNumber(getTagValue("internationalRegisterNumber", eElement));
					}else {
						trademark.setApplicationNumber(getTagValue("applicationNumber", eElement));
					}
					if(getTagValue("applicationDate", eElement) == null || getTagValue("applicationDate", eElement) == "") {
						trademark.setApplicationDate(getTagValue("internationalRegisterDate", eElement));
					}else {
						trademark.setApplicationDate(getTagValue("applicationDate", eElement));
					}
					trademark.setSearchString(searchString);
					trademark.setTotalCount(totalCount);
					trademark.setIndexNo(getTagValue("indexNo", eElement));
					trademark.setApplicantName(getTagValue("applicantName", eElement));
					trademark.setPublicationNumber(getTagValue("publicationNumber", eElement));
					trademark.setPublicationDate(getTagValue("publicationDate", eElement));
					trademark.setRegistrationNumber(getTagValue("registrationNumber", eElement));
					trademark.setRegistrationDate(getTagValue("registrationDate", eElement));
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
					trademark.setPageNo(pageNo);
					// 페이지 정보
					int totalCnt = Integer.parseInt(totalCount);
					int pagesCount = setPage(pageNo, totalCnt, numOfRows);
					
					trademark.setItemsTotalCount(totalCnt);
					trademark.setPagesCount(pagesCount);
					trademark.setNumOfRows(numOfRows);
					System.out.println("출원번호" + trademark.getApplicationNumber());
					
					// 콤마제거
					if(trademark.getTitle() != null) {
						String title = trademark.getTitle();
						if(title.contains(",")) {
							String str = title.replace(",", "(_콤마)");
							trademark.setTitle(str);
						}
					}
					
					if(trademark.getApplicantName() != null) {
						String applicantName = trademark.getApplicantName();
						if(applicantName.contains(",")) {
							String str = removeComma(applicantName);
							trademark.setApplicantName(str);
						}
					}
					if(trademark.getRegPrivilegeName() != null) {
						String regPrivilegeName= trademark.getRegPrivilegeName();
						if(regPrivilegeName.contains(",")){
							String str = removeComma(regPrivilegeName);
							trademark.setRegPrivilegeName(str);
						}
					}
					if(trademark.getAgentName() != null) {
						String agentName= trademark.getAgentName();
						if(agentName.contains(",")) {
							String str = removeComma(agentName);
							trademark.setAgentName(str);
						}
					}

					System.out.println("출원인 이름 : " + trademark.getApplicantName());
					System.out.println("권리자 이름 : " + trademark.getRegPrivilegeName() );
					System.out.println("상표명 : "+ trademark.getTitle() );
					System.out.println("페이지번호 : "+ trademark.getPageNo() );
					System.out.println(trademark);
					// 리스트에 trademark 넣기
					trademarks.add(trademark);
					
//					model.addAttribute("trademark", trademark);
//					System.out.println("indexNo : " + getTagValue("indexNo", eElement));
//					System.out.println("applicationDate : " + getTagValue("applicationDate", eElement));
					
				}
			}
			// ??
//			model.addAttribute("numOfRows", numOfRows);
			model.addAttribute("trademarks", trademarks);
			System.out.println(trademarks);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "usr/home/searchTrademard";
	}
	
	@ResponseBody
    @RequestMapping(value = "getformjsonlist.do", method=RequestMethod.POST)
    public Trademark getSearchFormJsonList(@RequestBody Trademark td) throws Exception{
        System.out.println("???????????");
        return td;
    }

	//콤마 지우기
	private String removeComma(String str) {
		str = str.replace(",", "");
		return str;

	 
	}

	private int setPage(int page, int totalCnt, int numOfRows) {
		int pagesCount = (int) Math.ceil((double) totalCnt / numOfRows);
		return pagesCount;
	}

	private String getCountItem(NodeList nCoutnNode, String itemName) {
		String totalCount="";
		for(int temp = 0; temp < nCoutnNode.getLength(); temp++) {
			Node nCntNode = nCoutnNode.item(temp);
			if(nCntNode.getNodeType() == Node.ELEMENT_NODE) {
				Element eElement = (Element) nCntNode;
				
				totalCount = getTagValue(itemName, eElement);
				
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
	
//	private static void removeComma(Trademark td){
//		
//	
//		
//	}
}
