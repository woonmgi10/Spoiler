package org.spoiler.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.spoiler.board.free.domain.Criteria;
import org.spoiler.board.free.domain.FreeReplyVO;
import org.spoiler.board.free.mapper.FreeReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class FreeReplyMapperTests {
	
	private Long[] bnoArr = { 1L, 2L, 3L, 4L, 5L };

	@Autowired
	private FreeReplyMapper mapper;
	
	@Test
	public void testFreeReplyMapper() {
		log.info(mapper);
	}
	
	@Test
	public void testCreate() {
		IntStream.range(1, 10).forEach(i -> {
			FreeReplyVO vo = new FreeReplyVO();
			
			vo.setBno(bnoArr[i % 5]);
			vo.setReply("댓글테스트" + i);
			vo.setReplyer("댓글작성자" + i);
			
			mapper.insert(vo);
		});
	}
	
	@Test
	public void testRead() {
		
		Long targetRno = 5L;
		
		FreeReplyVO vo = mapper.read(targetRno);
		
		log.info(vo);
	}
	
	@Test
	public void testDelete() {
		
		Long rno = 5L;
		
		mapper.delete(rno);
		
	}
	
	@Test
	public void testModify() {
		
		Long rno = 1L;
		
		FreeReplyVO vo = mapper.read(rno);
		
		vo.setReply("mysql");
		
		Integer count = mapper.update(vo);
		
		log.info("update count :" + count);
	}
	
	@Test
	public void testList() {
		Criteria cri = new Criteria();
		List<FreeReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
		replies.forEach(reply -> log.info(reply));
	}
	
	@Test
	public void testList2() {
		Criteria cri = new Criteria(2,10);
		//49137
		List<FreeReplyVO> replies = mapper.getListWithPaging(cri, 49137L);
		replies.forEach(reply -> log.info(reply));
	}
}
