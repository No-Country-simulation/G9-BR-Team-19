package com.techmind.team19.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;

public record DadosConsultaConteudos(
        @Schema(description = "Título do conteúdo", example = "Java")
        @NotBlank(message = "Titulo obrigatório")
        String titulo,

        @Schema(description = "Texto a ser analisado", example = "Spring Boot facilita o desenvolvimento...")
        @NotBlank(message = "Texto obrigatório")
        String texto) {
}
