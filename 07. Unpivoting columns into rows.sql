/************************************************************************************
Analyzing Subscription Cancelation Reasons

Since the chief growth officer is tackling churn next year, one of her big questions 
is: "why are users canceling and not renewing their subscriptions?" Knowing why users 
aren't renewing their subscriptions will be a key insight into how to prevent churn in 
the future. Is it because they don't like the product? Are they leaving for a 
competitor? Or maybe it's out of the budget and too expensive for them? Only the data 
can help us know for sure!

When users decide to cancel their subscription, they're able to select up to three 
reasons for canceling out of a preset list. Users can't select the same reason twice, 
and some users may even select less than three reasons and have null values in some of 
the cancelation reason columns. Since the economy has been tough lately, you decide to 
first pull the percent of canceled subscriptions that canceled due to the product being 
too expensive.
************************************************************************************/

with all_cancelation_reasons as
(
select subscriptionid, cancelationReason1 as cancelationreason from cancelations
union
select subscriptionid, cancelationReason2 as cancelationreason from cancelations
union
select subscriptionid, cancelationReason3 as cancelationreason from cancelations
)

select 
    cast(count(
        case when cancelationreason = 'Expensive' 
        then subscriptionid end) as float)
    /count(distinct subscriptionid) as percent_expensive
from    
    all_cancelation_reasons
;
