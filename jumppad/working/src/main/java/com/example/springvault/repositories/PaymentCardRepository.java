package com.example.springvault.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.example.springvault.entity.PaymentCard;

@Repository
public interface PaymentCardRepository extends CrudRepository<PaymentCard, Long> {

}