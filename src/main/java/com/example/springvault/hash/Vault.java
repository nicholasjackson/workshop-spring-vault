package com.example.springvault.hash;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.vault.core.VaultTemplate;
import org.springframework.vault.core.VaultTransitOperations;
import org.springframework.vault.support.Hmac;
import org.springframework.vault.support.Plaintext;

@Component
public class Vault {
  private static VaultTemplate operations;

  @Autowired
  public Vault(VaultTemplate ops) {
    Vault.operations = ops;
  }

  public static String HCMAC(String password) {
    VaultTransitOperations transitOperations = operations.opsForTransit("transit");
    Hmac maccedPassword = transitOperations.getHmac("my-hash-key", Plaintext.of(password));
    return maccedPassword.getHmac();
  }
}
