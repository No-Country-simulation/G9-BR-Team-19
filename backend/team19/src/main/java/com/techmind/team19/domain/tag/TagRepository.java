package com.techmind.team19.domain.tag;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface TagRepository extends JpaRepository<Tag, Long> {
    Optional<Tag> findByName(String name);

    @Query(value = "SELECT EXIST (SELECT 1 FROM tag LIMIT 1)", nativeQuery = true)
    Boolean tabelaTemRegistro();
}
