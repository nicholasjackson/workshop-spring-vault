package com.example.springvault.controllers;

import java.security.NoSuchAlgorithmException;
import java.util.Optional;

import com.example.springvault.entity.PaymentCard;
import com.example.springvault.repositories.PaymentCardRepository;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PaymentCardController {

  private static final Logger log = LoggerFactory.getLogger(PaymentCardController.class);

  @Autowired
  private PaymentCardRepository paymentCardRepo;

  @GetMapping("/paymentcard/{id}")
  public PaymentCard paymentCard(@PathVariable("id") long id) {
    return getCardById(id);
  }

  @PostMapping(path = "/paymentcard", consumes = MediaType.APPLICATION_JSON_VALUE)
  public long createNewPaymentCard(@RequestBody PaymentCard card)
      throws NoSuchAlgorithmException {
    log.info("Insert card" + card.toString());

    paymentCardRepo.save(card);

    return card.getId();
  }

  private PaymentCard getCardById(long id) {
    Optional<PaymentCard> card = paymentCardRepo.findById(id);

    if (card.isEmpty()) {
      throw new PaymentCardNotFoundException();
    }

    return card.get();
  }

  @ResponseStatus(code = HttpStatus.NOT_FOUND, reason = "user not found")
  public class PaymentCardNotFoundException extends RuntimeException {
  }
}
