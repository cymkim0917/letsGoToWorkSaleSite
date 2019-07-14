package com.kh.lgtwhp.admin.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.lgtwhp.admin.model.dao.AdminDao;
import com.kh.lgtwhp.admin.model.vo.Client;
import com.kh.lgtwhp.admin.model.vo.Contract;
import com.kh.lgtwhp.common.model.vo.PageInfo;

@Service
public class AdminServiceImpl implements AdminService{
	@Autowired
	private AdminDao aDao;
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int selectConsultingListCount() {
		return aDao.selectConsultingListCount(sqlSession);
	}

	@Override
	public ArrayList<Object> selectConsultingList(PageInfo pi) {
		return aDao.selectConsultingList(sqlSession, pi);
	}

	@Override
	public ArrayList<Object> selectDetailCHList(int no) {
		return aDao.selectDetailCHList(sqlSession, no);
	}

	@Override
	public int selectClientListCount() {
		return aDao.selectClientListCount(sqlSession);
	}

	@Override
	public ArrayList<Object> selectClientList(PageInfo pi) {
		return aDao.selectClientList(sqlSession, pi);
	}

	@Override
	public ArrayList<Object> selectDetailcList(int no) {
		return aDao.selectDetailcList(sqlSession, no);
	}

	@Override
	public int searchConsultingListCount(HashMap<String, Object> hmap) {
		return aDao.searchConsultingListCount(sqlSession, hmap);
	}

	@Override
	public ArrayList<Object> searchConsultingList(HashMap<String, Object> hmap, PageInfo pi) {
		return aDao.searchConsultingList(sqlSession, hmap, pi);
	}

	@Override
	public int insertClient(Client client, HashMap<String, Object> file) {
		return aDao.insertClient(sqlSession, client, file);
	}

	@Override
	public int updateStatus(int no) {
		return aDao.updateStatus(sqlSession, no);
	}

	@Override
	public int updateContract(Client client, HashMap<String, Object> file) {
		return aDao.updateContract(sqlSession, client, file);
	}

	@Override
	public Contract downloadFile(int no) {
		return aDao.downloadFile(sqlSession, no);
	}

	@Override
	public ArrayList<Object> searchClientList(Client client, PageInfo pi) {
		return aDao.searchClientList(sqlSession, client, pi);
	}

	@Override
	public int searchClientListCount(Client client) {
		return aDao.searchClientListCount(sqlSession, client);
	}

	@Override
	public int selectCalculateListCount() {
		return aDao.selectCalculateListCount(sqlSession);
	}

	@Override
	public ArrayList<Object> selectCalculateList(PageInfo pi) {
		return aDao.selectCalculateList(sqlSession, pi);
	}

	@Override
	public int okCalculate(int[] no) {
		return aDao.okCalculate(sqlSession, no);
	}

	@Override
	public int searchCalculateListCount(HashMap<String, Object> condition) {
		return aDao.searchCalculateListCount(sqlSession, condition);
	}

	@Override
	public ArrayList<Object> searchCalculateL1ist(HashMap<String, Object> condition, PageInfo pi) {
		return aDao.searchCalculateList(sqlSession, condition, pi);
	}

	@Override
	public HashMap<String, ArrayList<Object>> selectChartList(String date) {
		return aDao.selectChartList(sqlSession, date);
	}

	@Override
	public HashMap<String, Object> selectMainCount() {
		return aDao.selectMainCount(sqlSession);
	}

	@Override
	public int insertCH(HashMap<String, Object> hmap) {
		return aDao.insertCH(sqlSession, hmap);
	}

	@Override
	public int insertCR(HashMap<String, Object> hmap) {
		return aDao.insertCR(sqlSession, hmap);
	}
}

























