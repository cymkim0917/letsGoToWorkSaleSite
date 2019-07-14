package com.kh.lgtwhp.admin.model.dao;

import java.util.ArrayList;

import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.lgtwhp.admin.model.vo.Client;
import com.kh.lgtwhp.admin.model.vo.Contract;
import com.kh.lgtwhp.common.model.vo.PageInfo;
import static com.kh.lgtwhp.common.SqlQuery.*;

@Repository
public class AdminDaoImpl implements AdminDao{

	@Override
	public int selectConsultingListCount(SqlSession sqlSession) {
		return sqlSession.selectOne("Admin.selectConsultingListCount");
	}

	@Override
	public ArrayList<Object> selectConsultingList(SqlSession sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
		
		return (ArrayList)sqlSession.selectList("Admin.selectConsultingList", pi, rowBounds);
	}

	@Override
	public ArrayList<Object> selectDetailCHList(SqlSession sqlSession, int no) {
		
		return (ArrayList)sqlSession.selectList("Admin.selectCHList", no);
	}

	@Override
	public int selectClientListCount(SqlSession sqlSession) {
		return sqlSession.selectOne("Admin.selectClientListCount");
	}

	@Override
	public ArrayList<Object> selectClientList(SqlSession sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
		
		return (ArrayList)sqlSession.selectList("Admin.selectClientList", pi, rowBounds);
	}

	@Override
	public ArrayList<Object> selectDetailcList(SqlSession sqlSession, int no) {
		
		return (ArrayList)sqlSession.selectList("Admin.selectDetailcList", no);
	}
	
	@Override
	public int searchConsultingListCount(SqlSession sqlSession, HashMap<String, Object> hmap) {
		
		return sqlSession.selectOne("Admin.searchConsultingListCount", hmap);
	}

	@Override
	public ArrayList<Object> searchConsultingList(SqlSession sqlSession, HashMap<String, Object> hmap, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
		
		return (ArrayList)sqlSession.selectList("Admin.searchConsultingList", hmap, rowBounds);
	}

	@Override
	public int insertClient(SqlSession sqlSession, Client client, HashMap<String, Object> file) {
		int result = -1;
		
		int result1 = sqlSession.insert("Admin.insertClient", client);
		int result2 = sqlSession.insert("Admin.insertNewCalculate", client);
		if(result1 > 0 && result2 > 0){
			return sqlSession.insert("Admin.insertContract", file);
		}else {
			return result;
		}
		
	}

	@Override
	public int updateStatus(SqlSession sqlSession, int no) {
		
		return sqlSession.update("Admin.updateStatus", no);
	}

	@Override
	public int updateContract(SqlSession sqlSession, Client client, HashMap<String, Object> file) {
		int result = -1;
		
		int result1 = sqlSession.update("Admin.updateContract", client);
		int result2 = sqlSession.insert("Admin.insertReCalculate", client);
		if(result1 > 0 && result2 > 0) {
			return sqlSession.insert("Admin.updateReContract", file);
		}else {
			return result;			
		}
	
	}

	@Override
	public Contract downloadFile(SqlSession sqlSession, int no) {
		
		return sqlSession.selectOne("Admin.downloadFile", no);
	}
	
	@Override
	public int searchClientListCount(SqlSession sqlSession, Client client) {
		
		return sqlSession.selectOne("Admin.searchClientListCount", client);
	}

	@Override
	public ArrayList<Object> searchClientList(SqlSession sqlSession, Client client, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
		
		return (ArrayList)sqlSession.selectList("Admin.searchClientList", client, rowBounds);
	}

	@Override
	public int selectCalculateListCount(SqlSession sqlSession) {
		return sqlSession.selectOne("Admin.selectCalculateListCount");
	}

	@Override
	public ArrayList<Object> selectCalculateList(SqlSession sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
		
		return (ArrayList)sqlSession.selectList("Admin.selectCalculateList", pi, rowBounds);
	}

	@Override
	public int okCalculate(SqlSession sqlSession, int[] no) {
		int result = 0;
		
		for(int i = 0; i < no.length; i++) {
			result += sqlSession.update("Admin.okCalculate", no[i]);
		}
		
		if(result == no.length) {
			return 1;
		}else {
			return 0;			
		}
		
	}

	@Override
	public int searchCalculateListCount(SqlSession sqlSession, HashMap<String, Object> condition) {
		
		return sqlSession.selectOne("Admin.searchCalculateListCount", condition);
	}

	@Override
	public ArrayList<Object> searchCalculateList(SqlSession sqlSession, HashMap<String, Object> condition,
			PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
		
		return (ArrayList)sqlSession.selectList("Admin.searchCalculateList", condition, rowBounds);
	}

	@Override
	public HashMap<String, ArrayList<Object>> selectChartList(SqlSession sqlSession, String date) {
		HashMap<String, ArrayList<Object>> hmap = new HashMap<String, ArrayList<Object>>();
		
		
		ArrayList<Object> money = (ArrayList)sqlSession.selectList("Admin.selectMoney", date);
		System.out.println(money);
		ArrayList<Object> consulting = (ArrayList)sqlSession.selectList("Admin.selectConsulting", date);
		System.out.println(consulting);
		ArrayList<Object> client = (ArrayList)sqlSession.selectList("Admin.selectClient", date);
		System.out.println(client);
		
		hmap.put("money", money);
		hmap.put("consulting", consulting);
		hmap.put("client", client);
		
		return hmap;
	}

	@Override
	public HashMap<String, Object> selectMainCount(SqlSession sqlSession) {
		
		HashMap<String, Object> count = new HashMap<String, Object>();
		
		ArrayList<Object> consulting = (ArrayList)sqlSession.selectList("Admin.selectMainConsulting");
		System.out.println(consulting);
		ArrayList<Object> client = (ArrayList)sqlSession.selectList("Admin.selectMainClient");
		System.out.println(client);
		int calculate = sqlSession.selectOne("Admin.selectMainCalculate");
		System.out.println(calculate);
		
		count.put("consulting", consulting);
		count.put("client", client);
		count.put("calculate", calculate);
		
		return count;
	}

	@Override
	public int insertCH(SqlSession sqlSession, HashMap<String, Object> hmap) {
		
		return sqlSession.insert("Admin.insertCH", hmap);
	}

	@Override
	public int insertCR(SqlSession sqlSession, HashMap<String, Object> hmap) {
		
		return sqlSession.insert("Admin.insertCr", hmap);
	}

	
}


















