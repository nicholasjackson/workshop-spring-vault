package com.example.springvault.hash;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.Provider;
import java.security.SecureRandom;
import java.security.Security;
import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.DatatypeConverter;

import org.assertj.core.util.Arrays;
import org.junit.jupiter.api.Test;

public class MD5HashTests {

  @Test
  void hashPasswordThenVerify() throws NoSuchAlgorithmException {
    String password = "ILoveJava";
    String checksum = "35454b055cc325ea1af2126e27707052";

    String hash = Hash.MD5(password);

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