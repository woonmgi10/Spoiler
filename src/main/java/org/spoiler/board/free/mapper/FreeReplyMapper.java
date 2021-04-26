package org.spoiler.board.free.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.spoiler.board.free.domain.Criteria;
import org.spoiler.board.free.domain.FreeReplyVO;

public interface FreeReplyMapper {

	public Integer insert(FreeReplyVO vo);
	
	public FreeReplyVO read(Long bno);
	
	public Integer delete(Long rno);
	
	public Integer update(FreeReplyVO reply);
	
	public List<FreeReplyVO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("bno") Long bno);
	
	public Integer getCountBno(Long bno);
}
