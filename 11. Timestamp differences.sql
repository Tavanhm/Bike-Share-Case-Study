/**************************************************************************************
Tracking User Payment Funnel Times with LEAD()

A customer has complained that it took too long for them to complete their payment 
process due to there being an error with the system. The customer support team brought 
this issue up and asked the analytics team to investigate the payment funnel time data 
for subscriptionid = 38844.

As subscriptions move through the payment statuses, they are logged in the 
paymentstatuslog table using the statusid to show what status they moved up to. They 
can go back and forth and move through status multiple times.

Each step of the payment process from the user point of view is outlined below:

1. The user opens the widget to initiate the payment process.
2. The user types in their credit card information.
3. The user clicks the 'submit' button to complete their part of the payment process.
4. The product sends the data to the third-party payment company.
5. The third-party payment company completes the transaction and reports back.
**************************************************************************************/

select
    statusmovementid,
    subscriptionid,
    statusid,
    movementdate,
    lead(movementdate,1)
        over(partition by subscriptionid
        order by movementdate) as nextstatusmovementdate,
    lead(movementdate,1)
        over(partition by subscriptionid
        order by movementdate)
    - movementdate as timeinstatus
from paymentstatuslog
where subscriptionid = '38844'
