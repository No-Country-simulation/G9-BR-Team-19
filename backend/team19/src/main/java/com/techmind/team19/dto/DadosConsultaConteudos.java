package com.techmind.team19.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;

public record DadosConsultaConteudos(
        @Schema(description = "Título do conteúdo", example = "Java")
        @NotBlank(message = "Titulo obrigatório")
        @JsonProperty("titulo")
        String title,

        @Schema(description = "Texto a ser analisado", example = "Spring Boot facilita o desenvolvimento...")
        @NotBlank(message = "Texto obrigatório")
        @JsonProperty("texto")
        String text) {
}
