package com.example.gamestore.controller;

import com.example.gamestore.model.Game;
import com.example.gamestore.model.OrderLine;
import com.example.gamestore.repository.GameRepository;
import com.example.gamestore.repository.OrderLineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

@Controller
public class MainController {
    @Autowired
    private GameRepository gameRepository;

    @Autowired
    private OrderLineRepository orderLineRepository;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/")
    public String index(@PageableDefault(sort = {"id"}, direction = Sort.Direction.ASC) Pageable pageable, Model model) {

        Page<Game> games = gameRepository.findAll(pageable);
        model.addAttribute("games", games);
        model.addAttribute("url", "/");

        return "index";
    }

    @GetMapping("/main")
    public String main(
            @RequestParam(required = false, defaultValue = "") String filter,
            @PageableDefault(sort = {"id"}, direction = Sort.Direction.ASC) Pageable pageable,
            Model model) {
        Page<Game> games;

        if (!filter.isEmpty()) {
            games = gameRepository.findByGenreContainsOrNameContains(filter, filter, pageable);
        } else games = gameRepository.findAll(pageable);

        model.addAttribute("games", games);
        model.addAttribute("filter", filter);
        model.addAttribute("url", "/main");

        return "main";
    }

    @PostMapping("/")
    public String edit(@RequestParam("gameId") Game game, @RequestParam Integer quantity, @RequestParam Integer price) {
        Optional<Game> byId = gameRepository.findById(game.getId());
        Game game1 = byId.get();
        game1.setQuantity(quantity);
        game1.setPrice(price);
        gameRepository.save(game1);
        return "redirect:/main";
    }

    @PostMapping("/remove")
    public String remove(@RequestParam("gameId") Game game) {
        List<OrderLine> allOrderLinesByGameId = orderLineRepository.findAllByGame_Id(game.getId());
        for(OrderLine orderLine : allOrderLinesByGameId) {
            orderLine.setName(game.getName());
            orderLine.setPrice(game.getPrice());
            orderLine.setGame(null);
        }
        gameRepository.deleteById(game.getId());
        return "redirect:/main";
    }

    @GetMapping("/search")
    public String search(
            @RequestParam(required = false, defaultValue = "") String filter,
            @PageableDefault(sort = {"id"}, direction = Sort.Direction.ASC) Pageable pageable,
            Model model) {
        Page<Game> games;

        if (!filter.isEmpty()) {
            games = gameRepository.findByGenreContainsOrNameContains(filter, filter, pageable);
        } else games = gameRepository.findAll(pageable);

        model.addAttribute("games", games);
        model.addAttribute("url", "/search");

        return "index";
    }

    @PostMapping("/main")
    public String add(
            @Valid Game game,
            BindingResult bindingResult,
            Model model,
            @RequestParam("file") MultipartFile file) throws IOException {
        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("game", game);
        } else {
            if (file != null) {
                File uploadDir = new File(uploadPath);

                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }
                String uuidFile = UUID.randomUUID().toString();
                String resultFilename = uuidFile + "." + file.getOriginalFilename();

                file.transferTo(new File(uploadPath + "/" + resultFilename));

                game.setFilename(resultFilename);
            }

            model.addAttribute("game", null);

            gameRepository.save(game);
        }
        Iterable<Game> games = gameRepository.findAll();

        model.addAttribute("games", games);

        return "redirect:/main";
    }
}