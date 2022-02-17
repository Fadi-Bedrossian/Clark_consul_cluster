# Clark_consul_cluster

Consul HA cluster contains the following resources:

1- VPC ( 3 public & 3 private subnets , 1 NAT GW , 1 internet GW, 1 route tables for each subnet  and their associations )
2- 1 bastion server with public ip and keypair
3- 3 server consul ec2 and associated security groups
4- 3 client consul ec2 and associated security groups
5- 1 classic LB "elb" for consul servers 

Please run the following commands to deploy the consul HA cluster:

1. cd Clark_Consul_cluster/Consul_cluster/my_project/myvpc
2. run terraform plan then terraform apply then wait till apply completes
3. cd ../mybastion
4. run terraform plan then terraform apply then wait till apply completes
5. cd ../myserver
6. run terraform plan then terraform apply then wait till apply completes
7. cd ../myclient
8. run terraform plan then terraform apply then wait till apply completes
