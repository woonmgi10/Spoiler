package org.spoiler.board.free.domain;

import lombok.Data;

@Data
public class FreeAttachVO {

	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	
	private Long bno;
}
