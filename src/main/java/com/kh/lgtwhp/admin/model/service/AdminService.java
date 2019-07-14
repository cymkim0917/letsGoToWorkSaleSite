package com.kh.lgtwhp.admin.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.lgtwhp.admin.model.vo.Client;
import com.kh.lgtwhp.admin.model.vo.Contract;
import com.kh.lgtwhp.common.model.vo.PageInfo;

public interface AdminService {

	int selectConsultingListCount();

	ArrayList<Object> selectConsultingList(PageInfo pi);

	ArrayList<Object> selectDetailCHList(int no);

	int selectClientListCount();

	ArrayList<Object> selectClientList(PageInfo pi);

	ArrayList<Object> selectDetailcList(int no);

	int searchConsultingListCount(HashMap<String, Object> hmap);

	ArrayList<Object> searchConsultingList(HashMap<String, Object> hmap, PageInfo pi);

	int insertClient(Client client, HashMap<String, Object> file);

	int updateStatus(int no);

	int updateContract(Client client, HashMap<String, Object> file);

	Contract downloadFile(int no);

	ArrayList<Object> searchClientList(Client client, PageInfo pi);

	int searchClientListCount(Client client);

	int selectCalculateListCount();

	ArrayList<Object> selectCalculateList(PageInfo pi);

	int okCalculate(int[] no);

	int searchCalculateListCount(HashMap<String, Object> condition);

	ArrayList<Object> searchCalculateL1ist(HashMap<String, Object> condition, PageInfo pi);

	HashMap<String, ArrayList<Object>> selectChartList(String date);

	HashMap<String, Object> selectMainCount();

	int insertCH(HashMap<String, Object> hmap);

	int insertCR(HashMap<String, Object> hmap);

}
