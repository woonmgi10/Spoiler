package org.spoiler.board.free.service;

import java.util.List;

import org.spoiler.board.free.domain.Criteria;
import org.spoiler.board.free.domain.FreeReplyVO;
import org.spoiler.board.free.domain.ReplyPageDTO;

public interface FreeReplyService {


	public Integer register(FreeReplyVO vo);
	public FreeReplyVO get(Long rno);
	public Integer modify(FreeReplyVO vo);
	public Integer remove(Long rno);
	//public List<FreeVO> getList();
	public List<FreeReplyVO> getList(Criteria cri, Long bno);
	
	public ReplyPageDTO getListPage(Criteria cri, Long bno);
}
