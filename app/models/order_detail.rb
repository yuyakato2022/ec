class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item
  
  

  enum production_status: { impossible: 0, waiting: 1, making: 2, completion: 3 }
  
end
