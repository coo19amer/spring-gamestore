package com.example.gamestore.repository;

import com.example.gamestore.model.Order;
import com.example.gamestore.model.User;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface OrderRepository extends CrudRepository<Order, Long> {
    List<Order> findAllByUser(User user);
}
