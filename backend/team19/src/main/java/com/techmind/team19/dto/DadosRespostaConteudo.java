package com.techmind.team19.dto;

import io.swagger.v3.oas.annotations.media.Schema;

import java.util.List;

public record DadosRespostaConteudo(
        @Schema(description = "Categoria da consulta", example = "Backend")
        String categoria,

        @Schema(description = "Probabilidade", example = "0.8885")
        Double probabilidade,

        @Schema(description = "Palavras chaves", example = "Integração, spring, spring boot, boot")
        List<String> tags,

        @Schema(description = "Resumo do texto", example = "Aprendendo integração com IA")
        String resumo
) {}