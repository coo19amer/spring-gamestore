package com.example.gamestore.service;

import com.example.gamestore.model.*;
import com.example.gamestore.repository.GameRepository;
import com.example.gamestore.repository.OrderLineRepository;
import com.example.gamestore.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import java.io.UnsupportedEncodingException;
import java.util.HashSet;
import java.util.Optional;
import java.util.Set;

@Service
public class CartService {
    @Autowired
    private Cart cart;

    @Autowired
    private GameRepository gameRepository;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderLineRepository orderLineRepository;

    public Order order(User user) throws MessagingException, UnsupportedEncodingException {
        Set<CartLine> cartLines = cart.getCartLineList();
        Order order = new Order();
        Set<OrderLine> orderLines = new HashSet<>();
        order.setUser(user);
        for (CartLine c : cartLines) {
            OrderLine orderLine = new OrderLine();
            orderLine.setQuantity(c.getQuantity());
            orderLine.setGame(c.getGame());
            orderLine.setPrice(c.getGame().getPrice());
            orderLine.setOrder(order);
            changeQuantity(c.getGame().getId(), c.getQuantity());
            orderLines.add(orderLine);
            order.setOrderLines(orderLines);
        }
        order.setTotalPrice(cart.getTotalPrice());
        orderRepository.save(order);
        for (OrderLine o : orderLines) {
            orderLineRepository.save(o);
        }
        cart.setTotalPrice(0);
        cart.setCartLineList(new HashSet<>());
        return order;
    }

    public boolean checkQuantity(Integer quantity, Game game, CartLine cartLine) {
        return cartLine.getQuantity() + quantity <= game.getQuantity();
    }

    public void processQuantity(Integer quantity, Game game, CartLine cartLine) {
        int quantityGame = cartLine.getQuantity() + quantity;
        cart.setTotalPrice(cart.getTotalPrice() - (cartLine.getQuantity() * game.getPrice()) + (quantityGame * game.getPrice()));
        cartLine.setQuantity(quantityGame);
    }

    public void changeQuantity(Long id, int quantity) {
        Optional<Game> gameById = gameRepository.findById(id);
        if (gameById.isPresent()) {
            Game game = gameById.get();
            game.setQuantity(game.getQuantity() - quantity);
        }
    }
}
