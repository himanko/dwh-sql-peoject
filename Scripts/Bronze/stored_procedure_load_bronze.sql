/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from CSV files to bronze tables.
    - Logs execution time for each operation.
    - Implements error handling using TRY...CATCH to log failures.

Parameters:
    None. This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze_layer;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze_layer AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME;
    PRINT '================================================';
    PRINT 'Starting Bronze Layer Data Load';
    PRINT '================================================';

    BEGIN TRY
        ----------------------
        -- Load CRM Tables --
        ----------------------
        PRINT '------------------------------------------------';
        PRINT 'Loading CRM Tables';
        PRINT '------------------------------------------------';

        -- Load crm_customer_info
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_customer_info';
        TRUNCATE TABLE bronze.crm_customer_info;
        SET @end_time = GETDATE();
        PRINT '>> Truncate Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        SET @start_time = GETDATE();
        PRINT '>> Loading Data Into: bronze.crm_customer_info';
        BULK INSERT bronze.crm_customer_info
        FROM 'C:\Users\Lenovo\Github Projects\dwh-sql-peoject\Data\source_crm\cust_info.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        -- Load crm_product_info
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_product_info;
        SET @end_time = GETDATE();
        PRINT '>> Truncated bronze.crm_product_info in ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        SET @start_time = GETDATE();
        BULK INSERT bronze.crm_product_info
        FROM 'C:\Users\Lenovo\Github Projects\dwh-sql-peoject\Data\source_crm\prd_info.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Loaded bronze.crm_product_info in ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

		-- Load bronze.crm_sales_details
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_sales_details;
        SET @end_time = GETDATE();
        PRINT '>> Truncated bronze.crm_sales_details in ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        SET @start_time = GETDATE();
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\Lenovo\Github Projects\dwh-sql-peoject\Data\source_crm\sales_details.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Loaded bronze.crm_sales_details in ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        ----------------------
        -- Load ERP Tables --
        ----------------------
        PRINT '------------------------------------------------';
        PRINT 'Loading ERP Tables';
        PRINT '------------------------------------------------';

        -- Load erp_customer_az12
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_customer_az12;
        SET @end_time = GETDATE();
        PRINT '>> Truncated bronze.erp_customer_az12 in ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        SET @start_time = GETDATE();
        BULK INSERT bronze.erp_customer_az12
        FROM 'C:\Users\Lenovo\Github Projects\dwh-sql-peoject\Data\source_erp\CUST_AZ12.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Loaded bronze.erp_customer_az12 in ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

		-- Load bronze.erp_loc_a101
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_loc_a101;
        SET @end_time = GETDATE();
        PRINT '>> Truncated bronze.erp_loc_a101 in ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        SET @start_time = GETDATE();
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\Lenovo\Github Projects\dwh-sql-peoject\Data\source_erp\LOC_A101.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Loaded bronze.erp_loc_a101 in ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

		-- Load bronze.erp_px_cat_g1v2
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        SET @end_time = GETDATE();
        PRINT '>> Truncated bronze.erp_px_cat_g1v2 in ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        SET @start_time = GETDATE();
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\Lenovo\Github Projects\dwh-sql-peoject\Data\source_erp\PX_CAT_G1V2.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Loaded bronze.erp_px_cat_g1v2 in ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
    
    END TRY
    BEGIN CATCH
        PRINT '!!! ERROR OCCURRED DURING DATA LOADING !!!';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Severity: ' + CAST(ERROR_SEVERITY() AS NVARCHAR);
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT 'Error Procedure: ' + COALESCE(ERROR_PROCEDURE(), 'N/A');
        PRINT 'Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR);
    END CATCH

    PRINT '================================================';
    PRINT 'Bronze Layer Data Load Completed';
    PRINT '================================================';
END

-- Execute the procedure
-- EXEC bronze.load_bronze_layer;

