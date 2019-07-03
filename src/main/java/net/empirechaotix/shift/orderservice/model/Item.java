package net.empirechaotix.shift.orderservice.model;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

public class Item {

    private Long id;

    private Long item_id;

    private Integer quantity;

}
