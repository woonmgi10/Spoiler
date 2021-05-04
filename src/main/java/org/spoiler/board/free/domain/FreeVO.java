package org.spoiler.board.free.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FreeVO {

	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regDate;
	private Date updateDate;	
	private Integer replyCnt;
	private Integer viewCnt;
	private boolean checkBox;
	
	private List<FreeAttachVO> attachList;
}
