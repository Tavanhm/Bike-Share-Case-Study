/******************************************************
A manager on the marketing team comes to you to ask
about the performance of their recent email campaign.
Now that the campaign has been launched, the marketing
manager wants to know how many users have clicked the
link in the email.

While this project was being planned, you collaborated
with the front-end engineers to create tracking events 
for the front end of the product located in the 
frontendeventlog table. One of these events, eventid = 5
is logged when the user reaches a unique landing page 
that is only accessed from this campaign email. Since 
the event tracks when a user views the unique landing 
page from the email, tracking eventid = 5 will be the
best method to count how many users have clicked the 
link in the campaign email.
******************************************************/

with user_clicks as (
select
    userid,
    count(userid) as clicks
from frontendeventlog
where eventid = 5
group by userid
)

select
    clicks as num_link_clicks,
    count(userid) as Num_users
from user_clicks
group by num_link_clicks
