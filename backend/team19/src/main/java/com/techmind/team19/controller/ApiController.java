package com.techmind.team19.controller;

import com.techmind.team19.dto.DadosConsultaConteudos;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class ApiController {

    @PostMapping("/conteudos/processar")
    public ResponseEntity processar(@RequestBody DadosConsultaConteudos dados) {

        return ResponseEntity.ok("Endpoint funcionando");
    }

}
