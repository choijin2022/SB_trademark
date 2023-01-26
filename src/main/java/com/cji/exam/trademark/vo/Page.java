package com.cji.exam.trademark.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Page {
	int page;
	int itemsTotalCount;
	int itemsInAPage;
	int pagesCount;
	
	
}
