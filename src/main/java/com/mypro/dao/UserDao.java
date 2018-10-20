package com.mypro.dao;

import java.util.List;

import com.mypro.domain.User;

public interface UserDao {
	User findById(Integer Id);
	User findByUserId(Integer userId);
	List<User> findAll();
}
