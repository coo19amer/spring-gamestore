package com.example.gamestore.model;

import javax.persistence.*;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;

@Entity
@Table(name = "games")
public class Game {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Поле не может быть пустым")
    private String name;

    @NotBlank(message = "Поле не может быть пустым")
    private String genre;

    @Min(value = 1, message = "Цена должна быть больше нуля")
    private Integer price;

    @Min(value = 0, message = "Количество не может быть отрицательным")
    private Integer quantity;

    @Min(value = 0, message = "Рейтинг не может быть отрицательным")
    private Integer pegi_rating;

    private String filename;

    private String description;

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getID() { return String.valueOf(id); }

    public String getPriceToString() {
        return String.valueOf(price);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Integer getPegi_rating() { return pegi_rating; }

    public void setPegi_rating(Integer pegi_rating) { this.pegi_rating = pegi_rating; }

    public String getDescription() { return description; }

    public void setDescription(String description) { this.description = description; }

    public String getGenre() { return genre; }

    public void setGenre(String genre) { this.genre = genre; }
}
