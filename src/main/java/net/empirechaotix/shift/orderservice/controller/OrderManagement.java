package net.empirechaotix.shift.orderservice.controller;

import net.empirechaotix.shift.orderservice.dao.model.Order;
import net.empirechaotix.shift.orderservice.dao.repositories.OrderRepository;
import net.empirechaotix.shift.orderservice.model.Wrapper;
import net.empirechaotix.shift.orderservice.service.InventoryService;
import net.empirechaotix.shift.orderservice.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.hateoas.Resource;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("/v1/ordermanagement/")
public class OrderManagement {

    private OrderRepository orderRepository;
    private InventoryService inventoryService;
    private UserService userService;

    @Autowired
    public OrderManagement(final OrderRepository orderRepository, final InventoryService inventoryService, final UserService userService) {
        this.orderRepository = orderRepository;
        this.inventoryService = inventoryService;
        this.userService = userService;
    }

    @PostMapping("")
    Resource<Wrapper> createOrder(@RequestBody Order order) {

        Wrapper response = new Wrapper();

        order = orderRepository.save(order);

        //update inventory
        //get user details

        response.getOrders().add(order);

        return new Resource<>(response);
    }

    @DeleteMapping("/{id}")
    Resource<Wrapper> deleteOrder(@PathVariable String id) {

        Wrapper response = new Wrapper();

        List<Order> orderList = orderRepository.findAllById(Long.parseLong(id));

        if(orderList.size() > 1) {
            //should not delete more than one item, this should never happen though, since id's should be unique
            return null;
        }

        //should only have one item
        for(Order order : orderList) {
            response.getOrders().add(order);
            orderRepository.delete(order);
        }

        return new Resource<>(response);
    }

    @GetMapping("")
    Resource<Wrapper> getAll() {
        Wrapper response = new Wrapper();

        List<Order> orderList = orderRepository.findAll();

        //should only have one item
        for(Order order : orderList) {
            response.getOrders().add(order);
        }

        return new Resource<>(response);
    }

    @GetMapping("/{id}")
    Resource<Wrapper> getById(@PathVariable String id) {
        Wrapper response = new Wrapper();

        List<Order> orderList = orderRepository.findAllById(Long.parseLong(id));

        //should only have one item
        for(Order order : orderList) {
            response.getOrders().add(order);
        }

        return new Resource<>(response);
    }

}
