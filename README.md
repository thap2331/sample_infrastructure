
# Questions
## Imagine the Python script needed credentials to connect to the CMS database and spreadsheet. What are some security best practices you would consider?
- One solution is to use cloud service infrastructure itself. Example, give an appropriate access to the ec2-instance and the script runner environment so that it can access aws secrets manager.
- We can also restrict who can access the database, e.g. restrict ip address.
- Keep the database in private sub network.
- Scan the terraform infratructure for security and address them as per team discussion.

## In your ideal setup, how would changes to the Python script or terraform code be deployed?
- Ideally, I would set up CI/CD for both. First, I would like to keep infrastructure repo seperate from python script repo. Second, even for infrastructure repo, I would want to treat them as a regular work flow, e.g. peer review and merging.
- Second, depending upon the need, we can register the runner (for the repo) in a given ec2 instance and then set up CI/CD flow. Thus, as changes occur we can test and deploy them.

## Imagine we start to create similar Python scripts and need to deploy/execute those as well. How would you keep this setup DRY and empower developers to provision on their own?
- In case of needing to provisioning infrastructure for each script as we develop them, I think we can make terraform more modular. For example, the basic set up (vpc, subnets, security groups, etcs) can be reused to provision a new infrastructure/ec2-instance. Regardless, we should try to keep terraform modular (with moderation so that we can still read and understand it) to automate our workflow.
- In another words, develop/build terraform in a way that developer can invoke an infrastructure just with a bash commond. 


# Run this terraform 

### Step 1: Configure aws. Export below to your terminal.
- `export AWS_ACCESS_KEY_ID=#####`
- `export AWS_SECRET_ACCESS_KEY=####`
- `export AWS_SESSION_TOKEN=####`

### Step 2: Create key pair (pick rsa, .pem) to ssh into the box. 
- Please name your key-pair as test_kp as that is what will be used in terraform. (The key pair will be shared either using password sharing tool like lastpass/OnePass or other aws secure mechanism.)
- Follow this link to create key pair. https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-key-pairs.html

### Step 3
- cd to dev or prod
- `terraform init`
- `terraform validate`
- `terraform plan` to see more into
- Use `tfsec` or other reliable ways to check terraform security
- `terraform apply` or `terraform apply -auto-approve`

## Notes:
- I am creating most of the resources from scratch. I can also import from existings resouece. Example, use data resource {}
- I am not using other modules that are out there. But I know we can leverage them.
- I am allowing inbound rules to be from all 0.0.0.0/0 so that you would not have to modify terraform if you want to run it. But this will be modified to specific ips so that security is not breached.

### Terraform security check
`curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash`
- `tfsec dev/`

### See your script running

- See your script that you invoked: `sudo cat /var/lib/cloud/instances/instance-id/user-data.txt`
- See log output after invoking your script: `cat /var/log/cloud-init-output.log`

### Add a monitoring tool using terraform
- `https://docs.datadoghq.com/integrations/guide/aws-terraform-setup/`

### Tests done only on dev environment.