/******************************************************************
Pulling employee/manager data with a self join

The VP of sales is currently contacting all the managers who have 
direct reports in the Sales department to notify them of the new 
commission structure. Using the employees table, which contains 
all employees and their associated manager, you can pull a report 
of all sales employees and their manager's email address using a 
self join. However, with your sharp thinking, you notice that 
several employees have null values for their manager's email 
address due to the fact that some employees don't have a manager 
logged in the database.
******************************************************************/

select
    emp.employeeid,
    emp.name as employee_name,
    man.name as manager_name,
    case
        when man.name is null then emp.email
        else man.email
    end as contact_email
from employees emp
left join employees man
    on man.employeeid = emp.managerid
where emp.department = 'Sales'
