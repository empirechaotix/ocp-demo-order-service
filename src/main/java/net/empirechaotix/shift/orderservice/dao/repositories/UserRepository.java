package net.empirechaotix.shift.orderservice.dao.repositories;

import net.empirechaotix.shift.orderservice.dao.model.Order;
import net.empirechaotix.shift.orderservice.dao.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {

    List<User> findAllById(Long id);

}
