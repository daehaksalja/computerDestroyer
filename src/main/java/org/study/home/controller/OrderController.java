package org.study.home.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.study.home.model.OrderPageDTO;
import org.study.home.service.MemberService;
import org.study.home.service.OrderService;

@Controller
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private MemberService memberService;
		
	@GetMapping("/order/{user_id}")
	public String orderPgaeGET(@PathVariable("user_id") String user_id, OrderPageDTO opd, Model model) {
		
		model.addAttribute("orderList", orderService.getGoodsInfo(opd.getOrders()));
		model.addAttribute("memberInfo", memberService.getMemberInfo(user_id));
		
		return "/order";
		
	}
	
	
}
