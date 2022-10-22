# sample_infrastructure

# Notes for Suraj
### automate the key-pair
### Make a security group seperately for db
### Make a security for logging into a box e.g. ssh-into box
### go to box inside, clone the repo, repo will instiate a docker container and runs the script


###  Resources

#### https://jhooq.com/terraform-ssh-into-aws-ec2/


### Step 1: Create key pair (pick rsa, .pem). Please name your key-pair as test_kp as that is what will be used in terraform. (The key pair will be shared either using password sharing tool like lastpass/OnePass or other aws secure mechanism.)
#### Follow this link https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-key-pairs.html

### Step 2: Configure aws. Export below to your terminal.
#### export AWS_ACCESS_KEY_ID=#####
#### export AWS_SECRET_ACCESS_KEY=####
#### export AWS_SESSION_TOKEN=####

#### Terraform init
#### terraform validate

### Notes:
#### I am allowing inbound rules to be from all 0.0.0.0/0 because I do not know your ip address. But this will be modified to specific ips so that security is not breached.
#### We can use modules created by other folks, i.e. remote modules.


