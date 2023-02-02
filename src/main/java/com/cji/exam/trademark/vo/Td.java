package com.cji.exam.trademark.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Td {
	private String indexNo;
	private String applicantName;
	private String applicationNumber;
	private String applicationDate;
	private String publicationNumber;
	private String publicationDate;
	private String registrationNumber;
	private String registrationDate;
	private String registrationPublicNumber;
	private String registrationPublicDate;
	private String priorityNumber;
	private String priorityDate;
	private String internationalRegisterNumber;
	private String internationalRegisterDate;
	private String applicationStatus;
	private String classificationCode;
	private String viennaCode;
	private String agentName;
	private String regPrivilegeName;
//	private String title;
	private String fullText;
	private String drawing;
	private String bigDrawing;
	
//	public Td chngeTd( List tdList) {
//		Td td = new Td();
//		for(int i=0; i<tdList.size(); i++) {
//			if(tdList.size()==0) {
//				return null;
//			}
//			td.setIndexNo(tdList[]);
//		}
//		return td;
//		
//	}
	
}
