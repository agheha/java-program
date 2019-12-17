package kr.co.nff.repository.dao;

import java.util.List;

import kr.co.nff.repository.vo.Search;
import kr.co.nff.repository.vo.Stat;

public interface StatDAO {
	Stat statFrequentStore(Search search);
	
	// 방문자
	public void insertVisitor(Stat stat);
	public Stat visitorList();
	public List<Stat> countByDate();
	
	// 가입자
	public Stat countJoinUser();
	public Stat countJoinStore();
}
