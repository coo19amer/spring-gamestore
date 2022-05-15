package com.example.gamestore.model;

import org.springframework.stereotype.Component;

@Component
public class CartLine {
    private Game game;
    Integer quantity;

    public Game getGame() {
        return game;
    }

    public void setGame(Game game) {
        this.game = game;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }
}
