package com.mypro.biz.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mypro.biz.UserBiz;
import com.mypro.dao.UserDao;
import com.mypro.domain.User;
@SuppressWarnings("serial")
@Service
public class UserBizImpl implements UserBiz{

	private final
    UserDao userDao;

    @Autowired
    public UserBizImpl(UserDao userDao) {
        this.userDao = userDao;
    }

    public User findById(Integer Id) {
		return userDao.findById(Id);
	}

	public User findByUserId(Integer UserId) {
		return userDao.findByUserId(UserId);
	}

	public List<User> findAll() {
		return userDao.findAll();
	}
}
