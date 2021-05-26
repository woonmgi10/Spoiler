package org.spoiler.board.free.service;

import org.spoiler.board.free.domain.RegMemberVO;
import org.spoiler.board.free.mapper.RegMemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RegMemberServiceImpl implements RegMemberService {

	@Autowired
	RegMemberMapper regMemberMapper;

	@Override
	public void regMemberJoin(RegMemberVO member) throws Exception {
		
		regMemberMapper.regMemberJoin(member);
		
	}
	
	
	
	
}
