package com.techmind.team19.domain.queryResult;

import com.techmind.team19.domain.tag.Tag;
import com.techmind.team19.dto.DadosRespostaConteudo;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

@Table(name = "query_result")
@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class QueryResult {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String category;

    private Double probability;

    private String summary;

    @ManyToMany
    @JoinTable(
            name = "query_result_tags",
            joinColumns = @JoinColumn(name = "query_result_id"),
            inverseJoinColumns = @JoinColumn(name = "tag_id")
    )
    private Set<Tag> tags = new HashSet<>();

    @Column(name = "created_at", updatable = false)
    @CreationTimestamp
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    @UpdateTimestamp
    private LocalDateTime updatedAt;

    public QueryResult(DadosRespostaConteudo resposta, Set<Tag> tags) {
        this.category = resposta.category();
        this.probability = resposta.probability();
        this.summary = resposta.summary();
        this.tags = tags;
    }
}
