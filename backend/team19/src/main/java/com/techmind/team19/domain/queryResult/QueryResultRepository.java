package com.techmind.team19.domain.queryResult;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface QueryResultRepository extends JpaRepository<QueryResult, Long> {

    List<QueryResult> findByCategoryIgnoreCase(String category);
}
