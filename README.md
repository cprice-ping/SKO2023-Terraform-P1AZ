# SKO 2023 - PingOne Authorize

This repo contains the configuration that will be discussed in the P1AZ session.

## Folders

`terraform` - Contains the HCL to create as much as possible of the PingOne Environment
`davinci` - Contains a DaVinci flow used in the Labs
`policies` - Contains the Policy sets for the Labs

## Terraform

Terraform HCL is provided to create the PingOne Environment that is needed for the P1AZ Trust Framework and Policies.

To execute, clone this repo and do the following:

Add a `terraform.tfvars` file to the cloned `terraform` folder.

```hcl
region = "{{ NorthAmerica | Canada | Asia | Europe }}"
organization_id = "{{orgId}}"
admin_env_id = "{{adminEnvId}}"
admin_user_id = "{{adminUserId}}"
worker_id = "{{workerId}}"
worker_secret = "{{workerSecret}}"
deploy_name = "SKO2023 - PingOne Authorize"
```

Replace `{{ ... }}` with your PingOne details

At a command line:

```hcl
terraform init
terraform plan
```

If the plan fails - check your `terraform.tfvars` values. 

If the plan succeeds:

```hcl
terraform apply —auto-approve
````

Terraform should execute and display a set of values that need to be manually entered into the created PingOne users

## Clicky Clicky (for the non Terraform folks)

### PingOne Environment

Create a PingOne Environment.

#### PingOne Directory

Add 2 Custom Attributes

| Name | Settings |
| --- | --- |
| `parent` |  STRING |
| `children` | JSON multi-valued |

Add 3 Users

* Parent
* Child1
* Child2

#### PingOne Authorize

Add PingOne Authorize to your Environment

>**Note** Make sure you can **Import** -- check the Version History tab.
>If you can't - ask for the Feature Flag to be added to this Env

## Additional PingOne Configuration

### PingOne Users

Data for the Labs need to be manually added to the following Users:

| P1 User | Attribute | Value |
| --- | --- | --- |
| child1 | "Parent ID" | parentId (Terraform ouput) |
| child2 | "Parent ID" | parentId (Terraform ouput) |
| parent | "Children" | `[{"id":"{{child1.id}}","limit":100},{"id":"{{child2.id}}","limit":200}]`

### PingOne Authorize

Decision Endpoints -- Test

* Enable "Record recent decisions"

## Labs

* [Lab 1](./P1AZ%20Labs/Lab1.md)
* [Lab 2](./P1AZ%20Labs/Lab2.md)
* [Lab 3](./P1AZ%20Labs/Lab3.md)