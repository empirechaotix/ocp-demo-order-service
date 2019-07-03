package net.empirechaotix.shift.orderservice.dao.repositories;

import net.empirechaotix.shift.orderservice.dao.model.Item;
import net.empirechaotix.shift.orderservice.dao.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ItemRepository extends JpaRepository<Item, Long> {

    List<Item> findAllById(Long id);

}
