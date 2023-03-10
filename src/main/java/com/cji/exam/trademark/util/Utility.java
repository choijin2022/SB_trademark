package com.cji.exam.trademark.util;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Iterator;
import java.util.Map;

public class Utility {
	
	public static String f(String format, Object... args) {
		return String.format(format, args);
	}
	
	public static String jsHistoryBack(String msg) {
		
		if(msg == null) {
			msg = "";
		}
		
		return Utility.f("""
						<script>
							const msg = '%s'.trim();
							if(msg.length > 0){
								alert(msg);
							}
							history.back();
						</script>
						""", msg);
	}
	
	public static String jsReplace(String msg, String uri) {
		if(msg == null) {
			msg = "";
		}
		
		if(uri == null) {
			uri = "";
		}
		
		return Utility.f("""
						<script>
							const msg = '%s'.trim();
							if(msg.length > 0){
								alert(msg);
							}
							location.replace('%s');
						</script>
						""", msg, uri);
	}
	
	
	
	//미사용
	public static Object convertMapToObject(Map map, Object objClass){
		String keyAttribute = null;
		String setMethodString = "set";
		String methodString = null;
		Iterator itr = map.keySet().iterator();
		while(itr.hasNext()){
			keyAttribute = (String) itr.next();
			methodString = setMethodString+keyAttribute.substring(0,1).toUpperCase()+keyAttribute.substring(1);
			try {
				Method[] methods = objClass.getClass().getDeclaredMethods();
				for(int i=0;i<=methods.length-1;i++){
					if(methodString.equals(methods[i].getName())){
						System.out.println("invoke : "+methodString);
						methods[i].invoke(objClass, map.get(keyAttribute));
					}
				}
			} catch (SecurityException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
		}
		return objClass;
	}
}
