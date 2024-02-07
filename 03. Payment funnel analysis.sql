/************************************************************************************
The product manager has requested a payment funnel analysis from the analytics team;
she wants to understand what the furthest point in the payment process users are
getting to and where users are falling out of the process. She wants to have full
visibility into each possible stage of the payment process from the user's point of
view.

Here's the payment process a user goes through when signing up for a subscription:

1. The user opens the widget to initiate payment process.
2. The user types in credit card information.
3. The user clicks the submit button to complete their part of the payment process
4. The product sends the data to the third-party payment processing company.
5. The payment company completes the transaction and reports back with 'complete'
************************************************************************************/

with maxsub as (
select
	subscriptionID,
	max(statusid) as maxstatus
from paymentstatuslog
group by subscriptionid
),

casetable as (
select
	s.subscriptionid,
	case when maxstatus = 1 then 'PaymentWidgetOpened'
		when maxstatus = 2 then 'PaymentEntered'
		when maxstatus = 3 and currentstatus = 0 then 'User Error with Payment Submission'
		when maxstatus = 3 and currentstatus != 0 then 'Payment Submitted'
		when maxstatus = 4 and currentstatus = 0 then 'Payment Processing Error with Vendor'
		when maxstatus = 4 and currentstatus != 0 then 'Payment Success'
		when maxstatus = 5 then 'Complete'
		when maxstatus is null then 'User did not start payment process'
		end as paymentfunnelstage
from subscriptions s
left join maxsub m
	on s.subscriptionid = m.subscriptionid
group by s.subscriptionid, currentstatus
)

select
	paymentfunnelstage,
	count(subscriptionid) as subscriptions
from
	casetable
group by paymentfunnelstage
