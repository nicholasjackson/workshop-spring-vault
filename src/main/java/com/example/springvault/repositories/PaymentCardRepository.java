package com.example.springvault.repositories;

import com.example.springvault.model.PaymentCard;

import org.springframework.data.repository.CrudRepository;

public interface PaymentCardRepository extends CrudRepository<PaymentCard, Long> {

}