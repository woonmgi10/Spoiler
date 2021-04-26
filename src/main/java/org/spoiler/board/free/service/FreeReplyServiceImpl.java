package org.spoiler.board.free.service;

import java.util.List;

import org.spoiler.board.free.domain.Criteria;
import org.spoiler.board.free.domain.FreeReplyVO;
import org.spoiler.board.free.domain.ReplyPageDTO;
import org.spoiler.board.free.mapper.FreeMapper;
import org.spoiler.board.free.mapper.FreeReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class FreeReplyServiceImpl implements FreeReplyService {

	@Autowired
	private FreeReplyMapper mapper;

	@Autowired
	private FreeMapper freeMapper;

	@Transactional
	@Override
	public Integer register(FreeReplyVO vo) {
		log.info("register..." + vo);

		freeMapper.updateReplyCnt(vo.getBno(), 1);

		return mapper.insert(vo);
	}

	@Override
	public FreeReplyVO get(Long rno) {
		log.info("get......" + rno);
		return mapper.read(rno);
	}

	@Override
	public Integer modify(FreeReplyVO vo) {
		log.info("modify......" + vo);
		return mapper.update(vo);
	}

	@Transactional
	@Override
	public Integer remove(Long rno) {
		log.info("remove.." + rno);

		FreeReplyVO vo = mapper.read(rno);

		freeMapper.updateReplyCnt(vo.getBno(), -1);
		return mapper.delete(rno);
	}

	@Override
	public List<FreeReplyVO> getList(Criteria cri, Long bno) {
		log.info("getList......" + bno);
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {

		return new ReplyPageDTO(mapper.getCountBno(bno), mapper.getListWithPaging(cri, bno));
	}

}
