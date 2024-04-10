package com.example.springvault.controllers;

import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.example.springvault.hash.Vault;
import com.example.springvault.model.User;
import com.example.springvault.repositories.UserRepository;

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
public class UserController {

  private static final Logger log = LoggerFactory.getLogger(UserController.class);

  @Autowired
  private UserRepository userRepo;

  @GetMapping("/users")
  public User[] users() {
    List<User> users = new ArrayList<User>();
    userRepo.findAll().forEach(users::add);

    return users.toArray(new User[users.size()]);
  }

  @PostMapping(path = "/user/{id}/password", consumes = MediaType.TEXT_PLAIN_VALUE)
  public void updatePassword(@PathVariable("id") long id, @RequestBody String password)
      throws NoSuchAlgorithmException {

    log.info("Update password for id: " + id);

    // fetch the user
    Optional<User> user = userRepo.findById(id);
    if (user.isEmpty()) {
      throw new UserNotFoundException();
    }

    user.get().setPassword(Vault.HCMAC(password));

    userRepo.save(user.get());
  }

  @ResponseStatus(code = HttpStatus.NOT_FOUND, reason = "user not found")
  public class UserNotFoundException extends RuntimeException {
  }
}
