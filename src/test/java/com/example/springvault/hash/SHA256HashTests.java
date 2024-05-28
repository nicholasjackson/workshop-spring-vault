package com.example.springvault.hash;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.security.NoSuchAlgorithmException;
import org.junit.jupiter.api.Test;

public class SHA256HashTests {

  @Test
  void hashPasswordThenVerify() throws NoSuchAlgorithmException {
    String password = "ILoveJava";
    String checksum = "e35089b2d968d2c00562279dd210847f3e156caa7c9affbaa45a25c6c0e75edf";

    String hash = Hash.SHA256(password);

    assertEquals(checksum, hash);
  }

  // @Test
  // void hashPasswordListAndWriteToFile() throws NoSuchAlgorithmException,
  // FileNotFoundException {
  // String filename = "hashedpasswords2.txt";
  // List<String> passwords = List.of(
  // "flatron",
  // "fatty1",
  // "edmund",
  // "doritos",
  // "ddddd",
  // "darien",
  // "dammit",
  // "august1",
  // "annabel",
  // "angelbaby1",
  // "amber123",
  // "Rangers",
  // "HOTTIE");

  // File myFile = new File(filename);
  // myFile.delete();

  // PrintWriter myWriter = new PrintWriter(filename);

  // for (String password : passwords) {
  // // byte[] salt = getSalt();
  // String salt = "mysalt";

  // // MessageDigest md = MessageDigest.getInstance("SHA-256");
  // MessageDigest md = MessageDigest.getInstance("MD5");
  // md.update(password.getBytes());
  // md.update(salt.getBytes());

  // byte[] digest = md.digest();

  // String myHash = DatatypeConverter
  // .printHexBinary(digest).toLowerCase();

  // String mySalt = DatatypeConverter
  // .printHexBinary(salt.getBytes()).toLowerCase();

  // myWriter.println(myHash + ":" + mySalt);
  // // myWriter.println(myHash);
  // }

  // myWriter.close();
  // }
}