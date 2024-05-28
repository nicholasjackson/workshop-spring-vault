package com.example.springvault.entity;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;

@Entity
public class User implements Serializable {

  private static final long serialVersionUID = 1L;

  public User() {
    super();
  }

  public User(String name, String password) {
    this.name = name;
    this.password = password;
  }

  @Id
  @Column(name = "id")
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "id_Sequence")
  @SequenceGenerator(name = "id_Sequence", sequenceName = "ID_SEQ")
  private long id;

  @Column(name = "name")
  private String name;

  @Column(name = "password")
  private String password;

  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }
}