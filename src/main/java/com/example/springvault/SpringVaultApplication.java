package com.example.springvault;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RestController;

import jakarta.annotation.PostConstruct;

@SpringBootApplication
@RestController
public class SpringVaultApplication {

  public static void main(String[] args) {
    SpringApplication.run(SpringVaultApplication.class, args);
  }

  @Value("${password}")
  String password;

  @PostConstruct
  private void postConstruct() {
    System.out.println("My password is: " + password);
  }
}