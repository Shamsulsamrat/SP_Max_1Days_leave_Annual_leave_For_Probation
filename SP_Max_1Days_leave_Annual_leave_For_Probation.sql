SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec [dbo].[SP_Max_1Days_leave_Annual_leave_For_Probation] 1, 10, 2025, '2025-02-01'
ALTER PROCEDURE [dbo].[SP_Max_1Days_leave_Annual_leave_For_Probation]
(  
    @Employeecode  INT,
    @Leavetype     INT,
    @LeaveYear     INT,
    @startDate     DATE -- New parameter for month
)  
AS  
BEGIN  
    -- Declare variables  
    DECLARE @LeaveCount DECIMAL(19,2)
    DECLARE @Balance DECIMAL(19,2)
    DECLARE @ExistingLeave DECIMAL(19,2)

    -- Count the leaves already taken in the given month  
    SET @ExistingLeave = (
        SELECT COUNT(*)
        FROM MI_ONTIME_LeaveDetail
        WHERE EmployeeCode = @Employeecode
            AND LeaveTypeCode = @Leavetype
            AND LeaveYear = @LeaveYear
            AND MONTH(LeaveDate) = month(@startDate) 
            AND Year(LeaveDate) = year(@startDate)
            and FirstHalf = 1 -- Filter by month
            AND RequestStatus IN ('P','C')
            AND Deleted = 0
    )

    -- Check if the employee is exceeding the 1-day limit   
   DECLARE @Exceeded INT = 0 -- Default to not exceeded (0)
    IF @ExistingLeave >= 1  
    BEGIN  
        SET @Exceeded = 1 -- Set to 1 if exceeded  
    END  

    -- Return 1 if limit exceeded, 0 otherwise  
    SELECT @Exceeded AS Exceeded_Limit

END  
GO
