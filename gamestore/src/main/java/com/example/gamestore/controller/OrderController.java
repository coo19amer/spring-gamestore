package com.example.gamestore.controller;

import com.example.gamestore.model.Order;
import com.example.gamestore.model.User;
import com.example.gamestore.service.OrderService;
import com.example.gamestore.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Controller
public class OrderController {
    @Autowired
    OrderService orderService;

    @Autowired
    UserService userService;

    @PreAuthorize("hasAnyAuthority('ADMIN','MANAGER')")
    @GetMapping("/orderList")
    public String listOfOrders(Model model) {
        Iterable<Order> ordersList = orderService.getOrdersList();
        model.addAttribute("ordersList", ordersList);
        return "orderList";
    }

    @PreAuthorize("hasAnyAuthority('ADMIN','MANAGER')")
    @GetMapping("/orderList/{order}")
    public String listOfOrders(@PathVariable Order order, Model model) {
        model.addAttribute("orders", order);
        return "order";
    }

    @PreAuthorize("hasAnyAuthority('ADMIN','MANAGER')")
    @GetMapping("/orders/{user}")
    public String listOfOrders(@PathVariable User user, Model model) {
        List<Order> order = orderService.getOrders(user);
        model.addAttribute("orders", order);
        model.addAttribute("user", user);
        return "ordersUser";
    }
}
