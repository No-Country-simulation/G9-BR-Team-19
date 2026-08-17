package com.techmind.team19.service;

import com.techmind.team19.domain.queryResult.QueryResult;
import com.techmind.team19.domain.queryResult.QueryResultRepository;
import com.techmind.team19.domain.user.User;
import com.techmind.team19.domain.user.UserRepository;
import com.techmind.team19.domain.tag.Tag;
import com.techmind.team19.dto.DadosBibliotecaItem;
import com.techmind.team19.dto.DadosRespostaConteudo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ConteudoStorageService {

    @Autowired
    QueryResultRepository resultRepository;

    @Autowired
    UserRepository userRepository;

    public List<DadosBibliotecaItem> listarBiblioteca(Authentication authentication) {

        User user = userRepository
                .findEntityByEmail(authentication.getName())
                .orElseThrow(() -> new RuntimeException("Usuário não encontrado"));

        List<QueryResult> resultados = resultRepository.findByUser(user);
        if (resultados == null) {
            return List.of();
        }

        return resultados.stream()
                .map(this::toBibliotecaItem)
                .toList();
    }

    private DadosBibliotecaItem toBibliotecaItem(QueryResult queryResult) {
        return new DadosBibliotecaItem(
                queryResult.getId(),
                queryResult.getTitle(),
                queryResult.getCategory(),
                queryResult.getProbability(),
                queryResult.getTags().stream()
                        .map(Tag::getName)
                        .collect(Collectors.toSet()),
                queryResult.getSummary(),
                queryResult.getCreatedAt()
        );
    }

    public List<DadosRespostaConteudo> listarPorCategoria(String categoria) {
        return resultRepository.findByCategoryIgnoreCase(categoria).stream()
                .map(this::toDto)
                .toList();

    }

    private DadosRespostaConteudo toDto(QueryResult queryResult) {
        return new DadosRespostaConteudo(
                queryResult.getCategory(),
                queryResult.getProbability(),
                queryResult.getTags().stream()
                        .map(Tag::getName)
                        .collect(Collectors.toSet()),
                queryResult.getSummary()
        );
    }

}
