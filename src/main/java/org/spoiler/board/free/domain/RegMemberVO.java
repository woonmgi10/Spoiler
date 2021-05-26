package org.spoiler.board.free.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class RegMemberVO {

	private String memberId;
	
	private String memberPw;
	
	private String memberName;
	
	private String memberMail;
	
	private String memberBirth;
	
	private boolean adminCk;
	
	private Date regDate;
	
}
