package com.techmind.team19.dto;

import com.techmind.team19.domain.tag.DadosTag;
import com.techmind.team19.domain.tag.Tag;
import io.swagger.v3.oas.annotations.media.Schema;

import java.util.List;
import java.util.Set;

public record DadosRespostaConteudo(
        @Schema(description = "Categoria da consulta", example = "Backend")
        String category,

        @Schema(description = "Probabilidade", example = "0.8885")
        Double probability,

        @Schema(description = "Palavras chaves", example = "Integração, spring, spring boot, boot")
        Set<DadosTag> tags,

        @Schema(description = "Resumo do texto", example = "Aprendendo integração com IA")
        String summary
) {}