package org.spoiler.board.free.crawling;

import java.io.Console;
import java.io.IOException;
import java.util.Iterator;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;


public class Crawling {

	public static void main(String[] args) {
		
		//jsoup을 이용한 크롤링
		String url = "https://en.dict.naver.com/#/main";//크롤링할 url지정
	
		Document doc = null; //Document에는 페이지의 전체소스가 저장된다
		
		try {
				doc = Jsoup.connect(url).get();
				
		} catch (IOException e ) {
			
			e.printStackTrace();
		}
		
		Elements element = doc.select("ul.menu_list");
		
		System.out.println("========================================");
		
		//Iterator를 사용하여 하나씩 값 가져오기
		//덩어리 안에서 필요한 부분만 선택하여 가져올 수 있다.
		
		Iterator<Element> ie1 = element.select("a.work_link").iterator();
		
		Iterator<Element> ie2 = element.select("div.txt_trans").iterator();
		
		while (ie1.hasNext()) {
			
			System.out.println(ie1.next().text() + "\t" + ie2.next().text());
		}
		
		
		
		
		
		
		
		
		
		
	}
}
