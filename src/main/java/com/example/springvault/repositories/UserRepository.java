package com.example.springvault.repositories;

import com.example.springvault.model.User;

import org.springframework.data.repository.CrudRepository;

public interface UserRepository extends CrudRepository<User, Long> {

}