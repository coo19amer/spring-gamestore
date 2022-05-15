package com.example.gamestore.controller;

import com.example.gamestore.exception.UserNotFoundExecption;
import com.example.gamestore.model.*;
import com.example.gamestore.repository.GameRepository;
import com.example.gamestore.repository.UserRepository;
import com.example.gamestore.service.CartService;
import com.example.gamestore.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.mail.MessagingException;
import java.io.UnsupportedEncodingException;
import java.util.HashSet;
import java.util.Optional;
import java.util.Set;


@Controller
@RequestMapping("/cart")
public class CartController {
    @Autowired
    private CartService cartService;

    @Autowired
    private UserService userService;

    @Autowired
    private Cart cart;

    @Autowired
    private GameRepository gameRepository;

    @Autowired
    private UserRepository userRepository;

    @GetMapping
    public String cart(Model model) {
        model.addAttribute("cart", cart);
        return "cart";
    }

    @PostMapping("/addToCart")
    public String addToCart(Long id, Integer quantity, Model model) {
        Optional<Game> byId = gameRepository.findById(id);
        if (byId.isPresent()) {
            Game game = byId.get();
            CartLine cartLine = new CartLine();
            Set<CartLine> cartLines = cart.getCartLineList();

            cartLine.setGame(game);
            cartLine.setQuantity(quantity);

            for (CartLine c : cartLines) {
                if (c.getGame().getId().equals(id)) {
                    if (cartService.checkQuantity(quantity, game, c)) {
                        cartService.processQuantity(quantity, game, c);
                        return "redirect:/cart";
                    } else {
                        model.addAttribute("message", "Не хватает ключей для игры \"" + game.getName() +
                                "\". Доступное количество " + game.getQuantity());
                        return cart(model);
                    }
                }
            }
            cartLines.add(cartLine);
            cart.setTotalPrice(cart.getTotalPrice() + cartLine.getQuantity() * game.getPrice());
            cart.setCartLineList(cartLines);

        }
        return "redirect:/cart";
    }

    @PostMapping("/remove")
    public String remove(@RequestParam Long id) {
        Set<CartLine> cartLineList = cart.getCartLineList();
        for (CartLine c : cartLineList) {
            boolean isGame = c.getGame().getId().equals(id);
            if (isGame) {
                cart.setTotalPrice(cart.getTotalPrice() - c.getGame().getPrice() * c.getQuantity());
                cartLineList.remove(c);
                return "redirect:/cart";
            }
        }
        return "redirect:/cart";
    }

    @PostMapping("/editQuantity")
    public String quantityUpdate(
            @RequestParam Integer quantity,
            @RequestParam Long id,
            Model model) {
        Optional<Game> byId = gameRepository.findById(id);
        if (byId.isPresent()) {
            Game game = byId.get();
            Set<CartLine> cartLines = cart.getCartLineList();
            for (CartLine c : cartLines) {
                if (c.getGame().getId().equals(id)) {
                    if (cartService.checkQuantity(quantity - c.getQuantity(), game, c)) {
                        cartService.processQuantity(quantity - c.getQuantity(), game, c);
                        return "redirect:/cart";
                    } else {
                        model.addAttribute("message", "Не хватает ключей для игры \"" + game.getName() +
                                "\". Доступное количество " + game.getQuantity());
                        return cart(model);
                    }
                }
            }
        }
        return "redirect:/cart";
    }

    @GetMapping("/clear")
    public String clear() {
        cart.setTotalPrice(0);
        cart.setCartLineList(new HashSet<>());
        return "redirect:/cart";
    }

    @Transactional
    @PostMapping("/order")
    public String order(
            @RequestParam("userId") User user,
            @RequestParam(required = false, defaultValue = "false") Boolean save,
            Model model) throws MessagingException, UnsupportedEncodingException, UserNotFoundExecption {
            Order order = cartService.order(user);
        if (save) {
            Optional<User> userById = userRepository.findById(user.getId());
            User user1 = userById.get();
            userRepository.save(user1);
        }
        model.addAttribute("message", "Подтвердите свой заказ на почте");
        return "redirect:/cart";
    }
}
