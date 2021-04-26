package org.spoiler.board.free.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class Criteria {

	private Integer pageNum;
	private Integer amount;
	
	private String type;
	private String keyword;
	
	public Criteria() {
		this(1,10);
	}
	
	public String getType() {
		
		if(type == null || type.trim().length() == 0) {
			return null;
		}
		return type;
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum < 0 ?1: pageNum;
		this.amount = amount;
	}
	public String[] getTypeArr() {
		
		return type == null? new String[] {}: type.split("");
	}
	
	
	public int getSkip() {
		
		return (pageNum - 1) * amount;
	}
	
	public String getListLink() {
		
		UriComponentsBuilder builder= UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
				
		return builder.toUriString();
		
	}
}
