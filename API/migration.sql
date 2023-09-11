--Merging queries from the previous proc with the remaining tables that need manual insertion

create or alter proc sp_insertQuey_2
as
begin
declare @sql varchar(max);

print 'BEGIN TRY
    BEGIN TRANSACTION;
	

	'
	--All the insert statements that had matched fields and didn't require mannual intervention
exec sp_insertQuey;

print '
set IDENTITY_INSERT [HRMBackend].[dbo].[Teams] ON;
insert into [HRMBackend].[dbo].[Teams] (Id, Name,DepartmentId , CreatedBy, CreatedOn, LastModifiedBy, LastModifiedOn, Active)  select Id, Name, Department_ID,''7c5083e5-2a3b-431a-a8ba-9ad3644f939a'', GETDATE(),null,GETDATE(),1 from [HRM].[dbo].[Team];
set IDENTITY_INSERT [HRMBackend].[dbo].[Teams] OFF;

set IDENTITY_INSERT [HRMBackend].[dbo].[StatusWorkflows] ON;
insert into [HRMBackend].[dbo].[StatusWorkflows] (Id, Details, Sequence, EmploymentStatusId, CreatedBy, CreatedOn, LastModifiedBy, LastModifiedOn, Active)  select Id, Details, Sequence, EmpStatusId,''7c5083e5-2a3b-431a-a8ba-9ad3644f939a'', GETDATE(),null,GETDATE(),1 from [HRM].[dbo].[StatusWorkflow];
set IDENTITY_INSERT [HRMBackend].[dbo].[StatusWorkflows] OFF;

set IDENTITY_INSERT hrmbackend.[dbo].[EmployeeDetails] on;
INSERT INTO hrmbackend.[dbo].[EmployeeDetails] ([id], [FirstName], [MiddleName], [LastName], [Email], [Contact], [Ukg], [TempUkg], [EmployeeNumber], [Asana], [Location], [Remarks], [UpStatusRemarks], [Priority], [EmploymentStatusId], [DesignationId], [DepartmentId], [EmployeeRoleId], [CreatedBy], [CreatedOn], [LastModifiedBy], [LastModifiedOn]) SELECT Employee_ID, FirstName, MiddleName,LastName, Employee_Email, Contact, Employee_UKG,Temp_UKG,Emp_Number,Asana,Location, Remarks, UP_Status_Remarks, Priority, EmploymentStatus_ID,Designation_ID, Department_ID,EmployeeRole_ID, ''7c5083e5-2a3b-431a-a8ba-9ad3644f939a'', GETDATE(), NULL, GETDATE() FROM hrm.dbo.Employee;
set IDENTITY_INSERT hrmbackend.[dbo].[EmployeeDetails] off;

set IDENTITY_INSERT [HRMBackend].[dbo].[StatusChangeRemarks] ON;
INSERT INTO [HRMBackend].[dbo].[StatusChangeRemarks](id,[Remarks],[PreviousStatus],[ChangedToStatus],[EmployeeId],[Active],[CreatedBy],[CreatedOn],[LastModifiedBy],[LastModifiedOn]) select id,Remarks,PreviousStatus,ChangedToStatus,Employee_Id,1,''7c5083e5-2a3b-431a-a8ba-9ad3644f939a'',getdate(),0,GETDATE() from hrm.dbo.StatusChangeRemark;
set IDENTITY_INSERT [HRMBackend].[dbo].[StatusChangeRemarks] OFF;

insert into hrmbackend.dbo.EmployeeSkills (EmployeeId,SkillName,CreatedBy,CreatedOn,LastModifiedBy,LastModifiedOn,Active) SELECT Employee_ID, STRING_AGG(Skill_ID, '','') AS Skill_IDs,''7c5083e5-2a3b-431a-a8ba-9ad3644f939a'' ,GETDATE(),0,GETDATE(),0  FROM hrm.dbo.EmployeeSkill GROUP BY Employee_ID ;

INSERT INTO hrmbackend.[dbo].[HiringDetails] (EmployeeDetailsId ,[PlannedTat] ,[RecruitmentSourceMinute] ,[OpenDays] ,[Ttf] ,[RecruiterId] ,[HiringManagerId] ,[HiringModeId] ,[HiringSourceId] ,[CreatedBy] ,[CreatedOn] ,[LastModifiedBy] ,[LastModifiedOn]) select Employee_ID,Planned_TAT,Recruitment_source_minute,Open_Days,TTF,Recruiter_Id,HiringManager_ID,HiringMode_ID,HiringSource_ID,''7c5083e5-2a3b-431a-a8ba-9ad3644f939a'',GETDATE(),null,GETDATE() from hrm.dbo.Employee;

INSERT INTO HRMBackend.[dbo].[HiringDates] ([HiredOn] ,[TargetDateOfHire] ,[OfferedOn] ,[OfferedAcceptedOn] ,[UkgApprovedOn] ,[LastDayOnDuty] ,[PlannedStartOn] ,[CommittedJoinOn] ,[RequestOn] ,[RequestYear] ,[HiringDetailsId] ,[CreatedBy] ,[CreatedOn] ,[LastModifiedBy] ,[LastModifiedOn]) SELECT h.Hiring_Date, h.Target_Hiring_Date, h.Offered_Date, h.Offered_Accepted_Date, h.UKG_approved_Date,h.Last_Day_on_Duty, h.Planned_Start_Date, h.Committed_Join_date,h.Request_Date, h.Request_Year, d.id, ''7c5083e5-2a3b-431a-a8ba-9ad3644f939a'', GETDATE(), NULL, GETDATE() FROM HRM.dbo.Employee AS h JOIN HRMBackend.dbo.HiringDetails AS d ON h.Employee_ID=d.EmployeeDetailsId ;

INSERT INTO HRMBackend.[dbo].[Backfills] ([BackfillEmployeeNumber] ,[BackfillEmployeeName] ,[IsBackfilledAr] ,[EmployeeDetailsId] ,[CreatedBy] ,[CreatedOn] ,[LastModifiedBy] ,[LastModifiedOn]) select Backfill_Employee_Number,Backfill_Employee_Name,IsBackfilledAR,Employee_ID,''7c5083e5-2a3b-431a-a8ba-9ad3644f939a'',GETDATE(),null,GETDATE() from hrm.dbo.Employee;

INSERT INTO HRMBackend.[dbo].[LeadAndProducts] ([OffshoreLeaderId] ,[NepalLeadId] ,[OnshoreLeader] ,[OnshoreManager] ,[ProductId] ,[FunctionId] ,[ServiceId] ,[TeamId] ,[BudgetedId] ,[Art] ,[AgileTeam] ,[TeamJoinOn] ,[BudgetedYN] ,[EmployeeDetailsId] ,[CreatedBy] ,[CreatedOn] ,[LastModifiedBy] ,[LastModifiedOn]) select OffshoreLeader_Id,NepalLead_Id,OnshoreLeader,OnshoreManager,Product_Id,Functions_Id,Service_Id,Team_ID,Budgeted_ID,ART,Agile_Team,Team_Join_Date,Budgeted_Y_N,Employee_ID, ''7c5083e5-2a3b-431a-a8ba-9ad3644f939a'',GETDATE(),null,GETDATE() from hrm.dbo.Employee;'

print '    COMMIT;
    PRINT ''All data inserted successfully.'';
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT ''An error occurred while inserting data: '' + ERROR_MESSAGE();
END CATCH;'
end

go