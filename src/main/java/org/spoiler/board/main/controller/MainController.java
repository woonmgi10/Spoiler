package org.spoiler.board.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/main")
@AllArgsConstructor
public class MainController {

	@GetMapping("/mainDoor")
	public void mainDoor() {
		
		return;
	}
}
