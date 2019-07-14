package com.kh.lgtwhp.admin.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import com.kh.lgtwhp.admin.model.vo.Client;
import com.kh.lgtwhp.admin.model.vo.Contract;
import com.kh.lgtwhp.common.model.vo.PageInfo;

public interface AdminDao {

	int selectConsultingListCount(SqlSession sqlSession);

	ArrayList<Object> selectConsultingList(SqlSession sqlSession, PageInfo pi);

	ArrayList<Object> selectDetailCHList(SqlSession sqlSession, int no);

	int selectClientListCount(SqlSession sqlSession);

	ArrayList<Object> selectClientList(SqlSession sqlSession, PageInfo pi);

	ArrayList<Object> selectDetailcList(SqlSession sqlSession, int no);

	int searchConsultingListCount(SqlSession sqlSession, HashMap<String, Object> hmap);

	ArrayList<Object> searchConsultingList(SqlSession sqlSession, HashMap<String, Object> hmap, PageInfo pi);

	int insertClient(SqlSession sqlSession, Client client, HashMap<String, Object> file);

	int updateStatus(SqlSession sqlSession, int no);

	int updateContract(SqlSession sqlSession, Client client, HashMap<String, Object> file);

	Contract downloadFile(SqlSession sqlSession, int no);

	ArrayList<Object> searchClientList(SqlSession sqlSession, Client client, PageInfo pi);

	int searchClientListCount(SqlSession sqlSession, Client client);

	int selectCalculateListCount(SqlSession sqlSession);

	ArrayList<Object> selectCalculateList(SqlSession sqlSession, PageInfo pi);

	int okCalculate(SqlSession sqlSession, int[] no);

	int searchCalculateListCount(SqlSession sqlSession, HashMap<String, Object> condition);

	ArrayList<Object> searchCalculateList(SqlSession sqlSession, HashMap<String, Object> condition, PageInfo pi);

	HashMap<String, ArrayList<Object>> selectChartList(SqlSession sqlSession, String date);

	HashMap<String, Object> selectMainCount(SqlSession sqlSession);

	int insertCH(SqlSession sqlSession, HashMap<String, Object> hmap);

	int insertCR(SqlSession sqlSession, HashMap<String, Object> hmap);

}
