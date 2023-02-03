package com.cji.exam.trademark.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cji.exam.trademark.repository.StoredTrademarkRepository;
import com.cji.exam.trademark.vo.Trademark;



@Service
public class StoredTrademarkService {

	private StoredTrademarkRepository storedTrademarkRepository;
	
	@Autowired
	StoredTrademarkService(StoredTrademarkRepository storedTrademarkRepository){
		this.storedTrademarkRepository = storedTrademarkRepository;
	}
	
	public void storedTrademark(Trademark td) {
//		Trademark trademark = new Trademark();
		System.out.println("service ?????");
		storedTrademarkRepository.storedTrademark(td);
		
	}

}
