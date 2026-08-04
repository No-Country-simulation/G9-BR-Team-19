package com.techmind.team19.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.techmind.team19.domain.tag.DadosTag;
import com.techmind.team19.domain.tag.Tag;
import io.swagger.v3.oas.annotations.media.Schema;

import java.util.List;
import java.util.Set;

public record DadosRespostaConteudo(
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
        String summary
) {}