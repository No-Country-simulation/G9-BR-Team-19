package com.techmind.team19.domain.queryResult;

import com.techmind.team19.domain.user.User;
import org.jspecify.annotations.Nullable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface QueryResultRepository extends JpaRepository<QueryResult, Long> {
    @Nullable List<QueryResult> findByUser(User user);

    List<QueryResult> findByCategoryIgnoreCase(String category);
    
    Optional<QueryResult> findByIdAndUser(Long id, User user);
}
