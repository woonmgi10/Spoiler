package org.spoiler.board.free.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.spoiler.board.free.domain.Criteria;
import org.spoiler.board.free.domain.FreeVO;

import lombok.extern.log4j.Log4j;


public interface FreeMapper {

//	@Select("select * from spo_free where bno > 0")
	public List<FreeVO> getList();
	
	public List<FreeVO> getListWithPaging(Criteria cri);
	
	public void insert(FreeVO free);
	
	public void insertSelectKey(FreeVO free);
	
	public FreeVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(FreeVO free);
	
	public int getTotalCount(Criteria cri);
	
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") Integer amount);
	
	
}
