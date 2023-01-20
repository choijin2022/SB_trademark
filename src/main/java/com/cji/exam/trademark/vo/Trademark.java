package com.cji.exam.trademark.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Trademark {
	private String id;
	private String regDate;
	private String updateDate;
	private String title;
	private String totalCount;
	
	private String indexNo;
	private String applicantName;
	private String applicationNumber;
//	private String appReferenceNumber;
	private String applicationDate;
	private String publicationNumber;
	private String publicationDate;
	private String registrationNumber;
//	private String regReferenceNumber;
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
	private String fullText;
	private String drawing;
	private String bigDrawing;
}
