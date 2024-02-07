/******************************************************************
Comparing MoM Revenue

It's time for end-of-year reporting, and your manager wants you 
to put together a slide deck summarizing the top revenue 
highlights of the year and present it to the whole company on 
the all-hands call. Among other metrics and insights, your 
manager suggests that you highlight months where revenue was up 
month-over-month (MoM). In other words, she wants you to 
highlight the months where revenue was up from the previous month. 
You know this can be done with window functions using lead or lag, 
but you decide to exercise your self join skills to accomplish 
the task
******************************************************************/

with monthly_rev as
(
select 
    date_trunc('month', orderdate) as order_month, 
    sum(revenue) as monthly_revenue
from 
    subscriptions
group by 
    date_trunc('month', orderdate)
)
  
select
    cur.order_month as current_month,
    pre.order_month as previous_month,
    cur.monthly_revenue as current_revenue,
    pre.monthly_revenue as previous_revenue
from
    monthly_rev cur
join monthly_rev pre
    where cur.monthly_revenue > pre.monthly_revenue
    and datediff('month', pre.order_month, cur.order_month) = 1
