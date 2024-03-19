-- Index pour LIST_TICKET_TASK
CREATE INDEX idx_list_ticket_task_id_ticket ON LIST_TICKET_TASK(ID_TICKET);
CREATE INDEX idx_list_ticket_task_id_ticket_task ON LIST_TICKET_TASK(ID_TICKET_TASK);

-- Index pour LIST_TICKET_SOLUTION
CREATE INDEX idx_list_ticket_solution_id_ticket ON LIST_TICKET_SOLUTION(ID_TICKET);
CREATE INDEX idx_list_ticket_solution_id_ticket_solution ON LIST_TICKET_SOLUTION(ID_TICKET_SOLUTION);

-- Index pour LIST_INVENTORY_ITEM
CREATE INDEX idx_list_inventory_item_id_user ON LIST_INVENTORY_ITEM(ID_USER);
CREATE INDEX idx_list_inventory_item_id_item ON LIST_INVENTORY_ITEM(ID_ITEM);
-- Si les requêtes filtrent souvent par QUANTITY, envisagez également cet index :
-- CREATE INDEX idx_list_inventory_item_quantity ON LIST_INVENTORY_ITEM(QUANTITY);
