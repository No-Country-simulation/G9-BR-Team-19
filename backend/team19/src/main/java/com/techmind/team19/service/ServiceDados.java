package com.techmind.team19.service;

import com.techmind.team19.dto.DadosConsultaConteudos;
import com.techmind.team19.dto.DadosRespostaConteudo;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClient;
import java.util.List;

@Service
public class ServiceDados {

    // URL base no application.properties
    @Value("${model.python.url}")
    private String dadosUrl;

    // dados mockados pra testar enquanto não tem modelo
    @Value("${model.python.mock-enabled:true}")
    private boolean dadosMockados;

    private final RestClient restClient = RestClient.create();

    public DadosRespostaConteudo chamarModeloDados(DadosConsultaConteudos dados) {
        if (dadosMockados) {
            return new DadosRespostaConteudo(
                    "Backend",
                    0.89,
                    List.of("Java", "Spring Boot", "API REST"),
                    "Texto de exemplo para o resumo"
            );
        }

        return restClient.post()
                .uri(dadosUrl)
                .body(dados)
                .retrieve()
                .body(DadosRespostaConteudo.class);
    }
}