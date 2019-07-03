package net.empirechaotix.shift.orderservice.model;

import lombok.Data;
import net.empirechaotix.shift.orderservice.dao.model.Order;

import java.util.List;

@Data
public class Wrapper {

    List<Order> orders;
    Version version = new Version();
}
