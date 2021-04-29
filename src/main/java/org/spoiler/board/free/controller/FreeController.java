package org.spoiler.board.free.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.spoiler.board.free.domain.Criteria;
import org.spoiler.board.free.domain.FreeAttachVO;
import org.spoiler.board.free.domain.FreeVO;
import org.spoiler.board.free.domain.PageDTO;
import org.spoiler.board.free.service.FreeService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/free")
@AllArgsConstructor
public class FreeController {

	private FreeService service;
	
	@GetMapping("/list")
	public void list(Criteria cri,Model model) {
		log.info("list : " + cri);
		model.addAttribute("list", service.getList(cri));
		//model.addAttribute("pageMaker", new PageDTO(cri,1));
		int total = service.getTotal(cri);
		log.info("total :" + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri,total));
		
	}
	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(FreeVO free, RedirectAttributes rttr) {
		
		log.info("===========================================");
		
		log.info("register :" + free);
		
		if(free.getAttachList() != null) {
			free.getAttachList().forEach(attach -> log.info(attach));
		}
		
		log.info("===========================================");	
		
		service.register(free);

		rttr.addFlashAttribute("result", free.getBno());
		
		return "redirect:/free/list";
	}
	
	@GetMapping({"/get","modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model){
		
		log.info("/get or modify");
		model.addAttribute("free",service.get(bno));
	}
	
	@PreAuthorize("principal.username == #free.writer")
	@PostMapping("/modify")
	public String modify(FreeVO free,@ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("modify: " + free);
		
		if (service.modify(free)) {
			rttr.addFlashAttribute("result", "success");
		}
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/free/list" + cri.getListLink();
	}
	
	@PreAuthorize("principal.username == #writer")
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno,@ModelAttribute("cri") Criteria cri,
						RedirectAttributes rttr, String writer) {
		log.info("remove" + bno);
		
		List<FreeAttachVO> attachList = service.getAttachList(bno);
		
		if (service.remove(bno)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/free/list" + cri.getListLink();
	}
	
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register() {
		
	}
	
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<FreeAttachVO>> getAttachList(Long bno) {
		log.info("getAttachList: " +bno);
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}
	
	private void deleteFiles(List<FreeAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		log.info("delete attach files...");
		log.info(attachList);
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
				Files.deleteIfExists(file);
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_"+attach.getUuid()+"_"+attach.getFileName());
					Files.delete(thumbNail);
				}
			}catch(Exception e) {
				log.error("delete file error" +e.getMessage());
			}
		});
	}
}
