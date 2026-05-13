USE ROLE accountadmin;
CREATE DATABASE course_repo;
USE SCHEMA public;

-- Create credentials
CREATE OR REPLACE SECRET course_repo.public.github_pat
  TYPE = password
  USERNAME = 'DanFelCas'
  PASSWORD = '';

-- Create the API integration
CREATE OR REPLACE API INTEGRATION git_api_integration
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/DanFelCas')
  ALLOWED_AUTHENTICATION_SECRETS = (github_pat)
  ENABLED = TRUE;

-- Create the git repository object
CREATE OR REPLACE GIT REPOSITORY course_repo.public.advanced_data_engineering_snowflake
  API_INTEGRATION = git_api_integration
  ORIGIN = 'https://github.com/DanFelCas/advanced-data-engineering-snowflake.git'
  GIT_CREDENTIALS = course_repo.public.github_pat;

-- List the git repositories
SHOW GIT REPOSITORIES;