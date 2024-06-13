-- postgresデータベースに接続
\c postgres
-- 既存のデータベースを破棄
DROP DATABASE IF EXISTS db_sales;
-- 既存のユーザを破棄
DROP ROLE IF EXISTS usr_sales;
CREATE ROLE usr_sales WITH PASSWORD 'himitu' LOGIN;
CREATE DATABASE db_sales OWNER usr_sales ENCODING 'UTF8';