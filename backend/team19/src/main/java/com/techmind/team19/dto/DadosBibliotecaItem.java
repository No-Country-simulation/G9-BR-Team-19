package com.techmind.team19.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.v3.oas.annotations.media.Schema;

import java.time.LocalDateTime;
import java.util.Set;

public record DadosBibliotecaItem(
        @Schema(description = "Identificador da consulta")
        @JsonProperty("id")
        Long id,

        @Schema(description = "Título do conteúdo", example = "Java")
        @JsonProperty("titulo")
        String title,

        @Schema(description = "Categoria da consulta", example = "Backend")
        @JsonProperty("categoria")
        String category,

        @Schema(description = "Probabilidade", example = "0.8885")
        @JsonProperty("probabilidade")
        Double probability,

        @Schema(description = "Palavras chaves", example = "Integração, spring, spring boot, boot")
        @JsonProperty("tags")
        Set<String> tags,

        @Schema(description = "Resumo do texto", example = "Aprendendo integração com IA")
        @JsonProperty("resumo")
        String summary,

        @Schema(description = "Data de criação da consulta")
        @JsonProperty("criadoEm")
        LocalDateTime createdAt
) {}
