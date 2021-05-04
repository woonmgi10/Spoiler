package org.spoiler.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.spoiler.board.free.domain.Criteria;
import org.spoiler.board.free.domain.FreeVO;
import org.spoiler.board.free.mapper.FreeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class MapperTests {

	@Setter(onMethod_ = @Autowired )
	private FreeMapper mapper;
	
	@Test
	public void mapperTest() {
		mapper.getList().forEach(board -> log.info(board));
	}
	
	@Test
	public void testInsert() {
		
		FreeVO free = new FreeVO();
		free.setTitle("새로작성");
		free.setContent("중간작성");
		free.setWriter("남웅지");
		free.setCheckBox(true);
		
		mapper.insert(free);
		
		log.info(free);
		
	}
	
	@Test
	public void testRead() {
		FreeVO free = mapper.read(2L);
		log.info(free);
	}
	
	@Test
	public void testDelete() {
		log.info("delete count: " + mapper.delete(1L));
	}
	
	@Test
	public void testUpdate() {
		log.info("------------------------------");
		FreeVO free = new FreeVO();
		free.setBno(3L);
		free.setTitle("ddd");
		free.setContent("ddd");
		free.setWriter("dd");
		
		int count = mapper.update(free);
		log.info("update count:" + count);
	}
	
	@Test
	public void testPaging() {
		Criteria cri = new Criteria();
		
		cri.setPageNum(1);
		cri.setAmount(10);
		
		List<FreeVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(free -> log.info(free));
	}
	
	@Test
	public void testSearch() {
		
		Criteria cri = new Criteria();
		cri.setKeyword("새로");
		//cri.setType("tc");
		
		List<FreeVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(free -> log.info(free));
	}
	
	
}
