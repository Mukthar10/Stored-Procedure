/*create PROC [dbo].[prcSaveEmployeeData]
@EmpName varchar(20),
@EmpEmail varchar(20),
@NationalIDNumber varchar(15),
@LoginID nvarchar(256),
@OrganizationNode hierarchyId,
@JobTitle nvarchar(50),
@BirthDate date,
@MaritalStatus nchar(1),
@Gender nchar(1),
@HireDate date,
@SalariedFlag tinyint,
@VacationHours smallint,
@SickLeaveHours smallint,
@CurrentFlag tinyint,
@Rate money
AS
BEGIN
    -- Set IDENTITYINSERT ON
    
BEGIN TRY
    
    BEGIN TRANSACTION
        -- INSERTING DATA IN MASTER TABLE
        
        INSERT INTO Person.BusinessEntity
        ([rowguid], [ModifiedDate])
        Values(NEWID(), getdate())



       Declare @Id bigint
        Select @ID = SCOPE_IDENTITY()



       INSERT INTO HumanResources.Employee
        ([BusinessEntityID],[NationalIDNumber], [LoginID], [OrganizationNode], [JobTitle], [BirthDate], [MaritalStatus],
        [Gender], [HireDate], [SalariedFlag], [VacationHours], [SickLeaveHours],
        [CurrentFlag], [ModifiedDate])
        VALUES(@Id, @NationalIDNumber,@LoginID,@OrganizationNode, @JobTitle,@BirthDate, @MaritalStatus,@Gender,
        @HireDate, @SalariedFlag,@VacationHours,@SickLeaveHours,@CurrentFlag, getdate())
                
         -- @@Identity
    
        -- INSERT / UPADET DATA in CHILD TABLE(S)
        INSERT INTO HumanResources.EmployeePayHistory
        ([BusinessEntityID], [RateChangeDate], [Rate], [PayFrequency], [ModifiedDate])
        VALUES(@Id, getdate(), @Rate, '1',getdate())
    
    COMMIT TRANSACTION



END TRY
BEGIN CATCH
    if(@@TRANCOUNT>0)
        ROLLBACK TRANSACTION



       EXEC dbo.uspLogError
END CATCH
END
go
exec [dbo].[prcSaveEmployeeData] 'Sanat','abc@gmail.com','1','1',null,'software','2000-09-10','M','M','2022-01-08','0','3','1','1',2000

select * from [Sales].[SalesPerson]
select * from[Sales].[SalesOrderDetail]*/

CREATE PROC [dbo].[prcSaveSalesorder]
@SalesOrderID int,
@RevisionNumber tinyint,
@OrderDate datetime,
@DueDate datetime,
@ShipDate datetime,
@Status tinyint,
@OnlineOrderFlag bit,
@SalesOrderNumber nvarchar(25),
@PurchaseOrderNumber nvarchar(25),
@AccountNumber nvarchar(15),
@CustomerID int,
@SalesPersonID int,
@TerritoryID int,
@BillToAddressID int,
@ShipToAddressID int,
@ShipMethodID int,
@CreditCardID int,
@CreditCardApprovalCode varchar(15),
@CurrencyRateID int,
@SubTotal money,
@TaxAmt money,
@Freight money,
@TotalDue money,
@Comment nvarchar(128),
@rowguid uniqueidentifier, 
@ModifiedDate datetime,

@SalesOrderDetailID int, 
@CarrierTrackingNumber nvarchar, 
@OrderQty smallint, 
@ProductID int, 
@SpecialOfferID int, 
@UnitPrice money, 
@UnitPriceDiscount money, 
@LineTotal numeric

As
BEGIN
    -- Set IDENTITYINSERT ON
    
BEGIN TRY
    
    BEGIN TRANSACTION

	 INSERT INTO Sales.SalesOrderDetail
        ([rowguid], [ModifiedDate])
        Values(NEWID(), getdate())
		
		Declare @Id bigint
        Select @ID = SCOPE_IDENTITY()



	Insert into Sales.SalesOrderHeader([SalesOrderID], [RevisionNumber], [OrderDate], [DueDate], [ShipDate], [Status], [OnlineOrderFlag], [SalesOrderNumber],
	[PurchaseOrderNumber], [AccountNumber], [CustomerID], [SalesPersonID], [TerritoryID], [BillToAddressID], [ShipToAddressID], [ShipMethodID], [CreditCardID],
	[CreditCardApprovalCode], [CurrencyRateID], [SubTotal], [TaxAmt], [Freight], [TotalDue], [Comment], [rowguid], [ModifiedDate])
	values(@SalesOrderID,@RevisionNumber,@OrderDate,@DueDate,@ShipDate,@Status,@OnlineOrderFlag,@SalesOrderNumber,@PurchaseOrderNumber,@AccountNumber,@CustomerID,@SalesPersonID,@TerritoryID,
	@BillToAddressID,@ShipToAddressID,@ShipMethodID,@CreditCardID,@CreditCardApprovalCode,@CurrencyRateID,@SubTotal,@TaxAmt,@Freight,@TotalDue,@Comment,@rowguid,@ModifiedDate)


	Insert into Sales.SalesOrderDetail(SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber, OrderQty, ProductID, SpecialOfferID, UnitPrice, UnitPriceDiscount, LineTotal) 
	values (@SalesOrderID,@SalesOrderDetailID, @CarrierTrackingNumber, @OrderQty, @ProductID, @SpecialOfferID, @UnitPrice, @UnitPriceDiscount, @LineTotal)
	COMMIT TRANSACTION



END TRY
BEGIN CATCH
    if(@@TRANCOUNT>0)
        ROLLBACK TRANSACTION


       EXEC dbo.uspLogError
END CATCH
END







CREATE PROC [dbo].[prcSaveSalesorder2]
@SalesOrderID int,
@RevisionNumber tinyint,
@OrderDate datetime,
@DueDate datetime,
@ShipDate datetime,
@Status tinyint,
@OnlineOrderFlag bit,
@SalesOrderNumber nvarchar(25),
@PurchaseOrderNumber nvarchar(25),
@AccountNumber nvarchar(15),
@CustomerID int,
@SalesPersonID int,
@TerritoryID int,
@BillToAddressID int,
@ShipToAddressID int,
@ShipMethodID int,
@CreditCardID int,
@CreditCardApprovalCode varchar(15),
@CurrencyRateID int,
@SubTotal money,
@TaxAmt money,
@Freight money,
@TotalDue money,
@Comment nvarchar(128),
@rowguid uniqueidentifier, 
@ModifiedDate datetime
As
BEGIN
    -- Set IDENTITYINSERT ON
BEGIN TRY
    
    BEGIN TRANSACTION

	INSERT INTO Sales.SalesOrderDetail
        ([rowguid], [ModifiedDate])
        Values(NEWID(), getdate())



       Declare @Id bigint
        Select @ID = SCOPE_IDENTITY()

	Insert into Sales.SalesOrderHeader([SalesOrderID], [RevisionNumber], [OrderDate], [DueDate], [ShipDate], [Status], [OnlineOrderFlag],
	[PurchaseOrderNumber], [AccountNumber], [CustomerID], [SalesPersonID], [TerritoryID], [BillToAddressID], [ShipToAddressID], [ShipMethodID], [CreditCardID],
	[CreditCardApprovalCode], [CurrencyRateID], [SubTotal], [TaxAmt], [Freight], [TotalDue], [Comment])
	values(@SalesOrderID,@RevisionNumber,@OrderDate,@DueDate,@ShipDate,@Status,@OnlineOrderFlag,@PurchaseOrderNumber,@AccountNumber,@CustomerID,@SalesPersonID,@TerritoryID,
	@BillToAddressID,@ShipToAddressID,@ShipMethodID,@CreditCardID,@CreditCardApprovalCode,@CurrencyRateID,@SubTotal,@TaxAmt,@Freight,@TotalDue,@Comment)


	

	COMMIT TRANSACTION



END TRY
BEGIN CATCH
    if(@@TRANCOUNT>0)
        ROLLBACK TRANSACTION


       EXEC dbo.uspLogError
END CATCH
END



select * from Sales.SalesOrderHeader