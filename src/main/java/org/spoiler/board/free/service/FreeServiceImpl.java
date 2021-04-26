package org.spoiler.board.free.service;

import java.util.List;

import org.spoiler.board.free.domain.Criteria;
import org.spoiler.board.free.domain.FreeAttachVO;
import org.spoiler.board.free.domain.FreeVO;
import org.spoiler.board.free.mapper.FreeAttachMapper;
import org.spoiler.board.free.mapper.FreeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class FreeServiceImpl implements FreeService {

	@Autowired
	private FreeMapper mapper;
	
	@Autowired
	private FreeAttachMapper attachMapper;
	
	@Transactional
	@Override
	public void register(FreeVO free) {
		log.info("register: " + free);
		mapper.insertSelectKey(free);
		
		if(free.getAttachList() == null || free.getAttachList().size() <= 0) {
			return;
		}
		free.getAttachList().forEach(attach ->{
			attach.setBno(free.getBno());
			attachMapper.insert(attach);
		});
	
	}

	@Override
	public FreeVO get(Long bno) {
		log.info("get" + bno);
		return mapper.read(bno);
	}

	@Transactional
	@Override
	public boolean modify(FreeVO free) {
		log.info("modify"+free);
		attachMapper.deleteAll(free.getBno());
		boolean modifyResult = mapper.update(free) == 1;
		
		if(modifyResult && free.getAttachList() != null && free.getAttachList().size() > 0) {
			free.getAttachList().forEach(attach -> {
				attach.setBno(free.getBno());
				attachMapper.insert(attach);
			});
		}
		
		return modifyResult;
	}

	@Transactional
	@Override
	public boolean remove(Long bno) {
		log.info("remove" + bno);
		attachMapper.deleteAll(bno);
		return mapper.delete(bno) == 1;
	}

	@Override
	public List<FreeVO> getList(Criteria cri) {
		log.info("getList");
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<FreeAttachVO> getAttachList(Long bno) {
		log.info("get attach list by bno" + bno);
		return attachMapper.findByBno(bno);
	}

}
