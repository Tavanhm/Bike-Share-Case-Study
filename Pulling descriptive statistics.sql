/****************************************************************
The leadership team at your company is making goals for 2023 and
wants to understand how much revenue each of the product
subscriptions, basic and expert, are generating each month. More
specifically, they want to understand the distribution of monthly
revenue across the past year, 2022.

They've asked you the following questions:

1. How much revenue does each product usually generate each month?
2. Which product had the most success throughout all of last year?
3. Did either product fluctuate greatly each month or was the
month-to-month trend fairly consistent?
****************************************************************/

with ctetable as (
    select
    date_trunc('month', s.orderdate) as ordermonth,
    p.productname as productname,
    sum(s.revenue) as rev
from subscriptions s
join products p
    on s.productid = p.productid
WHERE orderdate between '2022-01-01' and '2022-12-31'
group by date_trunc('month', s.orderdate), p.productname
)
select
    productname,
    min(rev) as Min_rev,
    max(rev) as max_rev,
    avg(rev) as avg_rev,
    stddev(rev) as std_dev_rev
from ctetable
GROUP BY productname
