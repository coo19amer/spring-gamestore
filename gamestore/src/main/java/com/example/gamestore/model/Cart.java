package com.example.gamestore.model;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Component
public class Cart {
    Set<CartLine> cartLineList = new HashSet<>();

    Integer totalPrice = 0;

    public Set<CartLine> getCartLineList() {
        return cartLineList;
    }

    public void setCartLineList(Set<CartLine> cartLineList) {
        this.cartLineList = cartLineList;
    }

    public Integer getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Integer totalPrice) {
        this.totalPrice = totalPrice;
    }
}
