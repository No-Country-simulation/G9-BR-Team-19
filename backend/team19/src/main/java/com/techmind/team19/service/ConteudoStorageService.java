package com.techmind.team19.service;

import com.techmind.team19.dto.DadosRespostaConteudo;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.List;

@Service
public class ConteudoStorageService {

    private final List<DadosRespostaConteudo> conteudos = new ArrayList<>();

    public void salvar(DadosRespostaConteudo conteudo) {
        conteudos.add(conteudo);
    }

    public List<DadosRespostaConteudo> listar() {
        return conteudos;
    }

    public List<DadosRespostaConteudo> listarPorCategoria(String categoria) {
        return conteudos.stream()
                .filter(c-> c.categoria().equalsIgnoreCase(categoria))
                .toList();
    }

}
