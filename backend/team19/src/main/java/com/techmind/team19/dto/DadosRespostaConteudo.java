package com.techmind.team19.dto;

import java.util.List;

public record DadosRespostaConteudo(
        String categoria,
        Double probabilidade,
        List<String> tags,
        String resumo
) {}