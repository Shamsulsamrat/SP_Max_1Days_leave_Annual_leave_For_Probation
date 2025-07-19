# SP_Max_1Days_leave_Annual_leave_For_Probation
SP_Max_1Days_leave_Annual_leave_For_Probation
📄 README: SP_Max_1Days_leave_Annual_leave_For_Probation.sql
Stored Procedure Name:
SP_Max_1Days_leave_Annual_leave_For_Probation

Purpose:
This stored procedure validates whether a probationary employee is attempting to apply for more than 1 day of Annual Leave in a given month.
It enforces the maximum 1-day annual leave per month rule during the probation period.

Parameters:
Parameter	Type	Description
@Employeecode	INT	Unique ID of the employee
@Leavetype	INT	Leave type code (e.g., Annual Leave = 10)
@LeaveYear	INT	Leave year (e.g., 2025)
@startDate	DATE	Start date of the leave request (to get month)

Logic:
The procedure counts how many approved (C) or pending (P) annual leave requests of type @Leavetype the employee has already taken in the same month and year as @startDate.

It only considers first half leaves (FirstHalf = 1) to support half-day leave logic.

If more than or equal to 1 day has already been applied in the month, it flags it as exceeding the limit.

Return Value:
Return Column	Type	Meaning
Exceeded_Limit	INT	1 = Limit exceeded, 0 = Within limit
