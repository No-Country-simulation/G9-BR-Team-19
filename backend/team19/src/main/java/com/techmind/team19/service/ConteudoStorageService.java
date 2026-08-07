package com.techmind.team19.service;

import com.techmind.team19.domain.queryResult.QueryResult;
import com.techmind.team19.domain.queryResult.QueryResultRepository;
import com.techmind.team19.dto.DadosRespostaConteudo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ConteudoStorageService {

    @Autowired
    QueryResultRepository resultRepository;

    public List<QueryResult> listar() {
        return resultRepository.findAll();
    }
    /*
    public List<DadosRespostaConteudo> listarPorCategoria(String categoria) {
        return conteudos.stream()
                .filter(c-> c.categoria().equalsIgnoreCase(categoria))
                .toList();
    }*/

}
