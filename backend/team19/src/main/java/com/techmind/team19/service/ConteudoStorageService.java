package com.techmind.team19.service;

import com.techmind.team19.domain.queryResult.QueryResult;
import com.techmind.team19.domain.queryResult.QueryResultRepository;
import com.techmind.team19.domain.user.User;
import com.techmind.team19.domain.user.UserRepository;
import com.techmind.team19.dto.DadosRespostaConteudo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ConteudoStorageService {

    @Autowired
    QueryResultRepository resultRepository;

    @Autowired
    UserRepository userRepository;

    public List<QueryResult> listarBiblioteca(Authentication authentication) {

        User user = userRepository
                .findEntityByEmail(authentication.getName())
                .orElseThrow(() -> new RuntimeException("Usuário não encontrado"));

        return resultRepository.findByUser(user);
    }

}
