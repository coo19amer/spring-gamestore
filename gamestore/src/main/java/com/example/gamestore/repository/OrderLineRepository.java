package com.example.gamestore.repository;

import com.example.gamestore.model.OrderLine;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface OrderLineRepository extends CrudRepository<OrderLine, Long> {
    List<OrderLine> findAllByGame_Id (Long id);
}
