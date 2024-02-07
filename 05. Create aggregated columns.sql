/************************************************************************************
Tracking user activity with frontend events

The design team recently redesigned the customer support page on the website, and 
they want to run an AB test to see how the newly designed page performs compared 
to the original. An AB test is a statistical test used frequently in data science 
to measure the impact changes have on specified metrics. The users will be randomly
assigned into two groups: control and treatment. The users in the control group will
see the current customer support page, and the users in the treatment will see the 
new page design. The analytics team needs to track user activity via frontend events
(buttons clicking, page viewing, etc.) to inform the product team for future
iterations. At the end of the experiment, the results of the control and treatment
group will be compared to make a final product recommendation
************************************************************************************/

select
    log.userid,
        sum(case when log.eventid = 1 then 1 else 0 end) as ViewedHelpCenterPage,
        sum(case when log.eventid = 2 then 1 else 0 end) as ClickedFAQs,
        sum(case when log.eventid = 3 then 1 else 0 end) as ClickedContactSupport,
        sum(case when log.eventid = 4 then 1 else 0 end) as Submittedticket
from frontendeventlog log
join frontendeventdefinitions def
    on log.eventid = def.eventid
where def.eventtype = 'Customer Support'
group by log.userid
