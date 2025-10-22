# terraform-databricks-azure

Terraform for setting up a secure Azure &amp; Databricks infrastructure (including networking).

## FAQ

### How should I name resources?

A comprehensive naming convention is important for managing resources in Azure. It is recommended to review
the [Azure resource naming](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)
best practices and create a naming convention that works for your organization.

At a minimum, it is recommended to include the following components in your resource names:

- Resource type abbreviation (e.g. vnet, nsg, vm)
- Environment (e.g. dev, test, prod)
- Region abbreviation (e.g. eus, usw, wua)
- Purpose or project name (e.g. analytics, webapp)
- Instance or sequence number (e.g. 01, 02)

Optionally, if your organization uses multiple cloud providers, you may also want to include a cloud provider
abbreviation (e.g. az for Azure, aws for AWS, gcp for Google Cloud).
This is most useful when using 3rd party tools that help manage resources or cost across multiple cloud providers.

For example, a production Databricks workspace for analytics projects in East US could be named:
`az-dbw-p-eus-analytics-01`

### Should I have one workspace (per environment) or many workspaces?

This largely depends on how your company operates and how many teams or projects you have.

Even if you have many different teams and projects, permissions can be managed effectively within a single workspace.
Therefore, the decision to have one or multiple workspaces is largely based on how you want to split/manage costs, and
perform cost reporting.

Multiple workspaces will ensure you can split costs exactly, but will increase the complexity of your setup and
management. Tags can be set at the resource group level, which will then automatically apply to all resources within for
cost reporting.
Multiple workspaces may also lead to higher costs overall, as compute resources will not be shared between workspaces.

When using a single workspace, additional planning will be needed to ensure that resources are being tagged correctly
for cost reporting.
Additional, complex, analysis will also be needed to accurately spit costs for shared resources (such as clusters or SQL
Warehouses).

The last thing to take into consideration is IP address management. Using a single workspace, will allow for better
utilization of IP address space; whereas multiple workspaces will require separate IP address spaces, which may lead to
wasted IP addresses.

###