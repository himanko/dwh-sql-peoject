/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
    The Bronze layer stores raw data without any transformations or cleaning.
    Run this script to re-define the DDL structure of 'bronze' tables.
===============================================================================
*/

USE dwh_sql_project;
GO

-- Drop and create crm_customer_info table
IF OBJECT_ID('bronze.crm_customer_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_customer_info;
GO

CREATE TABLE bronze.crm_customer_info (
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_marital_status NVARCHAR(50),
    cst_gndr NVARCHAR(10),
    cst_create_date DATE
);
GO

-- Drop and create crm_product_info table
IF OBJECT_ID('bronze.crm_product_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_product_info;
GO

CREATE TABLE bronze.crm_product_info (
    prd_id INT,
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(100),
    prd_cost DECIMAL(10,2),
    prd_line NVARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt DATE
);
GO

-- Drop and create crm_sales_details table
IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
GO

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id INT,
    sls_order_dt INT,
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales DECIMAL(12,2),
    sls_quantity INT,
    sls_price DECIMAL(10,2)
);
GO

-- Drop and create erp_customer_az12 table
IF OBJECT_ID('bronze.erp_customer_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_customer_az12;
GO

CREATE TABLE bronze.erp_customer_az12 (
    cid NVARCHAR(50),
    bdate DATE,
    gen NVARCHAR(10)
);
GO

-- Drop and create erp_loc_a101 table
IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;
GO

CREATE TABLE bronze.erp_loc_a101 (
    cid NVARCHAR(50),
    cntry NVARCHAR(50)
);
GO

-- Drop and create erp_px_cat_g1v2 table
IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;
GO

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id NVARCHAR(50),
    cat NVARCHAR(50),
    subcat NVARCHAR(50),
    maintenance NVARCHAR(50)
);
GO

