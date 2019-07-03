package net.empirechaotix.shift.orderservice.dao.repositories;

import net.empirechaotix.shift.orderservice.dao.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {

    List<Order> findAllById(Long id);

}
