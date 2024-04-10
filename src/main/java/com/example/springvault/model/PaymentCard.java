package com.example.springvault.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonProperty;

@Entity
@EntityListeners(PaymentCardListener.class)
@Table(name = "paymentcard")
public class PaymentCard implements Serializable {

  private static final long serialVersionUID = 1L;

  public PaymentCard() {
  }

  @Id
  @Column(name = "id")
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "id_Sequence")
  @SequenceGenerator(name = "id_Sequence", sequenceName = "ID_SEQ")
  private long id;

  @Column(name = "user_id")
  @JsonProperty(value = "user_id")
  private long userId;

  @Column(name = "name")
  private String name;

  @Column(name = "number")
  private String number;

  @Column(name = "expiry")
  private String expiry;

  @Column(name = "cv3")
  private String cv3;

  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }

  public long getUserId() {
    return userId;
  }

  public void setUserId(long id) {
    this.userId = id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getNumber() {
    return number;
  }

  public void setNumber(String number) {
    this.number = number;
  }

  public String getExpiry() {
    return expiry;
  }

  public void setExpiry(String expiry) {
    this.expiry = expiry;
  }

  public String getCV3() {
    return cv3;
  }

  public void setCV3(String cv3) {
    this.cv3 = cv3;
  }

  public String toString() {
    StringBuilder sb = new StringBuilder("");
    sb.append("id: " + id + "\n");
    sb.append("user_id: " + userId + "\n");
    sb.append("name: " + name + "\n");
    sb.append("number: " + number + "\n");
    sb.append("expiry: " + expiry + "\n");
    sb.append("cv3: " + cv3 + "\n");

    return sb.toString();
  }
}
