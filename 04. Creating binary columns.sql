/********************************************************************
Flagging upsell opportunities for the sales team

The product team is launching a new product offering that can
be added on top of a current subscription for an increase in 
the customer's annual fee. The sales team has decided that they 
first want to reach out to a select group of customers to offer 
the new product and get feedback before offering it to the 
entire customer base.

They've decided it would be best to reach out to customers who 
meet one of the following two conditions:

1. Have at least 5,000 registered users
    - Companies with large amounts of users are significant 
      upsell opportunity, because they can lead to more potential 
      revenue. (More users = More $)
or
2. Only have one product subscription
    - Based on conversations the sales team has had with customers, 
      the companies that already have subscriptions for two products 
      are not going to be willing to spend more and add onto their 
      current subscriptions.
********************************************************************/

select
    customerid,
    count(productid) as num_products,
    sum(numberofusers) as total_users,
    case when count(productid) = 1
        or sum(numberofusers) >= 5000
        then 1 else 0
        end as upsell_opportunity
from subscriptions
group by customerid
