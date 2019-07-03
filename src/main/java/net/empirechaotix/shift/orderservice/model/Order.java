package net.empirechaotix.shift.orderservice.model;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.List;

public class Order {

    private Long id;

    private String date;

    private List<Item> items;

    private User user;

}
