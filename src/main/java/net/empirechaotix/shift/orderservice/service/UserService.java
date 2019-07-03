package net.empirechaotix.shift.orderservice.service;

import net.empirechaotix.shift.orderservice.model.User;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    public User getUser() {
        return new User();
    }
}
