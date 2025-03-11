USE master;
GO

-- Drop database if it exists
BEGIN TRY
    IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'dwh_sql_project')
    BEGIN
        ALTER DATABASE dwh_sql_project SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
        DROP DATABASE dwh_sql_project;
    END
END TRY
BEGIN CATCH
    PRINT 'Error occurred while dropping the database: ' + ERROR_MESSAGE();
END CATCH;
GO

-- Create the database
BEGIN TRY
    CREATE DATABASE dwh_sql_project
    PRINT 'Database dwh_sql_project created successfully.';
END TRY
BEGIN CATCH
    PRINT 'Error occurred while creating the database: ' + ERROR_MESSAGE();
END CATCH;
GO

-- Switch to the new database
USE dwh_sql_project;
GO

-- Create schemas following Medallion Architecture
BEGIN TRY
    EXEC('CREATE SCHEMA bronze;');
    PRINT 'Schema bronze created successfully.';
    
    EXEC('CREATE SCHEMA silver;');
    PRINT 'Schema silver created successfully.';
    
    EXEC('CREATE SCHEMA gold;');
    PRINT 'Schema gold created successfully.';
END TRY
BEGIN CATCH
    PRINT 'Error occurred while creating schemas: ' + ERROR_MESSAGE();
END CATCH;
GO



