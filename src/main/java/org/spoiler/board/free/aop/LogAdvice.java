package org.spoiler.board.free.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect
@Log4j
@Component
public class LogAdvice {

	@Before  (value = "execution(* org.spoiler..*.*Service*.doAdd(String, String)) && args(str1, str2)")
	public void logBeforeWithParam(String str1, String str2) {
		
		log.info("----------------------------");
		log.info("str1: " + str1);
		log.info("str2: " + str2);
	}
	
	@AfterThrowing(pointcut = "execution(* org.spoiler..*.*Service*.*(..))", throwing="exception")
	public void logException(Exception exception) {
		log.info("Exception!");
		log.info("exception: " +exception);
	}
	
//	@Around("execution(* org.spoiler..*.*Service*.*(..))")
	public Object logTime(ProceedingJoinPoint pjp) {
		long start = System.currentTimeMillis();
		log.info("Target: " +pjp.getTarget());
		log.info("Param: " +Arrays.toString(pjp.getArgs()));
		
		Object result = null;
		
		try {
			result = pjp.proceed();
		} catch (Throwable t) {
			t.printStackTrace();
		}
		long end = System.currentTimeMillis();
		log.info("Time: " +(end-start));
		return result;
	}
	
	
}
