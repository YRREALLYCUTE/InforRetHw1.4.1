package com.mypro.biz;

import java.util.List;

import com.mypro.domain.User;

public interface UserBiz {
	User findById(Integer Id);
	User findByUserId(Integer UserId);
	List<User> findAll();
}
