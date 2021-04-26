package org.spoiler.service;

import static org.junit.Assert.assertNotNull;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.spoiler.board.free.domain.Criteria;
import org.spoiler.board.free.domain.FreeVO;
import org.spoiler.board.free.service.FreeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class FreeServiceTests {

	@Autowired
	private FreeService service;
	
	@Test
	public void testService() {
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	public void testRegister() {
		FreeVO free = new FreeVO();
		free.setTitle("새글");
		free.setContent("새내용");
		free.setWriter("뉴비");
		
		service.register(free);
		
		log.info("생성된 게시물의 번호: " + free.getBno());
	}
	
	@Test
	public void testGetList() {
		service.getList(new Criteria(2,10)).forEach(free -> log.info(free));
	}
	
	@Test
	public void testGet() {
		log.info(service.get(2L));
	}
	
	@Test
	public void testDelete() {
		log.info(service.remove(2L));
	}
	@Test
	public void testUpdate() {
		FreeVO free = service.get(3L);
		
		if (free == null) {
			return;
		}
		free.setTitle("수정");
		log.info(service.modify(free));
	}
}
