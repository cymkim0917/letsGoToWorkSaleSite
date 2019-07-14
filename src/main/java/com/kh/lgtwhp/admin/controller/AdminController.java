package com.kh.lgtwhp.admin.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kh.lgtwhp.admin.model.service.AdminService;
import com.kh.lgtwhp.admin.model.vo.Client;
import com.kh.lgtwhp.admin.model.vo.Contract;
import com.kh.lgtwhp.common.CommonUtils;
import com.kh.lgtwhp.common.Pagination;
import com.kh.lgtwhp.common.model.vo.PageInfo;

@Controller
public class AdminController {
	@Autowired
	private AdminService as;     
	
	@RequestMapping("adminLogin.ad")
	public String changeLoginForm() {
		return "admin/adminLogin";
	}
	
	//메인페이지 이동용
	@RequestMapping("admin.ad")
	public String changeAdminForm() {
		return "admin/adminMain";
	}
	
	//메인페이지 자료 뿌림용
	@GetMapping(value="selectMainList/ad")
	public @ResponseBody ResponseEntity<HashMap<String, Object>> selectMainList(){
		HashMap<String, Object> count = as.selectMainCount();
		
		return new ResponseEntity<HashMap<String, Object>>(count, HttpStatus.OK);
	}
	
	//상담관리 페이지 이동용
	@RequestMapping("consulting.ad")
	public String changeConsultingForm(HttpServletRequest request, Model model) {
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		int listCount = as.selectConsultingListCount();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Object> list = as.selectConsultingList(pi);
		
		
		System.out.println(list);
		
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "admin/consultingPage";
	}
	
	//상담내역 상세보기용
	@GetMapping(value="selectDetailCHList/ad/{no}")
	public @ResponseBody ResponseEntity<ArrayList<Object>> selectDetailCHList(@PathVariable("no") int no){
		System.out.println("컨트롤러 진입  : " + no);
		ArrayList<Object> chList = as.selectDetailCHList(no);
		
		return new ResponseEntity<ArrayList<Object>>(chList, HttpStatus.OK);
	}
	
	@RequestMapping("insertCH.ad")
	public String insertCH(@RequestParam String date, @RequestParam String content, @RequestParam int no) {
		System.out.println("컨트롤러 진입 : " + date + " / " + content);
		
		HashMap<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("date", date);
		hmap.put("content", content);
		hmap.put("no", no);
		
		int result = as.insertCH(hmap);
		
		if(result > 0) {
			return "redirect:consulting.ad";			
		}else {
			return "main/main";
		}
	}
	
	//상담내역 조건검색용
	@GetMapping(value="searchConsulting/ad/{start}/{end}")
	public @ResponseBody ResponseEntity<HashMap<String, Object>> searchConsulting(@PathVariable("start") String start,
																			@PathVariable("end") String end,
																			HttpServletRequest request){
		HashMap<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("start", start);
		hmap.put("end", end);
		
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		int listCount = as.searchConsultingListCount(hmap);
		System.out.println(listCount);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Object> searchList = as.searchConsultingList(hmap, pi);
		System.out.println(searchList);
		HashMap<String, Object> ajaxList = new HashMap<String, Object>();
		
		ajaxList.put("pi", pi);
		ajaxList.put("list", searchList);
		
		return new ResponseEntity<HashMap<String, Object>>(ajaxList, HttpStatus.OK);
	}
	
	
	
	//거래처관리 이동용
	@RequestMapping("client.ad")
	public String changeClientForm(HttpServletRequest request, Model model) {
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		int listCount = as.selectClientListCount();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Object> list = as.selectClientList(pi);
		
		
		System.out.println(list);
		
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "admin/clientPage";
	}
	
	//거래처 추가용
	@RequestMapping(value="insertClient.ad")
	public String insertClient(Client client, HttpServletRequest request, 
							@RequestParam(name="contract", required=false) MultipartFile contract) {
		
		String root = request.getSession().getServletContext().getRealPath("resources");
		String filePath = root + "\\uploadFiles";
		
		String originFileName = contract.getOriginalFilename();
		String ext = originFileName.substring(originFileName.lastIndexOf("."));
		String changeName = CommonUtils.getRandomString() + ext;
		HashMap<String, Object> file = new HashMap<String, Object>();
		file.put("originName", originFileName);
		file.put("filePath", filePath);
		file.put("changeName", changeName);
		
		int result = as.insertClient(client, file);
		
		if(result > 0) {
			try {
				contract.transferTo(new File(filePath + "\\" + changeName));
				return "redirect:client.ad";
			} catch (IllegalStateException | IOException e) {
				new File(filePath + "\\" + changeName).delete();
				return "main/mian";
			}
		}else {
			return "main/main";
		}
		
		
	}
	
	//거래처 상세보기용
	@GetMapping(value="selectDetailcList/ad/{no}")
	public @ResponseBody ResponseEntity<ArrayList<Object>> selectDetailcList(@PathVariable("no") int no){
		System.out.println("컨트롤러 진입  : " + no);
		ArrayList<Object> chList = as.selectDetailcList(no);
		
		return new ResponseEntity<ArrayList<Object>>(chList, HttpStatus.OK);
	}
	
	//거래처 계약종료용
	@RequestMapping("updateStatus.ad")
	public String updateStatus(@RequestParam int no) {
		int result = as.updateStatus(no);
		
		if(result > 0) {
			return "redirect:client.ad";
		}else {
			return "main/main";			
		}
	}
	
	//재계약용
	@RequestMapping("updateContract.ad")
	public String updateContract(Client client, HttpServletRequest request, 
			@RequestParam(name="contract", required=false) MultipartFile contract) {
		System.out.println(client);
		System.out.println(contract);
		
		String root = request.getSession().getServletContext().getRealPath("resources");
		String filePath = root + "\\uploadFiles";
		
		String originFileName = contract.getOriginalFilename();
		String ext = originFileName.substring(originFileName.lastIndexOf("."));
		String changeName = CommonUtils.getRandomString() + ext;
		HashMap<String, Object> file = new HashMap<String, Object>();
		file.put("originName", originFileName);
		file.put("filePath", filePath);
		file.put("changeName", changeName);
		file.put("clientNo", client.getClientNo());
		int result = as.updateContract(client, file);
		
		if(result > 0) {
			try {
				contract.transferTo(new File(filePath + "\\" + changeName));
				return "redirect:client.ad";
			} catch (IllegalStateException | IOException e) {
				new File(filePath + "\\" + changeName).delete();
				return "main/mian";
			}
		}else {
			return "main/main";
		}
		
	}
	
	//계약서 다운로드용
	@RequestMapping("downloadFile.ad")
	public void downloadFile(@RequestParam int no, HttpServletRequest request, HttpServletResponse response) {
		System.out.println("으어어어");
		Contract file = as.downloadFile(no);
		
		//폴더에서 파일을 읽어들일 스트림 생성
		BufferedInputStream buf = null;
		
		//클라이언트로 내보낼 출력스트림 생성
		ServletOutputStream downOut = null;
		try {
			downOut = response.getOutputStream();
			
			File downFile = new File(file.getFilePath() + "/" + file.getChangeName());
			
			response.setContentType("text/plain; charset=UTF-8");
			
			//한글 파일명에 대한 인코딩 처리
			//강제적으로 다운로드 처리
			response.setHeader("Content-Disposition", "contract; filename=\"" + 
				      new String(file.getOriginName().getBytes("UTF-8"), "ISO-8859-1") + "\""); 
			
			response.setContentLength((int)downFile.length());
			
			FileInputStream fin = new FileInputStream(downFile);
			
			buf = new BufferedInputStream(fin);
			
			int readBytes = 0;
			
			while((readBytes = buf.read()) != -1) {
				downOut.write(readBytes);
			}
			
			downOut.close();
			buf.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//거래처 조건 검색용
	@GetMapping(value="searchClient/ad/{option}")
	public @ResponseBody ResponseEntity<HashMap<String, Object>> searchClientList(@PathVariable("option") String option, HttpServletRequest request){
		Client client = new Client();
		client.setStatus(option);
		
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		int listCount = as.searchClientListCount(client);
		System.out.println(listCount);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Object> list = as.searchClientList(client, pi);
		
		HashMap<String, Object> cList = new HashMap<String, Object>();
		cList.put("pi", pi);
		cList.put("list", list);
		
		return new ResponseEntity<HashMap<String, Object>>(cList, HttpStatus.OK);
	}
	
	//정산 페이지 이동용
	@RequestMapping("calculate.ad")
	public String changeCalculateForm(HttpServletRequest request, Model model) {
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		int listCount = as.selectCalculateListCount();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Object> list = as.selectCalculateList(pi);
		
		
		System.out.println(list);
		
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi); 
		
		
		return "admin/calculatePage";
	}
	
	//정산 일괄 처리용
	@RequestMapping("okCalculate.ad")
	public String okCalculate(@RequestParam int[] no) {
		System.out.println(no);
		
		int result = as.okCalculate(no);
		
		if(result > 0) {
			return "redirect:calculate.ad";			
		}else {
			return "main/main";
		}
	}
	
	//정산 조건조회용
	@GetMapping(value="searchCalculate/ad/{startD}/{endD}/{option}")
	public @ResponseBody ResponseEntity<HashMap<String, Object>> searchCalculateList(@PathVariable("option") String option, @PathVariable("startD") String startD,
																					@PathVariable("endD") String endD, HttpServletRequest request){
		
		HashMap<String, Object> condition = new HashMap<String, Object>();
		condition.put("startD", startD);
		condition.put("endD", endD);
		condition.put("option", option);
		
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		int listCount = as.searchCalculateListCount(condition);
		System.out.println(listCount);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Object> list = as.searchCalculateL1ist(condition, pi);
		
		HashMap<String, Object> cList = new HashMap<String, Object>();
		cList.put("pi", pi);
		cList.put("list", list);
		
		return new ResponseEntity<HashMap<String, Object>>(cList, HttpStatus.OK);
	}
	
	//통계 페이지 이동용
	@RequestMapping("statistics.ad")
	public String changeStatisticsForm() {
		return "admin/statisticsPage";
	}
	
	//통계 defalut값 조회용
	@GetMapping(value="selectChartList/ad/{date}")
	public @ResponseBody ResponseEntity<HashMap<String, ArrayList<Object>>> selectChartList(@PathVariable("date") String date){
		System.out.println(date);
		
		HashMap<String, ArrayList<Object>> hmap= as.selectChartList(date);
		
		return new ResponseEntity<HashMap<String, ArrayList<Object>>>(hmap, HttpStatus.OK);
	}
	
	//상담 신청용
	@GetMapping(value="insertCR/ad/{cName}/{mName}/{email}/{phone}/{cHome}/{message}")
	public @ResponseBody ResponseEntity<Object> insertCH(@PathVariable("cName") String cName, @PathVariable("mName") String mName, @PathVariable("email") String email
														,@PathVariable("phone") String phone, @PathVariable("cHome") String cHome, @PathVariable("message") String message){
		HashMap<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("cName", cName);
		hmap.put("mName", mName);
		hmap.put("email", email);
		hmap.put("phone", phone);
		hmap.put("cHome", cHome);
		hmap.put("message", message);
		
		int result = as.insertCR(hmap);
		
		return new ResponseEntity<Object>(result, HttpStatus.OK);
	}
	
	
}




































