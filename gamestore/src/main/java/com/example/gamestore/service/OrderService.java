package com.example.gamestore.service;

import com.example.gamestore.model.Order;
import com.example.gamestore.model.User;
import com.example.gamestore.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderService {
    @Autowired
    private OrderRepository orderRepository;

    public List<Order> getOrders(User user) {
        List<Order> allByUser = orderRepository.findAllByUser(user);
        return allByUser;
    }

    public Iterable<Order> getOrdersList(){
        Iterable<Order> orders = orderRepository.findAll();
        return orders;
    }

    public Order findOne(Long orderId) {
        return orderRepository.findById(orderId).get();
    }

    public User findUser(Long orderId) {
        Order one = findOne(orderId);
        return one.getUser();
    }
}

