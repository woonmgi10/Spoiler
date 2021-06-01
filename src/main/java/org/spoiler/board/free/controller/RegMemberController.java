package org.spoiler.board.free.controller;

import org.spoiler.board.free.service.RegMemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class RegMemberController {


	private RegMemberService regMemberService;
	
	@GetMapping("/registration")
	public void loginGET() {
		log.info("회원가입페이지 진입 ");
	}
}
