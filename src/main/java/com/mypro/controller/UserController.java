package com.mypro.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mypro.biz.UserBiz;
import com.mypro.domain.User;

@Controller
@RequestMapping
public class UserController {
	private final UserBiz userBiz;

    @Autowired
    public UserController(UserBiz userBiz) {
        this.userBiz = userBiz;
    }
	
	/*@RequestMapping("/findById")
	public String findById(@RequestParam int id,HttpServletRequest request) {
		
		User user = userBiz.findById(id);
		System.out.println("id=" + user.getUserName());
		request.setAttribute("user", user);
		return "info";
	}
	*/

	@RequestMapping(value = "/test", method = RequestMethod.GET)
    @ResponseBody
	public List<User> findAll() {
	    List<User> users;
	    users = userBiz.findAll();
	    return users;
	}
	
/*	@RequestMapping("/jsp/user.do")
	public String findByName(@RequestParam String userName,HttpServletRequest request) {
		List<User> users = userBiz.findByName(userName);
		request.setAttribute("users", users);
		return "userlist";
	}*/
}
