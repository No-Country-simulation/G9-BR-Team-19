package com.techmind.team19.service;

import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ConteudoStorageService {

    private final List<DadosRespostaConteudo> conteudos = new ArrayList<>();

    private void salvar(DadosRespostaConteudo conteudo) {
        conteudos.add(conteudo);
    }

    private List<DadosRespostaConteudo> listar() {
        return conteudos;
    }

}
