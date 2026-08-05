package com.techmind.team19.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.techmind.team19.dto.DadosConsultaConteudos;
import com.techmind.team19.dto.DadosRespostaConteudo;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClient;
import org.springframework.web.client.RestTemplate;

@Service
public class ServiceDados {

    // URL base no application.properties
    @Value("${model.python.url}")
    private String dadosUrl;

    // dados mockados pra testar enquanto não tem modelo
    @Value("${model.python.mock-enabled:true}")
    private boolean dadosMockados;

    private final RestClient restClient = RestClient.builder().build();

    public DadosRespostaConteudo chamarModeloDados(DadosConsultaConteudos dados) {
        /*if (dadosMockados) {
            return new DadosRespostaConteudo(
                    "Backend",
                    0.89,
                    new DadosTag("Java"),
                    "Texto de exemplo para o resumo"
            );
        }*/

        try {
            ObjectMapper mapper = new ObjectMapper();
            System.out.println(dadosUrl);
            System.out.println("JSON enviado:");
            System.out.println(mapper.writeValueAsString(dados));
        } catch (Exception e) {
            e.printStackTrace();
        }

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<DadosConsultaConteudos> entity =
                new HttpEntity<>(dados, headers);

        ResponseEntity<DadosRespostaConteudo> response =
                restTemplate.postForEntity(
                        dadosUrl,
                        entity,
                        DadosRespostaConteudo.class);

        return response.getBody();
    }
}