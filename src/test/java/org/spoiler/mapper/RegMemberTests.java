package org.spoiler.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.spoiler.board.free.domain.RegMemberVO;
import org.spoiler.board.free.mapper.RegMemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class RegMemberTests {

	//RegMemberMapper 인터페이스 의존성 주입
	@Autowired
	private RegMemberMapper memberMapper;
	
	@Test
	public void regMemberMapperTests() {
		RegMemberVO member = new RegMemberVO();
		//아이디는 계속 바꾸어줘야함 primaray key라서 
		member.setMemberId("아이디값");
		member.setMemberPw("memberPw");
		member.setMemberName("memberName");
		member.setMemberBirth("memberBirth");
		member.setMemberMail("memberMail");
		
		log.info(member);
		
		memberMapper.regMemberJoin(member);
		
	
	}
	

}
