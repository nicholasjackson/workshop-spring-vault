package com.example.springvault.entity;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.vault.core.VaultTemplate;
import org.springframework.vault.core.VaultTransitOperations;
import org.springframework.vault.support.Ciphertext;
import org.springframework.vault.support.Plaintext;

import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;

public class PaymentCardListener {
  private static final Logger log = LoggerFactory.getLogger(PaymentCardListener.class);

  @Autowired
  private VaultTemplate operations;

  @PrePersist
  @PreUpdate
  public void encryptDataBeforeSave(final PaymentCard ref) {
    // encrypt the card number
    VaultTransitOperations transitOperations = operations.opsForTransit("transit");
    Ciphertext ciphertext = transitOperations.encrypt("payments", Plaintext.of(ref.getNumber()));

    ref.setNumber(ciphertext.getCiphertext());
  }
}