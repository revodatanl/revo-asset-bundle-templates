# Bundle Deployment

## Deploying the Databricks Asset Bundle

To deploy the Databricks Asset Bundle to a target Databricks Workspace environment, run the following command:

```bash
make deploy_*
```

The supported environments are `dev` and `prd`.

![make-deploy](assets/make-deploy_dev.png)

## Destroying the Databricks Asset Bundle

To destroy the Databricks Asset Bundle from the target Databricks Workspace environment, run the following command:

```bash
make destroy_*
```

The supported environments are `dev` and `prd`.

![make-destroy](assets/make-destroy_dev.png)
