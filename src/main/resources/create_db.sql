-- postgresデータベースに接続
\c postgres
-- 既存のデータベースを破棄
DROP DATABASE IF EXISTS salesdb;
-- 既存のユーザを破棄
DROP ROLE IF EXISTS salesuser;
CREATE ROLE salesuser WITH PASSWORD 'himitu' LOGIN;
CREATE DATABASE salesdb OWNER salesuser ENCODING 'UTF8';