package net.empirechaotix.shift.orderservice.service;

import net.empirechaotix.shift.orderservice.model.Item;
import org.springframework.stereotype.Service;

@Service
public class InventoryService {

    public Item getItem() {
        return new Item();
    }

    public Item updateItem(Item item) {
        return new Item();
    }
}
