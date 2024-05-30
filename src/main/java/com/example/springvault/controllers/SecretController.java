package com.example.springvault.controllers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SecretController {

  private static final Logger log = LoggerFactory.getLogger(PaymentCardController.class);

  @Value("${password}")
  String password;

  @GetMapping("/secret")
  public String secret() {
    return "My password is: " + password;
  }
}
