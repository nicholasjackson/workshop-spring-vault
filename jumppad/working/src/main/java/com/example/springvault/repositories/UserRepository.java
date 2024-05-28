package com.example.springvault.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.example.springvault.entity.User;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {

}