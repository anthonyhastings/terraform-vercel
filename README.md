# Terraforming Vercel

## Introduction

![terraform-vercel-provisioning](https://user-images.githubusercontent.com/167421/227387437-92a83ab1-4475-41eb-a854-de63c7a54424.gif)

This repository showcases using Terraform to provision a Vercel project with environment variables.

## What Is Terraform?

Terraform is an open-source infrastructure as code (IaC) tool that allows you to manage and provision infrastructure resources such as servers, storage, networks, and more across multiple cloud platforms and service providers using a declarative configuration language. It enables you to create, modify, and destroy infrastructure resources in a repeatable and consistent manner. 

Infrastructure as code makes it easier to version, share, and collaborate with others, and ensures that your infrastructure is always up-to-date and consistent with your desired state. Terraform provides a powerful execution plan feature that helps you to understand the changes that will be made to your infrastructure before you apply them.

## How Does It Keep Track Of State?

In Terraform, state refers to the current state of the infrastructure that is being managed. This includes information about the resources that have been created, their current configuration, and any dependencies between them.

Terraform stores this state information in a state file which it uses to determine the changes that need to be made to the infrastructure when you run the `terraform apply` command.

The state file is either stored locally on your machine or remotely in the cloud (such as an S3 bucket, database or VCS provider). Remote storage is useful when working in a team and/or when you want to execute Terraform via CI.

## Command Breakdown

### `init`

This command initializes a working directory containing Terraform configuration files. This is the first command that should be run after writing a new Terraform configuration or cloning an existing one from version control.

It is safe to run this command multiple times. It pulls down providers listed within the Terraform script and generates a lockfile (`.terraform.lock.hcl`) listing the versions used.

During init, the root configuration directory is consulted for backend configuration and the chosen backend is initialized using the given configuration settings. This allows the script to read and write remote state.

```sh
  terraform init
```

### `plan`

You can use this command to create an execution plan by reading current state and diffing it against the current script. Use this command to check whether the proposed changes match what you expected before you apply the changes. If Terraform detects that no changes are needed to resource instances then the command will report that no actions need to be taken.

You can use the optional `-out=FILE` option to save the generated plan to a file on disk, which you can later execute by passing the file to `terraform apply` as an extra argument. This two-step workflow is primarily intended for when running Terraform in automation.

```sh
  terraform plan -out=plan
```

### `show`

The terraform show command is used to provide human-readable output from a state or plan file. This can be used to inspect a plan to ensure that the planned operations are expected, or to inspect the current state as Terraform sees it.

```sh
  terraform show "plan"
```

### `apply`

The terraform apply command executes the actions proposed in a Terraform plan.

When you run terraform apply without passing a saved plan file, Terraform automatically creates a new execution plan as if you had run terraform plan, prompts you to approve that plan, and takes the indicated actions. 

When you pass a saved plan file to terraform apply, Terraform takes the actions in the saved plan without prompting you for confirmation. You may want to use this two-step workflow when running Terraform in automation.

```sh
  terraform apply "plan"
```

### `destroy`

The terraform destroy command is a convenient way to destroy all remote objects managed by a particular Terraform configuration.

While you will typically not want to destroy long-lived objects in a production environment, Terraform is sometimes used to manage ephemeral infrastructure for development purposes, in which case you can use terraform destroy to conveniently clean up all of those temporary objects once you are finished with your work.

```sh
  terraform destroy
```

## Further Information
 - [Vercel Provider](https://registry.terraform.io/providers/vercel/vercel/latest/docs)
 - [Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)
 - [Protect Sensitive Input Variables](https://developer.hashicorp.com/terraform/tutorials/configuration-language/sensitive-variables)
 - [Running Terraform in Automation](https://developer.hashicorp.com/terraform/tutorials/automation/automate-terraform)
 - [Terraform Command: init](https://developer.hashicorp.com/terraform/cli/commands/init)
 - [Terraform Command: plan](https://developer.hashicorp.com/terraform/cli/commands/plan)