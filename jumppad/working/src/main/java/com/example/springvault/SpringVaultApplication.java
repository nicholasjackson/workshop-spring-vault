package com.example.springvault;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class SpringVaultApplication {

  public static void main(String[] args) {
    SpringApplication.run(SpringVaultApplication.class, args);
  }
}