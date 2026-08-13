package com.techmind.team19.domain.queryResult;

import com.techmind.team19.domain.user.User;
import org.jspecify.annotations.Nullable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface QueryResultRepository extends JpaRepository<QueryResult, Long> {
<<<<<<< HEAD
    @Nullable List<QueryResult> findByUser(User user);
=======

    List<QueryResult> findByCategoryIgnoreCase(String category);
>>>>>>> feature/frontend
}
