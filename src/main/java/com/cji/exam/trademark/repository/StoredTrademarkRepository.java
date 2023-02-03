package com.cji.exam.trademark.repository;

import org.apache.ibatis.annotations.Mapper;

import com.cji.exam.trademark.vo.Trademark;

@Mapper
public interface StoredTrademarkRepository {

	public void storedTrademark(Trademark trademark);

	public int getTrademarksCount();
}
