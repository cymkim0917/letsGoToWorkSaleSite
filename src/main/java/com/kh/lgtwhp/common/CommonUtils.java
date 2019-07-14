package com.kh.lgtwhp.common;

import java.util.UUID;

public class CommonUtils {
	public static String getRandomString() {
		
		//32비트 사이즈의 랜덤한 문자열을 생성해주는 메소드
		return UUID.randomUUID().toString().replaceAll("-",	"");
	}
}
