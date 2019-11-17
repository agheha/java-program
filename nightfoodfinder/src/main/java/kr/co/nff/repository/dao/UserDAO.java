package kr.co.nff.repository.dao;

import java.util.List;

import kr.co.nff.repository.vo.User;

public interface UserDAO {

	List<User> selectUser();
	User selectOneUser(int no);
	void deleteUser(int no);
}