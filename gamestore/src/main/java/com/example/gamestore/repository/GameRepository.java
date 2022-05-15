package com.example.gamestore.repository;

import com.example.gamestore.model.Game;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

public interface GameRepository extends CrudRepository<Game, Long> {
    Page<Game> findByGenreContainsOrNameContains (@Param("genre") String author, @Param("name") String name, Pageable pageable);

    Page<Game> findAll(Pageable pageable);
}
