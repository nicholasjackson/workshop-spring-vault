package com.example.springvault;

import com.example.springvault.hash.Hash;
import com.example.springvault.model.User;
import com.example.springvault.repositories.UserRepository;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
class LoadDatabase {

  private static final Logger log = LoggerFactory.getLogger(LoadDatabase.class);

  @Bean
  CommandLineRunner initDatabase(UserRepository repository) {

    return args -> {
      log.info("Preloading " + repository.save(new User("Bilbo Baggins", Hash.MD5("burglar"))));
      log.info("Preloading " + repository.save(new User("Frodo Baggins", Hash.MD5("thief"))));
    };
  }
}