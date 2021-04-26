package org.spoiler.board.free.mapper;

import java.util.List;

import org.spoiler.board.free.domain.FreeAttachVO;

public interface FreeAttachMapper {

	public void insert(FreeAttachVO vo);
	public void delete(String uuid);
	public List<FreeAttachVO> findByBno(Long bno);
	public void deleteAll(Long bno);
	
	public List<FreeAttachVO> getOldFiles();
	
}
