# Databricks Asset Bundle Templates

This directory contains custom Databricks Asset Bundle (DAB) templates. These templates provide a standardized way to create and deploy Databricks resources with consistent configurations.

## Quick start

To create a new DAB project using one of our templates:
 ```
 make module
 ```
 This will present you will present you with an interactive menu to select the type of bundle you want to create.

 ### Available Templates

 Currently, we have the following templates available:
 1. Simple notebook job - creates a basic Databricks job that runs a notebook



 ## How it works
 
 You have to be in this directory (`/modules`)to run the following commands

 ### Step 1
 
  ```
 make module
 ```

 ### Step 2

You will see a menu similar to this:
```
Select the module to deploy:
1) Deploy Databricks Asset Bundle pipeline for Azure DevOps
2) Deploy simple notebook job in Databricks
Enter the number of the module you want to deploy:
```
Follow the instructions, so enter the number of the module you want to deploy.

### Step 3
Enter a unique name for your bundle project, this will become:
 - The directory name for your new project
 - The bundle name in your `databricks.yml` configuration

 If left empty, the default name `basic_bundle` will be used.

 ### Step 4
 After creation, you will have a new directory under `modules/` with your project name. Navigate to this directory to work with your bundle

```
cd your-project-name
```

Validate your bundle configuration
```
databricks bundle validate
```
Deploy to development environment
```
databricks bundle deploy --target dev
```
Run your job
```
databricks bundle run your_job_name --target dev
```

Deploy to production
```
databricks bundle deploy --target prod
```


