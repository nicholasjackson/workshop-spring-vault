package com.example.springvault.hash;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Hash {
  public Hash() {
  }

  private static String bytesToHex(byte[] hash) {
    StringBuilder hexString = new StringBuilder(2 * hash.length);
    for (int i = 0; i < hash.length; i++) {
      String hex = Integer.toHexString(0xff & hash[i]);
      if (hex.length() == 1) {
        hexString.append('0');
      }
      hexString.append(hex);
    }
    return hexString.toString();
  }

  public static String SHA256(String password) throws NoSuchAlgorithmException {
    MessageDigest md = MessageDigest.getInstance("SHA-256");
    md.update(password.getBytes());

    byte[] digest = md.digest();

    return bytesToHex(digest);
  }
}
