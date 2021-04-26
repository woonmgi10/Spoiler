package org.spoiler.board.free.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class ReplyPageDTO {

	private Integer replyCnt;
	private List<FreeReplyVO> list;
}
