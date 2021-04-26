package org.spoiler.board.free.service;

import java.util.List;

import org.spoiler.board.free.domain.Criteria;
import org.spoiler.board.free.domain.FreeAttachVO;
import org.spoiler.board.free.domain.FreeVO;

public interface FreeService {

	public void register(FreeVO free);
	public FreeVO get(Long bno);
	public boolean modify(FreeVO free);
	public boolean remove(Long bno);
	//public List<FreeVO> getList();
	public List<FreeVO> getList(Criteria cri);
	public int getTotal(Criteria cri);
	
	public List<FreeAttachVO> getAttachList(Long bno);
}
