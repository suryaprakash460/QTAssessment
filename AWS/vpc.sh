# create vpc
aws ec2 create-vpc --cidr-block 10.0.0.0/16
# vpc id : vpc-0c5a02cbf3746f205

# create a subnet
aws ec2 create-subnet --cidr-block 10.0.0.0/24 --vpc-id vpc-0c5a02cbf3746f205
# subnet id : subnet-0a8ff3db85dbd13cb

# create route table
aws ec2 create-route-table --vpc-id vpc-0c5a02cbf3746f205
# route table id : rtb-0af6675a61983cbc3

# create internet gateway
aws ec2 create-internet-gateway
# "InternetGatewayId": "igw-012caa8b4816322c4"

# attach internet gateway to routetable
aws ec2 attach-internet-gateway --internet-gateway-id igw-012caa8b4816322c4 --vpc-id vpc-0c5a02cbf3746f205

# create route
aws ec2  create-route --route-table-id rtb-0af6675a61983cbc3 --destination-cidr-block 0.0.0.0/0 --gateway-id igw-012caa8b4816322c4

# subnet association
  aws ec2 associate-route-table --route-table-id rtb-0af6675a61983cbc3 --subnet-id subnet-0a8ff3db85dbd13cb 
  #  "AssociationId": "rtbassoc-0b5a109f1886b4457" 

# create security group
aws ec2 create-security-group --group-name MySecurityGroup --description "My security group" --vpc-id vpc-0c5a02cbf3746f205
#   "GroupId": "sg-03c9ca64cffaa67cd" 

# authorize security group
aws ec2 authorize-security-group-ingress --group-id sg-03c9ca64cffaa67cd --protocol tcp --port 22 --cidr 0.0.0.0/0

# launch instance in public subnet
aws ec2 run-instances --image-id ami-08692d171e3cf02d6 --count 1 --instance-type t2.micro --key-name oregon --security-group-ids sg-03c9ca64cffaa67cd --subnet-id subnet-0a8ff3db85dbd13cb --associate-public-ip-address
#  "InstanceId": "i-0de979a382298c62c"

