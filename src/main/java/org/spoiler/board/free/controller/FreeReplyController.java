package org.spoiler.board.free.controller;

import org.spoiler.board.free.domain.Criteria;
import org.spoiler.board.free.domain.FreeReplyVO;
import org.spoiler.board.free.domain.ReplyPageDTO;
import org.spoiler.board.free.service.FreeReplyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@RestController
@Log4j
@AllArgsConstructor
public class FreeReplyController {

	private FreeReplyService service;
	
	//@PreAuthorize("isAuthenticated()")
	@PostMapping(value="/new", consumes="application/json",
			produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody FreeReplyVO vo) {
		log.info("FreeReplyVO: " + vo);
		Integer insertCount = service.register(vo);
		log.info("Reply insert count: " + insertCount);
		
		return insertCount == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/pages/{bno}/{page}",
			produces= {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(
			@PathVariable("page") int page,
			@PathVariable("bno") Long bno) {
		Criteria cri = new Criteria(page,10);
		log.info(bno);
		log.info(cri);
		
		return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);
	}
	
	@GetMapping(value="/{rno}",
			produces= {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<FreeReplyVO> get(@PathVariable("rno") Long rno) {
		log.info( + rno);
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
	@PreAuthorize("principal.username == #vo.replyer")
	@DeleteMapping("/{rno}")
	public ResponseEntity<String> remove(@RequestBody FreeReplyVO vo,  @PathVariable("rno") Long rno) {
		log.info("remove: " + rno);
		log.info("replyer: " + vo.getReplyer());
		
	return service.remove(vo.getRno()) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

	}
	
	@PreAuthorize("principal.username == #vo.replyer")
	@RequestMapping(method= {RequestMethod.PUT, RequestMethod.PATCH},
			value="/{rno}",
			consumes="application/json")
	public ResponseEntity<String> modify(
			@RequestBody FreeReplyVO vo,
			@PathVariable("rno") Long rno) {
		log.info("rno: " + rno);
		log.info("modify: " + vo);
		return service.modify(vo) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
